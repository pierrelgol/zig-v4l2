const bindings = @import("bindings");
const std = @import("std");
const Pixel = @import("pixel.zig").Pixel;
const geometry = @import("geometry.zig");
const Rectangle = geometry.Rectangle;
const Fraction = geometry.Fraction;

pub const Frame = @This();

pub const Clip = extern struct {
    rectangle: Rectangle,
    next: ?*Clip,
};

pub const Window = extern struct {
    rectangle: Rectangle,
    field: Pixel.Field,
    chromakey: u32,
    clips: ?*Clip,
    clip_count: u32,
    bitmap: ?*anyopaque,
    global_alpha: u8,
};

pub const Buffer = extern struct {
    capability: Capability,
    flags: Flag,
    base: ?*anyopaque,
    format: Format,

    pub const Capability = enum(u32) {
        externoverlay = 0x0001,
        chromakey = 0x0002,
        list_clipping = 0x0004,
        bitmap_clipping = 0x0008,
        local_alpha = 0x0010,
        global_alpha = 0x0020,
        local_inv_alpha = 0x0040,
        src_chromakey = 0x0080,
    };

    pub const Flag = enum(u32) {
        primary = 0x0001,
        overlay = 0x0002,
        chromakey = 0x0004,
        local_alpha = 0x0008,
        global_alpha = 0x0010,
        local_inv_alpha = 0x0020,
        src_chromakey = 0x0040,
    };

    pub const Format = extern struct {
        width: u32,
        height: u32,
        pixel_format: Pixel.Format,
        field: Pixel.Field,
        bytes_per_line: u32,
        size_image: u32,
        colorspace: Pixel.Colorspace,
        priv: u32,
    };
};

pub const Size = extern struct {
    index: u32,
    pixel_format: Pixel.Format,
    type: Type,
    size: extern union {
        discrete: Discrete,
        step_wise: StepWise,
    },
    reserved: [2]u32,

    pub const Type = enum(u32) {
        discrete = 1,
        continuous = 2,
        stepwise = 3,
    };

    pub const Discrete = extern struct {
        width: u32,
        height: u32,
    };

    pub const StepWise = extern struct {
        min_width: u32,
        max_width: u32,
        step_width: u32,
        min_height: u32,
        max_height: u32,
        step_height: u32,
    };
};

pub const Interval = extern struct {
    index: u32,
    pixel_format: Pixel.Format,
    width: u32,
    height: u32,
    type: Type,
    interval: extern union {
        discrete: Fraction,
        step_wise: StepWise,
    },
    reserved: [2]u32,

    pub const Type = enum(u32) {
        discrete = 1,
        continuous = 2,
        step_wise = 3,
        _,
    };

    pub const StepWise = extern struct {
        min: Fraction,
        max: Fraction,
        step: Fraction,
    };
};

test "Frame.Clip ABI matches struct_v4l2_clip" {
    const C = bindings.struct_v4l2_clip;
    const Z = Clip;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "c"), @offsetOf(Z, "rectangle"));
    try std.testing.expectEqual(@offsetOf(C, "next"), @offsetOf(Z, "next"));
}

test "Frame.Window ABI matches struct_v4l2_window" {
    const C = bindings.struct_v4l2_window;
    const Z = Window;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "w"), @offsetOf(Z, "rectangle"));
    try std.testing.expectEqual(@offsetOf(C, "field"), @offsetOf(Z, "field"));
    try std.testing.expectEqual(@offsetOf(C, "chromakey"), @offsetOf(Z, "chromakey"));
    try std.testing.expectEqual(@offsetOf(C, "clips"), @offsetOf(Z, "clips"));
    try std.testing.expectEqual(@offsetOf(C, "clipcount"), @offsetOf(Z, "clip_count"));
    try std.testing.expectEqual(@offsetOf(C, "bitmap"), @offsetOf(Z, "bitmap"));
    try std.testing.expectEqual(@offsetOf(C, "global_alpha"), @offsetOf(Z, "global_alpha"));
}

test "Frame.Buffer ABI matches struct_v4l2_framebuffer" {
    const C = bindings.struct_v4l2_framebuffer;
    const Z = Buffer;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "capability"), @offsetOf(Z, "capability"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "base"), @offsetOf(Z, "base"));
    try std.testing.expectEqual(@offsetOf(C, "fmt"), @offsetOf(Z, "format"));
}

test "Frame.Size ABI matches struct_v4l2_frmsizeenum" {
    const C = bindings.struct_v4l2_frmsizeenum;
    const Z = Size;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "pixel_format"), @offsetOf(Z, "pixel_format"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "unnamed_0"), @offsetOf(Z, "size"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Frame.Size.Discrete ABI matches struct_v4l2_frmsize_discrete" {
    const C = bindings.struct_v4l2_frmsize_discrete;
    const Z = Size.Discrete;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "width"), @offsetOf(Z, "width"));
    try std.testing.expectEqual(@offsetOf(C, "height"), @offsetOf(Z, "height"));
}

test "Frame.Size.StepWise ABI matches struct_v4l2_frmsize_stepwise" {
    const C = bindings.struct_v4l2_frmsize_stepwise;
    const Z = Size.StepWise;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "min_width"), @offsetOf(Z, "min_width"));
    try std.testing.expectEqual(@offsetOf(C, "max_width"), @offsetOf(Z, "max_width"));
    try std.testing.expectEqual(@offsetOf(C, "step_width"), @offsetOf(Z, "step_width"));
    try std.testing.expectEqual(@offsetOf(C, "min_height"), @offsetOf(Z, "min_height"));
    try std.testing.expectEqual(@offsetOf(C, "max_height"), @offsetOf(Z, "max_height"));
    try std.testing.expectEqual(@offsetOf(C, "step_height"), @offsetOf(Z, "step_height"));
}

test "Frame.Interval ABI matches struct_v4l2_frmivalenum" {
    const C = bindings.struct_v4l2_frmivalenum;
    const Z = Interval;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "pixel_format"), @offsetOf(Z, "pixel_format"));
    try std.testing.expectEqual(@offsetOf(C, "width"), @offsetOf(Z, "width"));
    try std.testing.expectEqual(@offsetOf(C, "height"), @offsetOf(Z, "height"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "unnamed_0"), @offsetOf(Z, "interval"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Frame.Interval.StepWise ABI matches struct_v4l2_frmival_stepwise" {
    const C = bindings.struct_v4l2_frmival_stepwise;
    const Z = Interval.StepWise;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "min"), @offsetOf(Z, "min"));
    try std.testing.expectEqual(@offsetOf(C, "max"), @offsetOf(Z, "max"));
    try std.testing.expectEqual(@offsetOf(C, "step"), @offsetOf(Z, "step"));
}
