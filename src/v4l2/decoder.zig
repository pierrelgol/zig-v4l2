const bindings = @import("bindings");
const std = @import("std");
const abi = @import("abi.zig");

comptime {
    std.testing.refAllDecls(@This());
}

pub const Decoder = extern struct {
    cmd: Command,
    flags: u32,
    payload: extern union {
        stop: extern struct { pts: u64 },
        start: extern struct { speed: i32, format: u32 },
        raw: extern struct { data: [16]u32 },
    },

    pub const Command = enum(u32) {
        start = @intCast(bindings.V4L2_DEC_CMD_START),
        stop = @intCast(bindings.V4L2_DEC_CMD_STOP),
        pause = @intCast(bindings.V4L2_DEC_CMD_PAUSE),
        @"resume" = @intCast(bindings.V4L2_DEC_CMD_RESUME),
        flush = @intCast(bindings.V4L2_DEC_CMD_FLUSH),
    };

    pub const StartFlag = struct {
        pub const mute_audio: u32 = 1 << 0;
    };

    pub const PauseFlag = struct {
        pub const to_black: u32 = 1 << 0;
    };

    pub const StopFlag = struct {
        pub const to_black: u32 = 1 << 0;
        pub const immediately: u32 = 1 << 1;
    };

    pub const StartFormat = enum(u32) {
        none = @intCast(bindings.V4L2_DEC_START_FMT_NONE),
        gop = @intCast(bindings.V4L2_DEC_START_FMT_GOP),
    };
};

test "Decoder ABI matches struct_v4l2_decoder_cmd" {
    const C = bindings.struct_v4l2_decoder_cmd;
    const Z = Decoder;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "cmd", .z_name = "cmd" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "unnamed_0", .z_name = "payload" },
    });
}

test "Decoder payload ABI matches unnamed union in struct_v4l2_decoder_cmd" {
    const C = @FieldType(bindings.struct_v4l2_decoder_cmd, "unnamed_0");
    const Z = @FieldType(Decoder, "payload");
    try abi.expectUnion(C, Z, &.{
        .{ .c_name = "stop", .z_name = "stop" },
        .{ .c_name = "start", .z_name = "start" },
        .{ .c_name = "raw", .z_name = "raw" },
    });
}
