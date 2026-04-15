const bindings = @import("bindings");
const std = @import("std");

pub const Match = extern struct {
    type: Type align(1),
    addr_or_name: extern union {
        addr: u32,
        name: [32]u8,
    } align(1),

    pub const Type = enum(u32) {
        bridge = 0,
        i2c_driver = 1,
        i2c_addr = 2,
        ac97 = 3,
        subdev = 4,
    };
};

pub const Register = extern struct {
    match: Match align(1),
    size: u32 align(1),
    reg: u64 align(1),
    val: u64 align(1),

    pub const Flag = enum(u32) {
        readable = 1 << 0,
        writable = 1 << 1,
    };
};

pub const ChipInfo = extern struct {
    match: Match align(1),
    name: [32]u8,
    flags: u32 align(1),
    reserved: [32]u32 align(1),
};

test "Debug.Match ABI matches struct_v4l2_dbg_match" {
    const C = bindings.struct_v4l2_dbg_match;
    const Z = Match;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
}

test "Debug.Register ABI matches struct_v4l2_dbg_register" {
    const C = bindings.struct_v4l2_dbg_register;
    const Z = Register;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "match"), @offsetOf(Z, "match"));
    try std.testing.expectEqual(@offsetOf(C, "size"), @offsetOf(Z, "size"));
    try std.testing.expectEqual(@offsetOf(C, "reg"), @offsetOf(Z, "reg"));
    try std.testing.expectEqual(@offsetOf(C, "val"), @offsetOf(Z, "val"));
}

test "Debug.ChipInfo ABI matches struct_v4l2_dbg_chip_info" {
    const C = bindings.struct_v4l2_dbg_chip_info;
    const Z = ChipInfo;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "match"), @offsetOf(Z, "match"));
    try std.testing.expectEqual(@offsetOf(C, "name"), @offsetOf(Z, "name"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}
