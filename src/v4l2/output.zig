const bindings = @import("bindings");
const std = @import("std");
const StdId = @import("standard.zig").Standard.Id;

comptime {
    std.testing.refAllDecls(@This());
}

pub const Output = extern struct {
    index: u32,
    name: [32]u8,
    type: Output.Type,
    audioset: u32,
    modulator: u32,
    std: StdId,
    capabilities: u32,
    reserved: [3]u32,

    pub const Type = enum(u32) {
        modulator = @intCast(bindings.V4L2_OUTPUT_TYPE_MODULATOR),
        analog = @intCast(bindings.V4L2_OUTPUT_TYPE_ANALOG),
        analogvgaoverlay = @intCast(bindings.V4L2_OUTPUT_TYPE_ANALOGVGAOVERLAY),
    };

    pub const Cap = enum(u32) {
        dv_timings = @intCast(bindings.V4L2_OUT_CAP_DV_TIMINGS),
        std = @intCast(bindings.V4L2_OUT_CAP_STD),
        native_size = @intCast(bindings.V4L2_OUT_CAP_NATIVE_SIZE),

        pub const custom_timings: Cap = .dv_timings;
    };
};

test "Output ABI matches struct_v4l2_output" {
    const C = bindings.struct_v4l2_output;
    const Z = Output;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "name"), @offsetOf(Z, "name"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "audioset"), @offsetOf(Z, "audioset"));
    try std.testing.expectEqual(@offsetOf(C, "modulator"), @offsetOf(Z, "modulator"));
    try std.testing.expectEqual(@offsetOf(C, "std"), @offsetOf(Z, "std"));
    try std.testing.expectEqual(@offsetOf(C, "capabilities"), @offsetOf(Z, "capabilities"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}
