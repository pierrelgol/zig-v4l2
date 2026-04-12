const Buffer = @import("Buffer.zig").Buffer;

pub const Format = struct {
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

pub const SlicedFormat = struct {
    service_set: u16,
    service_lines: [2][24]u16,
    io_size: u32,
    reserved: [2]u32,
};

pub const SlicedCapabilities = struct {
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

pub const SlicedData = struct {
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
    linemask: [2]u32,
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
