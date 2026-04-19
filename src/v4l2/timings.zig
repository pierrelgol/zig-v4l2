const bindings = @import("bindings");
const std = @import("std");
const Fraction = @import("geometry.zig").Fraction;

comptime {
    std.testing.refAllDecls(@This());
}

pub const Blanking = extern struct {
    width: u32 align(1),
    height: u32 align(1),
    interlaced: u32 align(1),
    polarities: u32 align(1),
    pixelclock: u64 align(1),
    hfrontporch: u32 align(1),
    hsync: u32 align(1),
    hbackporch: u32 align(1),
    vfrontporch: u32 align(1),
    vsync: u32 align(1),
    vbackporch: u32 align(1),
    il_vfrontporch: u32 align(1),
    il_vsync: u32 align(1),
    il_vbackporch: u32 align(1),
    standards: u32 align(1),
    flags: u32 align(1),
    picture_aspect: Fraction align(1),
    cea861_vic: u8,
    hdmi_vic: u8,
    reserved: [46]u8,

    pub const Interlaced = enum(u32) {
        progressive = @intCast(bindings.V4L2_DV_PROGRESSIVE),
        interlaced = @intCast(bindings.V4L2_DV_INTERLACED),
    };

    pub const Polarity = struct {
        pub const vsync_pos: u32 = @intCast(bindings.V4L2_DV_VSYNC_POS_POL);
        pub const hsync_pos: u32 = @intCast(bindings.V4L2_DV_HSYNC_POS_POL);
    };

    pub const Standard = struct {
        pub const cea861: u32 = @intCast(bindings.V4L2_DV_BT_STD_CEA861);
        pub const dmt: u32 = @intCast(bindings.V4L2_DV_BT_STD_DMT);
        pub const cvt: u32 = @intCast(bindings.V4L2_DV_BT_STD_CVT);
        pub const gtf: u32 = @intCast(bindings.V4L2_DV_BT_STD_GTF);
        pub const sdi: u32 = @intCast(bindings.V4L2_DV_BT_STD_SDI);
    };

    pub const Flag = struct {
        pub const reduced_blanking: u32 = @intCast(bindings.V4L2_DV_FL_REDUCED_BLANKING);
        pub const can_reduce_fps: u32 = @intCast(bindings.V4L2_DV_FL_CAN_REDUCE_FPS);
        pub const reduced_fps: u32 = @intCast(bindings.V4L2_DV_FL_REDUCED_FPS);
        pub const half_line: u32 = @intCast(bindings.V4L2_DV_FL_HALF_LINE);
        pub const is_ce_video: u32 = @intCast(bindings.V4L2_DV_FL_IS_CE_VIDEO);
        pub const first_field_extra_line: u32 = @intCast(bindings.V4L2_DV_FL_FIRST_FIELD_EXTRA_LINE);
        pub const has_picture_aspect: u32 = @intCast(bindings.V4L2_DV_FL_HAS_PICTURE_ASPECT);
        pub const has_cea861_vic: u32 = @intCast(bindings.V4L2_DV_FL_HAS_CEA861_VIC);
        pub const has_hdmi_vic: u32 = @intCast(bindings.V4L2_DV_FL_HAS_HDMI_VIC);
        pub const can_detect_reduced_fps: u32 = @intCast(bindings.V4L2_DV_FL_CAN_DETECT_REDUCED_FPS);
    };

    pub const Capability = struct {
        pub const interlaced: u32 = @intCast(bindings.V4L2_DV_BT_CAP_INTERLACED);
        pub const progressive: u32 = @intCast(bindings.V4L2_DV_BT_CAP_PROGRESSIVE);
        pub const reduced_blanking: u32 = @intCast(bindings.V4L2_DV_BT_CAP_REDUCED_BLANKING);
        pub const custom: u32 = @intCast(bindings.V4L2_DV_BT_CAP_CUSTOM);
    };
};

pub const DigitalVideo = extern struct {
    type: Kind align(1),
    bt: extern union {
        bt: Blanking,
        reserved: [32]u32,
    } align(1),

    pub const Kind = enum(u32) {
        bt_656_1120 = @intCast(bindings.V4L2_DV_BT_656_1120),
    };
};

pub const Enumeration = extern struct {
    index: u32,
    pad: u32,
    reserved: [2]u32,
    timings: DigitalVideo,
};

