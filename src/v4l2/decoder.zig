const bindings = @import("bindings");
const std = @import("std");

pub const Decoder = extern struct {
    cmd: Command,
    flags: u32,
    payload: extern union {
        stop: extern struct { pts: u64 },
        start: extern struct { speed: i32, format: u32 },
        raw: extern struct { data: [16]u32 },
    },

    pub const Command = enum(u32) {
        start = 0,
        stop = 1,
        pause = 2,
        @"resume" = 3,
        flush = 4,
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
        none = 0,
        gop = 1,
    };
};

test "Decoder ABI matches struct_v4l2_decoder_cmd" {
    const C = bindings.struct_v4l2_decoder_cmd;
    const Z = Decoder;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "cmd"), @offsetOf(Z, "cmd"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
}
