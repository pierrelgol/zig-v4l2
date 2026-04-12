const std = @import("std");
const Io = std.Io;
const z4l2 = @import("z4l2");

fn stringFromArray(bytes: []const u8) []const u8 {
    const end = std.mem.indexOfScalar(u8, bytes, 0) orelse bytes.len;
    var trimmed_end = end;
    while (trimmed_end > 0 and bytes[trimmed_end - 1] == ' ') : (trimmed_end -= 1) {}
    return bytes[0..trimmed_end];
}

fn printVersion(writer: anytype, version: u32) !void {
    const major = (version >> 16) & 0xff;
    const minor = (version >> 8) & 0xff;
    const patch = version & 0xff;
    try writer.print("{d}.{d}.{d} (0x{x:0>8})", .{ major, minor, patch, version });
}

fn printCapabilityFlags(writer: anytype, bits: u32) !void {
    inline for (std.meta.fields(z4l2.Capability.Flag)) |field| {
        const value = @intFromEnum(@field(z4l2.Capability.Flag, field.name));
        if (value != 0 and (bits & value) == value) {
            try writer.print("    {s}\n", .{field.name});
        }
    }
}

fn queryCapability(io: Io, file: Io.File) !z4l2.Capability {
    var capability: z4l2.Capability = undefined;
    const rc = (try io.operate(.{ .device_io_control = .{
        .file = file,
        .code = z4l2.Ioctl.querycap,
        .arg = &capability,
    } })).device_io_control;

    if (rc >= 0) return capability;

    switch (@as(std.posix.E, @enumFromInt(@as(u16, @intCast(-rc))))) {
        .BADF => return error.FileDescriptorInvalid,
        .NOTTY => return error.NotV4l2Device,
        .INVAL => return error.NotV4l2Device,
        .NODEV => return error.DeviceNotFound,
        else => |err| return std.posix.unexpectedErrno(err),
    }
}

fn openDevice(io: Io, path: []const u8) !Io.File {
    return Io.Dir.openFileAbsolute(io, path, .{
        .mode = .read_only,
        .allow_directory = false,
    });
}

fn printUsage(writer: anytype, argv0: []const u8) !void {
    try writer.print("usage: {s} [device]\n", .{argv0});
    try writer.writeAll("default device: /dev/video0\n");
}

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const arena = init.arena.allocator();

    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = Io.File.stdout().writer(io, &stdout_buffer);
    const stdout = &stdout_writer.interface;

    var stderr_buffer: [256]u8 = undefined;
    var stderr_writer = Io.File.stderr().writer(io, &stderr_buffer);
    const stderr = &stderr_writer.interface;

    const args = try init.minimal.args.toSlice(arena);

    if (args.len > 2) {
        try printUsage(stderr, args[0]);
        try stderr.flush();
        return error.InvalidArguments;
    }

    const device_path = if (args.len == 2) args[1] else "/dev/video0";
    const file = try openDevice(io, device_path);
    defer file.close(io);

    const capability = try queryCapability(io, file);

    try stdout.print("Driver Info for {s}\n", .{device_path});
    try stdout.print("  driver:      {s}\n", .{stringFromArray(capability.driver[0..])});
    try stdout.print("  card:        {s}\n", .{stringFromArray(capability.card[0..])});
    try stdout.print("  bus_info:    {s}\n", .{stringFromArray(capability.bus_info[0..])});
    try stdout.writeAll("  version:     ");
    try printVersion(stdout, capability.version);
    try stdout.writeByte('\n');
    try stdout.print("  capabilities: 0x{x:0>8}\n", .{capability.capabilities});
    try printCapabilityFlags(stdout, capability.capabilities);
    try stdout.flush();
}
