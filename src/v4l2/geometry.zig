const bindings = @import("bindings");
const std = @import("std");

pub const Rectangle = extern struct {
    left: i32,
    top: i32,
    width: u32,
    height: u32,
};

pub const Fraction = extern struct {
    numerator: u32,
    denominator: u32,
};

pub const Area = extern struct {
    width: u32,
    height: u32,
};

test "Rectangle ABI matches struct_v4l2_rect" {
    const C = bindings.struct_v4l2_rect;
    const Z = Rectangle;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "left"), @offsetOf(Z, "left"));
    try std.testing.expectEqual(@offsetOf(C, "top"), @offsetOf(Z, "top"));
    try std.testing.expectEqual(@offsetOf(C, "width"), @offsetOf(Z, "width"));
    try std.testing.expectEqual(@offsetOf(C, "height"), @offsetOf(Z, "height"));
}

test "Fraction ABI matches struct_v4l2_fract" {
    const C = bindings.struct_v4l2_fract;
    const Z = Fraction;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "numerator"), @offsetOf(Z, "numerator"));
    try std.testing.expectEqual(@offsetOf(C, "denominator"), @offsetOf(Z, "denominator"));
}

test "Area ABI matches struct_v4l2_area" {
    const C = bindings.struct_v4l2_area;
    const Z = Area;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "width"), @offsetOf(Z, "width"));
    try std.testing.expectEqual(@offsetOf(C, "height"), @offsetOf(Z, "height"));
}
