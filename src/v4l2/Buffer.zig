const std = @import("std");
const Pixel = @import("Pixel.zig").Pixel;
const stream = @import("stream.zig");

pub const Buffer = @This();

index: u32,
type: Type,
bytes_used: u32,
flags: Flag,
field: Pixel.Field,
timestamp: std.os.linux.timeval,
timecode: Timecode,
sequence: u32,
memory: Memory,
m: union {
    offset: u32,
    user_ptr: usize,
    planes: ?[*]Plane,
    fd: i32,
},
length: u32,
reserved2: u32,
r: union {
    request_fd: i32,
    reserved: u32,
},

pub const Priority = enum(u32) {
    unset = 0,
    background = 1,
    interactive = 2,
    record = 3,

    pub const default: Priority = .interactive;
};

pub const Timecode = struct {
    pub const Type = enum(u32) {
        fps_24 = 1,
        fps_25 = 2,
        fps_30 = 3,
        fps_50 = 4,
        fps_60 = 5,
        _,
    };

    pub const Flag = enum(u32) {
        dropframe = 0x0001,
        colorframe = 0x0002,
        userbits_field = 0x000C,
        userbits_defined = 0x0000,
        userbits_8bitchars = 0x0008,
        _,
    };
};

pub const Type = enum(u32) {
    video_capture = 1,
    video_output = 2,
    video_overlay = 3,
    vbi_capture = 4,
    vbi_output = 5,
    sliced_vbi_capture = 6,
    sliced_vbi_output = 7,
    video_output_overlay = 8,
    video_capture_mplane = 9,
    video_output_mplane = 10,
    sdr_capture = 11,
    sdr_output = 12,
    meta_capture = 13,
    meta_output = 14,
    private = 0x80,
    _,

    pub fn isValid(buffer_type: Type) bool {
        return switch (@intFromEnum(buffer_type)) {
            0...14 => true,
            else => false,
        };
    }

    pub fn isMultiPlanar(buffer_type: Type) bool {
        return switch (buffer_type) {
            .video_capture_mplane, .video_output_mplane => true,
            else => false,
        };
    }

    pub fn isOutput(buffer_type: Type) bool {
        return switch (buffer_type) {
            .video_output, .video_output_mplane, .video_output_overlay, .vbi_output, .sliced_vbi_output, .sdr_output, .meta_output => true,
            else => false,
        };
    }

    pub fn isCapture(buffer_type: Type) bool {
        return buffer_type.isValid() and !buffer_type.isOutput();
    }
};

pub const Memory = enum(u32) {
    mmap,
    user_ptr,
    overlay,
    dmabuf,
};

pub const Plane = struct {
    bytes_used: u32,
    length: u32,
    m: union(enum) {
        mem_offset: u32,
        userptr: usize,
        fd: i32,
    },
    data_offset: u32,
    reserved: [11]u32,
};

pub const Flag = enum(u32) {
    mapped = 0x00000001,
    queued = 0x00000002,
    done = 0x00000004,
    keyframe = 0x00000008,
    pframe = 0x00000010,
    bframe = 0x00000020,
    err = 0x00000040,
    in_request = 0x00000080,
    timecode = 0x00000100,
    m2m_hold_capture_buf = 0x00000200,
    prepared = 0x00000400,
    no_cache_invalidate = 0x00000800,
    no_cache_clean = 0x00001000,
    timestamp_mask = 0x0000e000,
    timestamp_unknown = 0x00000000,
    timestamp_monotonic = 0x00002000,
    timestamp_copy = 0x00004000,
    tstamp_src_mask = 0x00070000,
    tstamp_src_eof = 0x00000000,
    tstamp_src_soe = 0x00010000,
    last = 0x00100000,
    request_fd = 0x00800000,
};

pub const Request = struct {
    count: u32,
    type: Type,
    memory: Memory,
    capabilities: Capabilities,
    flags: RequestFlag,
    reserved: [3]u8,

    pub const RequestFlag = enum(u8) {
        non_coherent = (@as(u8, 1) << 0),
    };

    pub const Capabilities = enum(u8) {
        mmap = (@as(u8, 1) << 0),
        userptr = (@as(u8, 1) << 1),
        dmabuf = (@as(u8, 1) << 2),
        requests = (@as(u8, 1) << 3),
        orphaned_bufs = (@as(u8, 1) << 4),
        m2m_hold_capture_buf = (@as(u8, 1) << 5),
        mmap_cache_hints = (@as(u8, 1) << 6),
        max_num_buffers = (@as(u8, 1) << 7),
        remove_bufs = (@as(u8, 1) << 8),
    };
};

pub const Export = struct {
    type: Type,
    index: u32,
    plane: u32,
    flags: std.os.linux.FD_CLOEXEC,
    fd: i32,
    reserved: [11]u32,
};

pub const Create = struct {
    index: u32,
    count: u32,
    memory: Buffer.Memory,
    format: stream.Format,
    capabilities: u32,
    flags: u32,
    max_num_buffers: u32,
    reserved: [5]u32,
};

pub const Remove = struct {
    index: u32,
    count: u32,
    type: Buffer.Type,
    reserved: [13]u32,
};