pub const BlankingCapabilities = extern struct {
    min_width: u32 align(1),
    max_width: u32 align(1),
    min_height: u32 align(1),
    max_height: u32 align(1),
    min_pixelclock: u64 align(1),
    max_pixelclock: u64 align(1),
    standards: u32 align(1),
    capabilities: u32 align(1),
    reserved: [16]u32 align(1),
};

pub const DigitalVideoCapabilities = extern struct {
    type: u32,
    pad: u32,
    reserved: [2]u32,
    bt: extern union {
        bt: BlankingCapabilities,
        raw_data: [32]u32,
    },
};

test "Blanking ABI matches struct_v4l2_bt_timings" {
    const C = bindings.struct_v4l2_bt_timings;
    const Z = Blanking;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "width"), @offsetOf(Z, "width"));
    try std.testing.expectEqual(@offsetOf(C, "height"), @offsetOf(Z, "height"));
    try std.testing.expectEqual(@offsetOf(C, "interlaced"), @offsetOf(Z, "interlaced"));
    try std.testing.expectEqual(@offsetOf(C, "polarities"), @offsetOf(Z, "polarities"));
    try std.testing.expectEqual(@offsetOf(C, "pixelclock"), @offsetOf(Z, "pixelclock"));
    try std.testing.expectEqual(@offsetOf(C, "hfrontporch"), @offsetOf(Z, "hfrontporch"));
    try std.testing.expectEqual(@offsetOf(C, "hsync"), @offsetOf(Z, "hsync"));
    try std.testing.expectEqual(@offsetOf(C, "hbackporch"), @offsetOf(Z, "hbackporch"));
    try std.testing.expectEqual(@offsetOf(C, "vfrontporch"), @offsetOf(Z, "vfrontporch"));
    try std.testing.expectEqual(@offsetOf(C, "vsync"), @offsetOf(Z, "vsync"));
    try std.testing.expectEqual(@offsetOf(C, "vbackporch"), @offsetOf(Z, "vbackporch"));
    try std.testing.expectEqual(@offsetOf(C, "il_vfrontporch"), @offsetOf(Z, "il_vfrontporch"));
    try std.testing.expectEqual(@offsetOf(C, "il_vsync"), @offsetOf(Z, "il_vsync"));
    try std.testing.expectEqual(@offsetOf(C, "il_vbackporch"), @offsetOf(Z, "il_vbackporch"));
    try std.testing.expectEqual(@offsetOf(C, "standards"), @offsetOf(Z, "standards"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "picture_aspect"), @offsetOf(Z, "picture_aspect"));
    try std.testing.expectEqual(@offsetOf(C, "cea861_vic"), @offsetOf(Z, "cea861_vic"));
    try std.testing.expectEqual(@offsetOf(C, "hdmi_vic"), @offsetOf(Z, "hdmi_vic"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "DigitalVideo ABI matches struct_v4l2_dv_timings" {
    const C = bindings.struct_v4l2_dv_timings;
    const Z = DigitalVideo;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
}

test "Enumeration ABI matches struct_v4l2_enum_dv_timings" {
    const C = bindings.struct_v4l2_enum_dv_timings;
    const Z = Enumeration;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "pad"), @offsetOf(Z, "pad"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
    try std.testing.expectEqual(@offsetOf(C, "timings"), @offsetOf(Z, "timings"));
}

test "BlankingCapabilities ABI matches struct_v4l2_bt_timings_cap" {
    const C = bindings.struct_v4l2_bt_timings_cap;
    const Z = BlankingCapabilities;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "min_width"), @offsetOf(Z, "min_width"));
    try std.testing.expectEqual(@offsetOf(C, "max_width"), @offsetOf(Z, "max_width"));
    try std.testing.expectEqual(@offsetOf(C, "min_height"), @offsetOf(Z, "min_height"));
    try std.testing.expectEqual(@offsetOf(C, "max_height"), @offsetOf(Z, "max_height"));
    try std.testing.expectEqual(@offsetOf(C, "min_pixelclock"), @offsetOf(Z, "min_pixelclock"));
    try std.testing.expectEqual(@offsetOf(C, "max_pixelclock"), @offsetOf(Z, "max_pixelclock"));
    try std.testing.expectEqual(@offsetOf(C, "standards"), @offsetOf(Z, "standards"));
    try std.testing.expectEqual(@offsetOf(C, "capabilities"), @offsetOf(Z, "capabilities"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "DigitalVideoCapabilities ABI matches struct_v4l2_dv_timings_cap" {
    const C = bindings.struct_v4l2_dv_timings_cap;
    const Z = DigitalVideoCapabilities;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "pad"), @offsetOf(Z, "pad"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}
