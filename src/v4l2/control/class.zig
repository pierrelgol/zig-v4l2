const c = @import("bindings");
const std = @import("std");

comptime {
    std.testing.refAllDecls(@This());
}

pub const base: u32 = c.V4L2_CID_BASE;
pub const lastp1: u32 = c.V4L2_CID_LASTP1;

pub const Class = enum(u32) {
    user = c.V4L2_CTRL_CLASS_USER,
    codec = c.V4L2_CTRL_CLASS_CODEC,
    camera = c.V4L2_CTRL_CLASS_CAMERA,
    fm_tx = c.V4L2_CTRL_CLASS_FM_TX,
    flash = c.V4L2_CTRL_CLASS_FLASH,
    jpeg = c.V4L2_CTRL_CLASS_JPEG,
    image_source = c.V4L2_CTRL_CLASS_IMAGE_SOURCE,
    image_proc = c.V4L2_CTRL_CLASS_IMAGE_PROC,
    dv = c.V4L2_CTRL_CLASS_DV,
    fm_rx = c.V4L2_CTRL_CLASS_FM_RX,
    rf_tuner = c.V4L2_CTRL_CLASS_RF_TUNER,
    detect = c.V4L2_CTRL_CLASS_DETECT,
    codec_stateless = c.V4L2_CTRL_CLASS_CODEC_STATELESS,
    colorimetry = c.V4L2_CTRL_CLASS_COLORIMETRY,
};

pub const codec = struct {
    pub const base: u32 = c.V4L2_CID_CODEC_BASE;
    pub const class: u32 = c.V4L2_CID_CODEC_CLASS;
};
