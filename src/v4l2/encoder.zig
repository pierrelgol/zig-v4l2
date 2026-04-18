const bindings = @import("bindings");
const std = @import("std");
const abi = @import("abi.zig");

comptime {
    std.testing.refAllDecls(@This());
}

pub const Encoder = extern struct {
    cmd: Command,
    flags: u32,
    raw: [8]u32,

    pub const Command = enum(u32) {
        start = @intCast(bindings.V4L2_ENC_CMD_START),
        stop = @intCast(bindings.V4L2_ENC_CMD_STOP),
        pause = @intCast(bindings.V4L2_ENC_CMD_PAUSE),
        @"resume" = @intCast(bindings.V4L2_ENC_CMD_RESUME),
    };

    pub const Flag = struct {
        pub const stop_at_gop_end: u32 = 1 << 0;
    };

    pub const Index = extern struct {
        entries: u32,
        entries_cap: u32,
        reserved: [4]u32,
        entry: [64]Entry,

        pub const Entry = extern struct {
            offset: u64,
            pts: u64,
            length: u32,
            flags: u32,
            reserved: [2]u32,

            pub const FrameType = struct {
                pub const i: u32 = @intCast(bindings.V4L2_ENC_IDX_FRAME_I);
                pub const p: u32 = @intCast(bindings.V4L2_ENC_IDX_FRAME_P);
                pub const b: u32 = @intCast(bindings.V4L2_ENC_IDX_FRAME_B);
                pub const mask: u32 = @intCast(bindings.V4L2_ENC_IDX_FRAME_MASK);
            };
        };
    };
};

test "Encoder ABI matches struct_v4l2_encoder_cmd" {
    const C = bindings.struct_v4l2_encoder_cmd;
    const Z = Encoder;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "cmd", .z_name = "cmd" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "unnamed_0", .z_name = "raw" },
    });
}

test "Encoder.Index ABI matches struct_v4l2_enc_idx" {
    const C = bindings.struct_v4l2_enc_idx;
    const Z = Encoder.Index;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "entries"), @offsetOf(Z, "entries"));
    try std.testing.expectEqual(@offsetOf(C, "entries_cap"), @offsetOf(Z, "entries_cap"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
    try std.testing.expectEqual(@offsetOf(C, "entry"), @offsetOf(Z, "entry"));
}

test "Encoder.Index.Entry ABI matches struct_v4l2_enc_idx_entry" {
    const C = bindings.struct_v4l2_enc_idx_entry;
    const Z = Encoder.Index.Entry;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "offset"), @offsetOf(Z, "offset"));
    try std.testing.expectEqual(@offsetOf(C, "pts"), @offsetOf(Z, "pts"));
    try std.testing.expectEqual(@offsetOf(C, "length"), @offsetOf(Z, "length"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}
