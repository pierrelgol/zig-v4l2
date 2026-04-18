const c = @import("bindings");
const std = @import("std");

comptime {
    std.testing.refAllDecls(@This());
}

pub const base: u32 = c.V4L2_CID_CODEC_STATELESS_BASE;
pub const class: u32 = c.V4L2_CID_CODEC_STATELESS_CLASS;

pub const h264 = @import("h264.zig").h264;
pub const hevc = @import("hevc.zig").hevc;
pub const vp8 = @import("vp8.zig").vp8;
pub const vp9 = @import("vp9.zig").vp9;
pub const mpeg2 = @import("mpeg2.zig").mpeg2;
pub const av1 = @import("av1.zig").av1;
pub const fwht = @import("fwht.zig").fwht;

pub const stateless = struct {
    pub const base: u32 = c.V4L2_CID_CODEC_STATELESS_BASE;
    pub const class: u32 = c.V4L2_CID_CODEC_STATELESS_CLASS;
    pub const h264 = @import("h264.zig").h264;
    pub const hevc = @import("hevc.zig").hevc;
    pub const vp8 = @import("vp8.zig").vp8;
    pub const vp9 = @import("vp9.zig").vp9;
    pub const mpeg2 = @import("mpeg2.zig").mpeg2;
    pub const av1 = @import("av1.zig").av1;
    pub const fwht = @import("fwht.zig").fwht;
};
