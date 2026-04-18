const std = @import("std");

pub const Field = struct {
    c_name: []const u8,
    z_name: []const u8,
};

pub fn expectStruct(comptime C: type, comptime Z: type, comptime fields: []const Field) !void {
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));

    const c_info = @typeInfo(C).@"struct";
    const z_info = @typeInfo(Z).@"struct";
    try std.testing.expectEqual(fields.len, c_info.fields.len);
    try std.testing.expectEqual(fields.len, z_info.fields.len);

    inline for (fields) |field| {
        try expectField(C, Z, field.c_name, field.z_name);
    }
}

pub fn expectUnion(comptime C: type, comptime Z: type, comptime fields: []const Field) !void {
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));

    const c_info = @typeInfo(C).@"union";
    const z_info = @typeInfo(Z).@"union";
    try std.testing.expectEqual(fields.len, c_info.fields.len);
    try std.testing.expectEqual(fields.len, z_info.fields.len);

    inline for (fields) |field| {
        const CField = @FieldType(C, field.c_name);
        const ZField = @FieldType(Z, field.z_name);
        try std.testing.expectEqual(@sizeOf(CField), @sizeOf(ZField));
        try std.testing.expectEqual(@alignOf(CField), @alignOf(ZField));
        try std.testing.expectEqual(@bitSizeOf(CField), @bitSizeOf(ZField));
    }
}

pub fn expectField(comptime C: type, comptime Z: type, comptime c_name: []const u8, comptime z_name: []const u8) !void {
    const CField = @FieldType(C, c_name);
    const ZField = @FieldType(Z, z_name);

    try std.testing.expectEqual(@offsetOf(C, c_name), @offsetOf(Z, z_name));
    try std.testing.expectEqual(@sizeOf(CField), @sizeOf(ZField));
    try std.testing.expectEqual(@alignOf(CField), @alignOf(ZField));
    try std.testing.expectEqual(@bitSizeOf(CField), @bitSizeOf(ZField));
}

pub fn expectPackedStruct(comptime T: type, comptime Backing: type) !void {
    try std.testing.expectEqual(@sizeOf(Backing), @sizeOf(T));
    try std.testing.expectEqual(@alignOf(Backing), @alignOf(T));
    try std.testing.expectEqual(@bitSizeOf(Backing), @bitSizeOf(T));
}

pub fn expectPackedFlag(comptime T: type, comptime field_name: []const u8, expected_mask: anytype) !void {
    const Backing = switch (@typeInfo(T)) {
        .@"struct" => |info| info.backing_integer orelse @compileError("packed struct backing integer required"),
        else => @compileError("expectPackedFlag requires a packed struct"),
    };

    var value = std.mem.zeroes(T);
    @field(value, field_name) = true;
    try std.testing.expectEqual(@as(Backing, @intCast(expected_mask)), @as(Backing, @bitCast(value)));
}
