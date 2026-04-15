const bindings = @import("bindings");
const std = @import("std");
const Fraction = @import("geometry.zig").Fraction;

pub const Standard = extern struct {
    index: u32,
    id: Id,
    name: [24]u8,
    frameperiod: Fraction,
    framelines: u32,
    reserved: [4]u32,

    pub const Id = u64;

    pub const Set = enum(Id) {
        pal_b = bindings.V4L2_STD_PAL_B,
        pal_b1 = bindings.V4L2_STD_PAL_B1,
        pal_g = bindings.V4L2_STD_PAL_G,
        pal_h = bindings.V4L2_STD_PAL_H,
        pal_i = bindings.V4L2_STD_PAL_I,
        pal_d = bindings.V4L2_STD_PAL_D,
        pal_d1 = bindings.V4L2_STD_PAL_D1,
        pal_k = bindings.V4L2_STD_PAL_K,
        pal_m = bindings.V4L2_STD_PAL_M,
        pal_n = bindings.V4L2_STD_PAL_N,
        pal_nc = bindings.V4L2_STD_PAL_Nc,
        pal_60 = bindings.V4L2_STD_PAL_60,
        ntsc_m = bindings.V4L2_STD_NTSC_M,
        ntsc_m_jp = bindings.V4L2_STD_NTSC_M_JP,
        ntsc_443 = bindings.V4L2_STD_NTSC_443,
        ntsc_m_kr = bindings.V4L2_STD_NTSC_M_KR,
        secam_b = bindings.V4L2_STD_SECAM_B,
        secam_d = bindings.V4L2_STD_SECAM_D,
        secam_g = bindings.V4L2_STD_SECAM_G,
        secam_h = bindings.V4L2_STD_SECAM_H,
        secam_k = bindings.V4L2_STD_SECAM_K,
        secam_k1 = bindings.V4L2_STD_SECAM_K1,
        secam_l = bindings.V4L2_STD_SECAM_L,
        secam_lc = bindings.V4L2_STD_SECAM_LC,
        atsc_8_vsb = bindings.V4L2_STD_ATSC_8_VSB,
        atsc_16_vsb = bindings.V4L2_STD_ATSC_16_VSB,
        ntsc = bindings.V4L2_STD_NTSC,
        secam_dk = bindings.V4L2_STD_SECAM_DK,
        secam = bindings.V4L2_STD_SECAM,
        pal_bg = bindings.V4L2_STD_PAL_BG,
        pal_dk = bindings.V4L2_STD_PAL_DK,
        pal = bindings.V4L2_STD_PAL,
        b = bindings.V4L2_STD_B,
        g = bindings.V4L2_STD_G,
        h = bindings.V4L2_STD_H,
        l = bindings.V4L2_STD_L,
        gh = bindings.V4L2_STD_GH,
        dk = bindings.V4L2_STD_DK,
        bg = bindings.V4L2_STD_BG,
        mn = bindings.V4L2_STD_MN,
        mts = bindings.V4L2_STD_MTS,
        @"525_60" = bindings.V4L2_STD_525_60,
        @"625_50" = bindings.V4L2_STD_625_50,
        atsc = bindings.V4L2_STD_ATSC,
        unknown = bindings.V4L2_STD_UNKNOWN,
        all = bindings.V4L2_STD_ALL,
    };
};

test "Standard ABI matches struct_v4l2_standard" {
    const C = bindings.struct_v4l2_standard;
    const Z = Standard;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "id"), @offsetOf(Z, "id"));
    try std.testing.expectEqual(@offsetOf(C, "name"), @offsetOf(Z, "name"));
    try std.testing.expectEqual(@offsetOf(C, "frameperiod"), @offsetOf(Z, "frameperiod"));
    try std.testing.expectEqual(@offsetOf(C, "framelines"), @offsetOf(Z, "framelines"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}
