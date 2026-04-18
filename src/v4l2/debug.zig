const bindings = @import("bindings");
const std = @import("std");
const abi = @import("abi.zig");

comptime {
    std.testing.refAllDecls(@This());
}

pub const Match = extern struct {
    type: Type align(1),
    addr_or_name: extern union {
        addr: u32,
        name: [32]u8,
    } align(1),

    pub const Type = enum(u32) {
        bridge = @intCast(bindings.V4L2_CHIP_MATCH_BRIDGE),
        i2c_driver = @intCast(bindings.V4L2_CHIP_MATCH_I2C_DRIVER),
        i2c_addr = @intCast(bindings.V4L2_CHIP_MATCH_I2C_ADDR),
        ac97 = @intCast(bindings.V4L2_CHIP_MATCH_AC97),
        subdev = @intCast(bindings.V4L2_CHIP_MATCH_SUBDEV),
    };
};

pub const Register = extern struct {
    match: Match align(1),
    size: u32 align(1),
    reg: u64 align(1),
    val: u64 align(1),

    pub const Flag = enum(u32) {
        readable = @intCast(bindings.V4L2_CHIP_FL_READABLE),
        writable = @intCast(bindings.V4L2_CHIP_FL_WRITABLE),
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
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "type", .z_name = "type" },
        .{ .c_name = "unnamed_0", .z_name = "addr_or_name" },
    });
}

test "Debug.Match.addr_or_name ABI matches unnamed union in struct_v4l2_dbg_match" {
    const C = @FieldType(bindings.struct_v4l2_dbg_match, "unnamed_0");
    const Z = @FieldType(Match, "addr_or_name");
    try abi.expectUnion(C, Z, &.{
        .{ .c_name = "addr", .z_name = "addr" },
        .{ .c_name = "name", .z_name = "name" },
    });
}

test "Debug.Register ABI matches struct_v4l2_dbg_register" {
    const C = bindings.struct_v4l2_dbg_register;
    const Z = Register;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "match", .z_name = "match" },
        .{ .c_name = "size", .z_name = "size" },
        .{ .c_name = "reg", .z_name = "reg" },
        .{ .c_name = "val", .z_name = "val" },
    });
}

test "Debug.ChipInfo ABI matches struct_v4l2_dbg_chip_info" {
    const C = bindings.struct_v4l2_dbg_chip_info;
    const Z = ChipInfo;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "match", .z_name = "match" },
        .{ .c_name = "name", .z_name = "name" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}
