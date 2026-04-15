const bindings = @import("bindings");
const std = @import("std");
const Pixel = @import("pixel.zig").Pixel;
const stream = @import("stream.zig");

pub const Buffer = extern struct {
    index: u32,
    type: Type,
    bytes_used: u32,
    flags: u32,
    field: u32,
    timestamp: std.os.linux.timeval,
    timecode: Timecode,
    sequence: u32,
    memory: Memory,
    m: extern union {
        offset: u32,
        user_ptr: usize,
        planes: ?[*]Plane,
        fd: i32,
    },
    length: u32,
    reserved2: u32,
    r: extern union {
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

    pub const Timecode = extern struct {
        type: TimecodeType,
        flags: u32,
        frames: u8,
        seconds: u8,
        minutes: u8,
        hours: u8,
        userbits: [4]u8,

        pub const TimecodeType = enum(u32) {
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

    pub const Plane = extern struct {
        bytes_used: u32,
        length: u32,
        m: extern union {
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

    pub const Request = extern struct {
        count: u32,
        type: Type,
        memory: Memory,
        capabilities: u32,
        flags: u8,
        reserved: [3]u8,

        pub const RequestFlag = enum(u8) {
            non_coherent = (@as(u8, 1) << 0),
        };

        pub const Capabilities = enum(u32) {
            mmap = (@as(u32, 1) << 0),
            userptr = (@as(u32, 1) << 1),
            dmabuf = (@as(u32, 1) << 2),
            requests = (@as(u32, 1) << 3),
            orphaned_bufs = (@as(u32, 1) << 4),
            m2m_hold_capture_buf = (@as(u32, 1) << 5),
            mmap_cache_hints = (@as(u32, 1) << 6),
            max_num_buffers = (@as(u32, 1) << 7),
            remove_bufs = (@as(u32, 1) << 8),
        };
    };

    pub const Export = extern struct {
        type: Type,
        index: u32,
        plane: u32,
        flags: u32,
        fd: i32,
        reserved: [11]u32,
    };

    pub const Create = extern struct {
        index: u32,
        count: u32,
        memory: Buffer.Memory,
        format: stream.Format,
        capabilities: u32,
        flags: u32,
        max_num_buffers: u32,
        reserved: [5]u32,
    };

    pub const Remove = extern struct {
        index: u32,
        count: u32,
        type: Buffer.Type,
        reserved: [13]u32,
    };
};

test "Buffer ABI matches struct_v4l2_buffer" {
    const C = bindings.struct_v4l2_buffer;
    const Z = Buffer;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "bytesused"), @offsetOf(Z, "bytes_used"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "field"), @offsetOf(Z, "field"));
    try std.testing.expectEqual(@offsetOf(C, "timestamp"), @offsetOf(Z, "timestamp"));
    try std.testing.expectEqual(@offsetOf(C, "timecode"), @offsetOf(Z, "timecode"));
    try std.testing.expectEqual(@offsetOf(C, "sequence"), @offsetOf(Z, "sequence"));
    try std.testing.expectEqual(@offsetOf(C, "memory"), @offsetOf(Z, "memory"));
    try std.testing.expectEqual(@offsetOf(C, "m"), @offsetOf(Z, "m"));
    try std.testing.expectEqual(@offsetOf(C, "length"), @offsetOf(Z, "length"));
    try std.testing.expectEqual(@offsetOf(C, "reserved2"), @offsetOf(Z, "reserved2"));
}

test "Buffer.Timecode ABI matches struct_v4l2_timecode" {
    const C = bindings.struct_v4l2_timecode;
    const Z = Buffer.Timecode;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "frames"), @offsetOf(Z, "frames"));
    try std.testing.expectEqual(@offsetOf(C, "seconds"), @offsetOf(Z, "seconds"));
    try std.testing.expectEqual(@offsetOf(C, "minutes"), @offsetOf(Z, "minutes"));
    try std.testing.expectEqual(@offsetOf(C, "hours"), @offsetOf(Z, "hours"));
    try std.testing.expectEqual(@offsetOf(C, "userbits"), @offsetOf(Z, "userbits"));
}

test "Buffer.Plane ABI matches struct_v4l2_plane" {
    const C = bindings.struct_v4l2_plane;
    const Z = Buffer.Plane;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "bytesused"), @offsetOf(Z, "bytes_used"));
    try std.testing.expectEqual(@offsetOf(C, "length"), @offsetOf(Z, "length"));
    try std.testing.expectEqual(@offsetOf(C, "m"), @offsetOf(Z, "m"));
    try std.testing.expectEqual(@offsetOf(C, "data_offset"), @offsetOf(Z, "data_offset"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Buffer.Request ABI matches struct_v4l2_requestbuffers" {
    const C = bindings.struct_v4l2_requestbuffers;
    const Z = Buffer.Request;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "count"), @offsetOf(Z, "count"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "memory"), @offsetOf(Z, "memory"));
    try std.testing.expectEqual(@offsetOf(C, "capabilities"), @offsetOf(Z, "capabilities"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Buffer.Export ABI matches struct_v4l2_exportbuffer" {
    const C = bindings.struct_v4l2_exportbuffer;
    const Z = Buffer.Export;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "plane"), @offsetOf(Z, "plane"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "fd"), @offsetOf(Z, "fd"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Buffer.Create ABI matches struct_v4l2_create_buffers" {
    const C = bindings.struct_v4l2_create_buffers;
    const Z = Buffer.Create;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "count"), @offsetOf(Z, "count"));
    try std.testing.expectEqual(@offsetOf(C, "memory"), @offsetOf(Z, "memory"));
    try std.testing.expectEqual(@offsetOf(C, "format"), @offsetOf(Z, "format"));
    try std.testing.expectEqual(@offsetOf(C, "capabilities"), @offsetOf(Z, "capabilities"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "max_num_buffers"), @offsetOf(Z, "max_num_buffers"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Buffer.Remove ABI matches struct_v4l2_remove_buffers" {
    const C = bindings.struct_v4l2_remove_buffers;
    const Z = Buffer.Remove;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "count"), @offsetOf(Z, "count"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}
