const std = @import("std");
const c = @import("bindings");

const abi = @import("abi.zig");

comptime {
    std.testing.refAllDecls(@This());
}

pub const FrameFormat = extern struct {
    width: u32,
    height: u32,
    code: u32,
    field: u32,
    colorspace: u32,
    encoding: extern union {
        ycbcr: u16,
        hsv: u16,
    },
    quantization: u16,
    xfer_func: u16,
    flags: u16,
    reserved: [10]u16,

    pub const Flag = struct {
        pub const set_csc: u16 = @intCast(c.V4L2_MBUS_FRAMEFMT_SET_CSC);
    };
};

pub const PixelCode = enum(i32) {
    fixed = c.V4L2_MBUS_FMT_FIXED,
    rgb444_2x8_padhi_be = c.V4L2_MBUS_FMT_RGB444_2X8_PADHI_BE,
    rgb444_2x8_padhi_le = c.V4L2_MBUS_FMT_RGB444_2X8_PADHI_LE,
    rgb555_2x8_padhi_be = c.V4L2_MBUS_FMT_RGB555_2X8_PADHI_BE,
    rgb555_2x8_padhi_le = c.V4L2_MBUS_FMT_RGB555_2X8_PADHI_LE,
    bgr565_2x8_be = c.V4L2_MBUS_FMT_BGR565_2X8_BE,
    bgr565_2x8_le = c.V4L2_MBUS_FMT_BGR565_2X8_LE,
    rgb565_2x8_be = c.V4L2_MBUS_FMT_RGB565_2X8_BE,
    rgb565_2x8_le = c.V4L2_MBUS_FMT_RGB565_2X8_LE,
    rgb666_1x18 = c.V4L2_MBUS_FMT_RGB666_1X18,
    rgb888_1x24 = c.V4L2_MBUS_FMT_RGB888_1X24,
    rgb888_2x12_be = c.V4L2_MBUS_FMT_RGB888_2X12_BE,
    rgb888_2x12_le = c.V4L2_MBUS_FMT_RGB888_2X12_LE,
    argb8888_1x32 = c.V4L2_MBUS_FMT_ARGB8888_1X32,
    y8_1x8 = c.V4L2_MBUS_FMT_Y8_1X8,
    uv8_1x8 = c.V4L2_MBUS_FMT_UV8_1X8,
    uyvy8_1_5x8 = c.V4L2_MBUS_FMT_UYVY8_1_5X8,
    vyuy8_1_5x8 = c.V4L2_MBUS_FMT_VYUY8_1_5X8,
    yuyv8_1_5x8 = c.V4L2_MBUS_FMT_YUYV8_1_5X8,
    yvyu8_1_5x8 = c.V4L2_MBUS_FMT_YVYU8_1_5X8,
    uyvy8_2x8 = c.V4L2_MBUS_FMT_UYVY8_2X8,
    vyuy8_2x8 = c.V4L2_MBUS_FMT_VYUY8_2X8,
    yuyv8_2x8 = c.V4L2_MBUS_FMT_YUYV8_2X8,
    yvyu8_2x8 = c.V4L2_MBUS_FMT_YVYU8_2X8,
    y10_1x10 = c.V4L2_MBUS_FMT_Y10_1X10,
    uyvy10_2x10 = c.V4L2_MBUS_FMT_UYVY10_2X10,
    vyuy10_2x10 = c.V4L2_MBUS_FMT_VYUY10_2X10,
    yuyv10_2x10 = c.V4L2_MBUS_FMT_YUYV10_2X10,
    yvyu10_2x10 = c.V4L2_MBUS_FMT_YVYU10_2X10,
    y12_1x12 = c.V4L2_MBUS_FMT_Y12_1X12,
    uyvy8_1x16 = c.V4L2_MBUS_FMT_UYVY8_1X16,
    vyuy8_1x16 = c.V4L2_MBUS_FMT_VYUY8_1X16,
    yuyv8_1x16 = c.V4L2_MBUS_FMT_YUYV8_1X16,
    yvyu8_1x16 = c.V4L2_MBUS_FMT_YVYU8_1X16,
    ydyuydyv8_1x16 = c.V4L2_MBUS_FMT_YDYUYDYV8_1X16,
    uyvy10_1x20 = c.V4L2_MBUS_FMT_UYVY10_1X20,
    vyuy10_1x20 = c.V4L2_MBUS_FMT_VYUY10_1X20,
    yuyv10_1x20 = c.V4L2_MBUS_FMT_YUYV10_1X20,
    yvyu10_1x20 = c.V4L2_MBUS_FMT_YVYU10_1X20,
    yuv10_1x30 = c.V4L2_MBUS_FMT_YUV10_1X30,
    ayuv8_1x32 = c.V4L2_MBUS_FMT_AYUV8_1X32,
    uyvy12_2x12 = c.V4L2_MBUS_FMT_UYVY12_2X12,
    vyuy12_2x12 = c.V4L2_MBUS_FMT_VYUY12_2X12,
    yuyv12_2x12 = c.V4L2_MBUS_FMT_YUYV12_2X12,
    yvyu12_2x12 = c.V4L2_MBUS_FMT_YVYU12_2X12,
    uyvy12_1x24 = c.V4L2_MBUS_FMT_UYVY12_1X24,
    vyuy12_1x24 = c.V4L2_MBUS_FMT_VYUY12_1X24,
    yuyv12_1x24 = c.V4L2_MBUS_FMT_YUYV12_1X24,
    yvyu12_1x24 = c.V4L2_MBUS_FMT_YVYU12_1X24,
    sbggr8_1x8 = c.V4L2_MBUS_FMT_SBGGR8_1X8,
    sgbrg8_1x8 = c.V4L2_MBUS_FMT_SGBRG8_1X8,
    sgrbg8_1x8 = c.V4L2_MBUS_FMT_SGRBG8_1X8,
    srggb8_1x8 = c.V4L2_MBUS_FMT_SRGGB8_1X8,
    sbggr10_alaw8_1x8 = c.V4L2_MBUS_FMT_SBGGR10_ALAW8_1X8,
    sgbrg10_alaw8_1x8 = c.V4L2_MBUS_FMT_SGBRG10_ALAW8_1X8,
    sgrbg10_alaw8_1x8 = c.V4L2_MBUS_FMT_SGRBG10_ALAW8_1X8,
    srggb10_alaw8_1x8 = c.V4L2_MBUS_FMT_SRGGB10_ALAW8_1X8,
    sbggr10_dpcm8_1x8 = c.V4L2_MBUS_FMT_SBGGR10_DPCM8_1X8,
    sgbrg10_dpcm8_1x8 = c.V4L2_MBUS_FMT_SGBRG10_DPCM8_1X8,
    sgrbg10_dpcm8_1x8 = c.V4L2_MBUS_FMT_SGRBG10_DPCM8_1X8,
    srggb10_dpcm8_1x8 = c.V4L2_MBUS_FMT_SRGGB10_DPCM8_1X8,
    sbggr10_2x8_padhi_be = c.V4L2_MBUS_FMT_SBGGR10_2X8_PADHI_BE,
    sbggr10_2x8_padhi_le = c.V4L2_MBUS_FMT_SBGGR10_2X8_PADHI_LE,
    sbggr10_2x8_padlo_be = c.V4L2_MBUS_FMT_SBGGR10_2X8_PADLO_BE,
    sbggr10_2x8_padlo_le = c.V4L2_MBUS_FMT_SBGGR10_2X8_PADLO_LE,
    sbggr10_1x10 = c.V4L2_MBUS_FMT_SBGGR10_1X10,
    sgbrg10_1x10 = c.V4L2_MBUS_FMT_SGBRG10_1X10,
    sgrbg10_1x10 = c.V4L2_MBUS_FMT_SGRBG10_1X10,
    srggb10_1x10 = c.V4L2_MBUS_FMT_SRGGB10_1X10,
    sbggr12_1x12 = c.V4L2_MBUS_FMT_SBGGR12_1X12,
    sgbrg12_1x12 = c.V4L2_MBUS_FMT_SGBRG12_1X12,
    sgrbg12_1x12 = c.V4L2_MBUS_FMT_SGRBG12_1X12,
    srggb12_1x12 = c.V4L2_MBUS_FMT_SRGGB12_1X12,
    jpeg_1x8 = c.V4L2_MBUS_FMT_JPEG_1X8,
    s5c_uyvy_jpeg_1x8 = c.V4L2_MBUS_FMT_S5C_UYVY_JPEG_1X8,
    ahsv8888_1x32 = c.V4L2_MBUS_FMT_AHSV8888_1X32,
};

