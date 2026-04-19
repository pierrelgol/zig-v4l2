const bindings = @import("bindings");
const std = @import("std");
const abi = @import("abi.zig");
const Pixel = @import("pixel.zig").Pixel;
const geometry = @import("geometry.zig");
const Rectangle = geometry.Rectangle;
const Fraction = geometry.Fraction;

comptime {
    std.testing.refAllDecls(@This());
}

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
    capability: u32,
    flags: u32,
    base: ?*anyopaque,
    format: Format,

    pub const Capability = struct {
        pub const externoverlay: u32 = @intCast(bindings.V4L2_FBUF_CAP_EXTERNOVERLAY);
        pub const chromakey: u32 = @intCast(bindings.V4L2_FBUF_CAP_CHROMAKEY);
        pub const list_clipping: u32 = @intCast(bindings.V4L2_FBUF_CAP_LIST_CLIPPING);
        pub const bitmap_clipping: u32 = @intCast(bindings.V4L2_FBUF_CAP_BITMAP_CLIPPING);
        pub const local_alpha: u32 = @intCast(bindings.V4L2_FBUF_CAP_LOCAL_ALPHA);
        pub const global_alpha: u32 = @intCast(bindings.V4L2_FBUF_CAP_GLOBAL_ALPHA);
        pub const local_inv_alpha: u32 = @intCast(bindings.V4L2_FBUF_CAP_LOCAL_INV_ALPHA);
        pub const src_chromakey: u32 = @intCast(bindings.V4L2_FBUF_CAP_SRC_CHROMAKEY);
    };

    pub const Flag = struct {
        pub const primary: u32 = @intCast(bindings.V4L2_FBUF_FLAG_PRIMARY);
        pub const overlay: u32 = @intCast(bindings.V4L2_FBUF_FLAG_OVERLAY);
        pub const chromakey: u32 = @intCast(bindings.V4L2_FBUF_FLAG_CHROMAKEY);
        pub const local_alpha: u32 = @intCast(bindings.V4L2_FBUF_FLAG_LOCAL_ALPHA);
        pub const global_alpha: u32 = @intCast(bindings.V4L2_FBUF_FLAG_GLOBAL_ALPHA);
        pub const local_inv_alpha: u32 = @intCast(bindings.V4L2_FBUF_FLAG_LOCAL_INV_ALPHA);
        pub const src_chromakey: u32 = @intCast(bindings.V4L2_FBUF_FLAG_SRC_CHROMAKEY);
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
        discrete = @intCast(bindings.V4L2_FRMSIZE_TYPE_DISCRETE),
        continuous = @intCast(bindings.V4L2_FRMSIZE_TYPE_CONTINUOUS),
        stepwise = @intCast(bindings.V4L2_FRMSIZE_TYPE_STEPWISE),
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
        discrete = @intCast(bindings.V4L2_FRMIVAL_TYPE_DISCRETE),
        continuous = @intCast(bindings.V4L2_FRMIVAL_TYPE_CONTINUOUS),
        step_wise = @intCast(bindings.V4L2_FRMIVAL_TYPE_STEPWISE),
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

test "Frame.Buffer.Format ABI matches struct_v4l2_pix_format" {
    const C = @FieldType(bindings.struct_v4l2_framebuffer, "fmt");
    const Z = Buffer.Format;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "width", .z_name = "width" },
        .{ .c_name = "height", .z_name = "height" },
        .{ .c_name = "pixelformat", .z_name = "pixel_format" },
        .{ .c_name = "field", .z_name = "field" },
        .{ .c_name = "bytesperline", .z_name = "bytes_per_line" },
        .{ .c_name = "sizeimage", .z_name = "size_image" },
        .{ .c_name = "colorspace", .z_name = "colorspace" },
        .{ .c_name = "priv", .z_name = "priv" },
    });
}
