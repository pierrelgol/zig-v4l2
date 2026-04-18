const bindings = @import("bindings");
const std = @import("std");

comptime {
    std.testing.refAllDecls(@This());
}

pub const Audio = extern struct {
    index: u32,
    name: [32]u8,
    capability: u32,
    mode: u32,
    reserved: [2]u32,

    pub const Capability = enum(u32) {
        stereo = @intCast(bindings.V4L2_AUDCAP_STEREO),
        avl = @intCast(bindings.V4L2_AUDCAP_AVL),
    };

    pub const Mode = enum(u32) {
        avl = @intCast(bindings.V4L2_AUDMODE_AVL),
    };

    pub const Output = extern struct {
        index: u32,
        name: [32]u8,
        capability: u32,
        mode: u32,
        reserved: [2]u32,
    };

    pub const Rds = extern struct {
        lsb: u8,
        msb: u8,
        block: u8,

        pub const Block = enum(u8) {
            a = @intCast(bindings.V4L2_RDS_BLOCK_A),
            b = @intCast(bindings.V4L2_RDS_BLOCK_B),
            c = @intCast(bindings.V4L2_RDS_BLOCK_C),
            d = @intCast(bindings.V4L2_RDS_BLOCK_D),
            c_alt = @intCast(bindings.V4L2_RDS_BLOCK_C_ALT),
            invalid = @intCast(bindings.V4L2_RDS_BLOCK_INVALID),

            pub const msk: u8 = @intCast(bindings.V4L2_RDS_BLOCK_MSK);
            pub const corrected: u8 = @intCast(bindings.V4L2_RDS_BLOCK_CORRECTED);
            pub const @"error": u8 = @intCast(bindings.V4L2_RDS_BLOCK_ERROR);
        };
    };
};

test "Audio ABI matches struct_v4l2_audio" {
    const C = bindings.struct_v4l2_audio;
    const Z = Audio;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "name"), @offsetOf(Z, "name"));
    try std.testing.expectEqual(@offsetOf(C, "capability"), @offsetOf(Z, "capability"));
    try std.testing.expectEqual(@offsetOf(C, "mode"), @offsetOf(Z, "mode"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Audio.Output ABI matches struct_v4l2_audioout" {
    const C = bindings.struct_v4l2_audioout;
    const Z = Audio.Output;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "name"), @offsetOf(Z, "name"));
    try std.testing.expectEqual(@offsetOf(C, "capability"), @offsetOf(Z, "capability"));
    try std.testing.expectEqual(@offsetOf(C, "mode"), @offsetOf(Z, "mode"));
}

test "Audio.Rds ABI matches struct_v4l2_rds_data" {
    const C = bindings.struct_v4l2_rds_data;
    const Z = Audio.Rds;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "lsb"), @offsetOf(Z, "lsb"));
    try std.testing.expectEqual(@offsetOf(C, "msb"), @offsetOf(Z, "msb"));
    try std.testing.expectEqual(@offsetOf(C, "block"), @offsetOf(Z, "block"));
}
