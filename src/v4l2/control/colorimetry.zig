const c = @import("bindings");
pub const colorimetry = @This();
const std = @import("std");

comptime {
    std.testing.refAllDecls(@This());
}

pub const base: u32 = c.V4L2_CID_COLORIMETRY_CLASS_BASE;
pub const class: u32 = c.V4L2_CID_COLORIMETRY_CLASS;

pub const hdr10_cll_info = struct {
    pub const id: u32 = c.V4L2_CID_COLORIMETRY_HDR10_CLL_INFO;
};

pub const hdr10_mastering_display = struct {
    pub const id: u32 = c.V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY;

    pub const Primaries = enum(i32) {
        x_low = c.V4L2_HDR10_MASTERING_PRIMARIES_X_LOW,
        x_high = c.V4L2_HDR10_MASTERING_PRIMARIES_X_HIGH,
        y_low = c.V4L2_HDR10_MASTERING_PRIMARIES_Y_LOW,
        y_high = c.V4L2_HDR10_MASTERING_PRIMARIES_Y_HIGH,
    };

    pub const WhitePoint = enum(i32) {
        x_low = c.V4L2_HDR10_MASTERING_WHITE_POINT_X_LOW,
        x_high = c.V4L2_HDR10_MASTERING_WHITE_POINT_X_HIGH,
        y_low = c.V4L2_HDR10_MASTERING_WHITE_POINT_Y_LOW,
        y_high = c.V4L2_HDR10_MASTERING_WHITE_POINT_Y_HIGH,
    };

    pub const Luma = enum(i32) {
        max_luma_low = c.V4L2_HDR10_MASTERING_MAX_LUMA_LOW,
        max_luma_high = c.V4L2_HDR10_MASTERING_MAX_LUMA_HIGH,
        min_luma_low = c.V4L2_HDR10_MASTERING_MIN_LUMA_LOW,
        min_luma_high = c.V4L2_HDR10_MASTERING_MIN_LUMA_HIGH,
    };
};