test "Mediabus.FrameFormat ABI matches struct_v4l2_mbus_framefmt" {
    const C = c.struct_v4l2_mbus_framefmt;
    const Z = FrameFormat;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "width", .z_name = "width" },
        .{ .c_name = "height", .z_name = "height" },
        .{ .c_name = "code", .z_name = "code" },
        .{ .c_name = "field", .z_name = "field" },
        .{ .c_name = "colorspace", .z_name = "colorspace" },
        .{ .c_name = "unnamed_0", .z_name = "encoding" },
        .{ .c_name = "quantization", .z_name = "quantization" },
        .{ .c_name = "xfer_func", .z_name = "xfer_func" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Mediabus.FrameFormat.encoding ABI matches unnamed union in struct_v4l2_mbus_framefmt" {
    const C = @FieldType(c.struct_v4l2_mbus_framefmt, "unnamed_0");
    const Z = @FieldType(FrameFormat, "encoding");
    try abi.expectUnion(C, Z, &.{
        .{ .c_name = "ycbcr_enc", .z_name = "ycbcr" },
        .{ .c_name = "hsv_enc", .z_name = "hsv" },
    });
}

test "Mediabus constants match linux/v4l2-mediabus.h" {
    try std.testing.expectEqual(@as(u16, @intCast(c.V4L2_MBUS_FRAMEFMT_SET_CSC)), FrameFormat.Flag.set_csc);
    try std.testing.expectEqual(c.V4L2_MBUS_FMT_FIXED, @intFromEnum(PixelCode.fixed));
    try std.testing.expectEqual(c.V4L2_MBUS_FMT_RGB888_1X24, @intFromEnum(PixelCode.rgb888_1x24));
    try std.testing.expectEqual(c.V4L2_MBUS_FMT_YUYV8_2X8, @intFromEnum(PixelCode.yuyv8_2x8));
    try std.testing.expectEqual(c.V4L2_MBUS_FMT_SRGGB12_1X12, @intFromEnum(PixelCode.srggb12_1x12));
    try std.testing.expectEqual(c.V4L2_MBUS_FMT_JPEG_1X8, @intFromEnum(PixelCode.jpeg_1x8));
}
