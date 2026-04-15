const bindings = @import("bindings");
const std = @import("std");
const Buffer = @import("buffer.zig").Buffer;

pub const Format = extern struct {
    sampling_rate: u32,
    offset: u32,
    samples_per_line: u32,
    sample_format: u32,
    start: [2]i32,
    count: [2]u32,
    flags: u32,
    reserved: [2]u32,

    pub const Flag = enum(u32) {
        unsync = 1 << 0,
        interlaced = 1 << 1,
    };

    pub const Itu = enum(u32) {
        @"525_f1_start" = 1,
        @"525_f2_start" = 264,
        @"625_f1_start" = 1,
        @"625_f2_start" = 314,
    };
};

pub const SlicedFormat = extern struct {
    service_set: u16,
    service_lines: [2][24]u16,
    io_size: u32,
    reserved: [2]u32,
};

pub const SlicedCapabilities = extern struct {
    service_set: u16,
    service_lines: [2][24]u16,
    type: Buffer.Type,
    reserved: [3]u32,

    pub const Service = enum(u16) {
        teletext_b = 0x0001,
        vps = 0x0400,
        caption_525 = 0x1000,
        wss_625 = 0x4000,
        vbi_525 = 0x1000,
        vbi_625 = 0x4401,
    };
};

pub const SlicedData = extern struct {
    id: u32,
    field: u32,
    line: u32,
    reserved: u32,
    data: [48]u8,
};

pub const MpegItv0Line = extern struct {
    id: u8,
    data: [42]u8,

    pub const LineId = enum(u8) {
        teletext_b = 1,
        caption_525 = 4,
        wss_625 = 5,
        vps = 7,
    };
};

pub const MpegItv0 = extern struct {
    linemask: [2]u32 align(1),
    line: [35]MpegItv0Line,
};

pub const MpegITV0 = extern struct {
    line: [36]MpegItv0Line,
};

pub const MpegFormatIvtv = extern struct {
    magic: [4]u8,
    payload: extern union {
        itv0: MpegItv0,
        ITV0: MpegITV0,
    },
};

test "Vbi.Format ABI matches struct_v4l2_vbi_format" {
    const C = bindings.struct_v4l2_vbi_format;
    const Z = Format;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "sampling_rate"), @offsetOf(Z, "sampling_rate"));
    try std.testing.expectEqual(@offsetOf(C, "offset"), @offsetOf(Z, "offset"));
    try std.testing.expectEqual(@offsetOf(C, "samples_per_line"), @offsetOf(Z, "samples_per_line"));
    try std.testing.expectEqual(@offsetOf(C, "sample_format"), @offsetOf(Z, "sample_format"));
    try std.testing.expectEqual(@offsetOf(C, "start"), @offsetOf(Z, "start"));
    try std.testing.expectEqual(@offsetOf(C, "count"), @offsetOf(Z, "count"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Vbi.SlicedFormat ABI matches struct_v4l2_sliced_vbi_format" {
    const C = bindings.struct_v4l2_sliced_vbi_format;
    const Z = SlicedFormat;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "service_set"), @offsetOf(Z, "service_set"));
    try std.testing.expectEqual(@offsetOf(C, "service_lines"), @offsetOf(Z, "service_lines"));
    try std.testing.expectEqual(@offsetOf(C, "io_size"), @offsetOf(Z, "io_size"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Vbi.SlicedCapabilities ABI matches struct_v4l2_sliced_vbi_cap" {
    const C = bindings.struct_v4l2_sliced_vbi_cap;
    const Z = SlicedCapabilities;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "service_set"), @offsetOf(Z, "service_set"));
    try std.testing.expectEqual(@offsetOf(C, "service_lines"), @offsetOf(Z, "service_lines"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Vbi.SlicedData ABI matches struct_v4l2_sliced_vbi_data" {
    const C = bindings.struct_v4l2_sliced_vbi_data;
    const Z = SlicedData;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "id"), @offsetOf(Z, "id"));
    try std.testing.expectEqual(@offsetOf(C, "field"), @offsetOf(Z, "field"));
    try std.testing.expectEqual(@offsetOf(C, "line"), @offsetOf(Z, "line"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
    try std.testing.expectEqual(@offsetOf(C, "data"), @offsetOf(Z, "data"));
}

test "Vbi.MpegItv0Line ABI matches struct_v4l2_mpeg_vbi_itv0_line" {
    const C = bindings.struct_v4l2_mpeg_vbi_itv0_line;
    const Z = MpegItv0Line;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "id"), @offsetOf(Z, "id"));
    try std.testing.expectEqual(@offsetOf(C, "data"), @offsetOf(Z, "data"));
}

test "Vbi.MpegItv0 ABI matches struct_v4l2_mpeg_vbi_itv0" {
    const C = bindings.struct_v4l2_mpeg_vbi_itv0;
    const Z = MpegItv0;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "linemask"), @offsetOf(Z, "linemask"));
    try std.testing.expectEqual(@offsetOf(C, "line"), @offsetOf(Z, "line"));
}

test "Vbi.MpegITV0 ABI matches struct_v4l2_mpeg_vbi_ITV0" {
    const C = bindings.struct_v4l2_mpeg_vbi_ITV0;
    const Z = MpegITV0;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "line"), @offsetOf(Z, "line"));
}

test "Vbi.MpegFormatIvtv ABI matches struct_v4l2_mpeg_vbi_fmt_ivtv" {
    const C = bindings.struct_v4l2_mpeg_vbi_fmt_ivtv;
    const Z = MpegFormatIvtv;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "magic"), @offsetOf(Z, "magic"));
}
