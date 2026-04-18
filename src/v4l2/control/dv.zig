const c = @import("bindings");
const std = @import("std");
pub const dv = @This();

comptime {
    std.testing.refAllDecls(@This());
}

pub const base: u32 = c.V4L2_CID_DV_CLASS_BASE;
pub const class: u32 = c.V4L2_CID_DV_CLASS;

pub const tx = struct {
    pub const hotplug = struct {
        pub const id: u32 = c.V4L2_CID_DV_TX_HOTPLUG;
    };
    pub const rxsense = struct {
        pub const id: u32 = c.V4L2_CID_DV_TX_RXSENSE;
    };
    pub const edid_present = struct {
        pub const id: u32 = c.V4L2_CID_DV_TX_EDID_PRESENT;
    };

    pub const TxMode = enum(i32) {
        pub const id: u32 = c.V4L2_CID_DV_TX_MODE;
        dvi_d = c.V4L2_DV_TX_MODE_DVI_D,
        hdmi = c.V4L2_DV_TX_MODE_HDMI,
    };

    pub const RgbRange = enum(i32) {
        pub const id: u32 = c.V4L2_CID_DV_TX_RGB_RANGE;
        auto = c.V4L2_DV_RGB_RANGE_AUTO,
        limited = c.V4L2_DV_RGB_RANGE_LIMITED,
        full = c.V4L2_DV_RGB_RANGE_FULL,
    };

    pub const ItContentType = enum(i32) {
        pub const id: u32 = c.V4L2_CID_DV_TX_IT_CONTENT_TYPE;
        graphics = c.V4L2_DV_IT_CONTENT_TYPE_GRAPHICS,
        photo = c.V4L2_DV_IT_CONTENT_TYPE_PHOTO,
        cinema = c.V4L2_DV_IT_CONTENT_TYPE_CINEMA,
        game = c.V4L2_DV_IT_CONTENT_TYPE_GAME,
        no_itc = c.V4L2_DV_IT_CONTENT_TYPE_NO_ITC,
    };
};

pub const rx = struct {
    pub const power_present = struct {
        pub const id: u32 = c.V4L2_CID_DV_RX_POWER_PRESENT;
    };
    pub const rgb_range = struct {
        pub const id: u32 = c.V4L2_CID_DV_RX_RGB_RANGE;
    };
    pub const it_content_type = struct {
        pub const id: u32 = c.V4L2_CID_DV_RX_IT_CONTENT_TYPE;
    };
};
