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
        pal_b = 0x00000001,
        pal_b1 = 0x00000002,
        pal_g = 0x00000004,
        pal_h = 0x00000008,
        pal_i = 0x00000010,
        pal_d = 0x00000020,
        pal_d1 = 0x00000040,
        pal_k = 0x00000080,
        pal_m = 0x00000100,
        pal_n = 0x00000200,
        pal_nc = 0x00000400,
        pal_60 = 0x00000800,
        ntsc_m = 0x00001000,
        ntsc_m_jp = 0x00002000,
        ntsc_443 = 0x00004000,
        ntsc_m_kr = 0x00008000,
        secam_b = 0x00010000,
        secam_d = 0x00020000,
        secam_g = 0x00040000,
        secam_h = 0x00080000,
        secam_k = 0x00100000,
        secam_k1 = 0x00200000,
        secam_l = 0x00400000,
        secam_lc = 0x00800000,
        atsc_8_vsb = 0x01000000,
        atsc_16_vsb = 0x02000000,
        ntsc = 0x0000b000,
        secam_dk = 0x00320000,
        secam = 0x00fd0000,
        pal_bg = 0x00000007,
        pal_dk = 0x000000e0,
        pal = 0x000000ff,
        b = 0x00010003,
        g = 0x00040004,
        h = 0x00080008,
        l = 0x00c00000,
        gh = 0x000c000c,
        dk = 0x003200e0,
        bg = 0x00050007,
        mn = 0x0000b700,
        mts = 0x0000b700,
        @"525_60" = 0x0000f900,
        @"625_50" = 0x00fd06ff,
        atsc = 0x03000000,
        unknown = 0,
        all = 0x00fdffff,
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
