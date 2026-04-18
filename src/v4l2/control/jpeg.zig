const c = @import("bindings");
const std = @import("std");
const abi = @import("../abi.zig");
pub const jpeg = @This();

comptime {
    std.testing.refAllDecls(@This());
}

pub const base: u32 = c.V4L2_CID_JPEG_CLASS_BASE;
pub const class: u32 = c.V4L2_CID_JPEG_CLASS;

pub const ChromaSubsampling = enum(i32) {
    pub const id: u32 = c.V4L2_CID_JPEG_CHROMA_SUBSAMPLING;
    s444 = c.V4L2_JPEG_CHROMA_SUBSAMPLING_444,
    s422 = c.V4L2_JPEG_CHROMA_SUBSAMPLING_422,
    s420 = c.V4L2_JPEG_CHROMA_SUBSAMPLING_420,
    s411 = c.V4L2_JPEG_CHROMA_SUBSAMPLING_411,
    s410 = c.V4L2_JPEG_CHROMA_SUBSAMPLING_410,
    gray = c.V4L2_JPEG_CHROMA_SUBSAMPLING_GRAY,
};

pub const restart_interval = struct {
    pub const id: u32 = c.V4L2_CID_JPEG_RESTART_INTERVAL;
};
pub const compression_quality = struct {
    pub const id: u32 = c.V4L2_CID_JPEG_COMPRESSION_QUALITY;
};

pub const active_marker = packed struct(u32) {
    app0: bool = false,
    app1: bool = false,
    _padding0: u14 = 0,
    com: bool = false,
    dqt: bool = false,
    dht: bool = false,
    _padding1: u13 = 0,

    pub const id: u32 = c.V4L2_CID_JPEG_ACTIVE_MARKER;

    comptime {
        if (@bitSizeOf(@This()) != 32) @compileError("jpeg.active_marker must be 32 bits");
    }
};

test "jpeg.active_marker ABI matches V4L2 jpeg active marker bitmasks" {
    try abi.expectPackedStruct(active_marker, u32);
    try abi.expectPackedFlag(active_marker, "app0", c.V4L2_JPEG_ACTIVE_MARKER_APP0);
    try abi.expectPackedFlag(active_marker, "app1", c.V4L2_JPEG_ACTIVE_MARKER_APP1);
    try abi.expectPackedFlag(active_marker, "com", c.V4L2_JPEG_ACTIVE_MARKER_COM);
    try abi.expectPackedFlag(active_marker, "dqt", c.V4L2_JPEG_ACTIVE_MARKER_DQT);
    try abi.expectPackedFlag(active_marker, "dht", c.V4L2_JPEG_ACTIVE_MARKER_DHT);
}
