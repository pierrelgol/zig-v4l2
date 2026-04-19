const bindings = @import("bindings");
const std = @import("std");
const abi = @import("abi.zig");
const Pixel = @import("pixel.zig").Pixel;
const stream = @import("stream.zig");

comptime {
    std.testing.refAllDecls(@This());
}

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
        unset = @intCast(bindings.V4L2_PRIORITY_UNSET),
        background = @intCast(bindings.V4L2_PRIORITY_BACKGROUND),
        interactive = @intCast(bindings.V4L2_PRIORITY_INTERACTIVE),
        record = @intCast(bindings.V4L2_PRIORITY_RECORD),

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
            fps_24 = @intCast(bindings.V4L2_TC_TYPE_24FPS),
            fps_25 = @intCast(bindings.V4L2_TC_TYPE_25FPS),
            fps_30 = @intCast(bindings.V4L2_TC_TYPE_30FPS),
            fps_50 = @intCast(bindings.V4L2_TC_TYPE_50FPS),
            fps_60 = @intCast(bindings.V4L2_TC_TYPE_60FPS),
            _,
        };

        pub const Flag = enum(u32) {
            dropframe = @intCast(bindings.V4L2_TC_FLAG_DROPFRAME),
            colorframe = @intCast(bindings.V4L2_TC_FLAG_COLORFRAME),
            userbits_field = @intCast(bindings.V4L2_TC_USERBITS_field),
            userbits_defined = @intCast(bindings.V4L2_TC_USERBITS_USERDEFINED),
            userbits_8bitchars = @intCast(bindings.V4L2_TC_USERBITS_8BITCHARS),
            _,
        };
    };

    pub const Type = enum(u32) {
        video_capture = @intCast(bindings.V4L2_BUF_TYPE_VIDEO_CAPTURE),
        video_output = @intCast(bindings.V4L2_BUF_TYPE_VIDEO_OUTPUT),
        video_overlay = @intCast(bindings.V4L2_BUF_TYPE_VIDEO_OVERLAY),
        vbi_capture = @intCast(bindings.V4L2_BUF_TYPE_VBI_CAPTURE),
        vbi_output = @intCast(bindings.V4L2_BUF_TYPE_VBI_OUTPUT),
        sliced_vbi_capture = @intCast(bindings.V4L2_BUF_TYPE_SLICED_VBI_CAPTURE),
        sliced_vbi_output = @intCast(bindings.V4L2_BUF_TYPE_SLICED_VBI_OUTPUT),
        video_output_overlay = @intCast(bindings.V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY),
        video_capture_mplane = @intCast(bindings.V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE),
        video_output_mplane = @intCast(bindings.V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE),
        sdr_capture = @intCast(bindings.V4L2_BUF_TYPE_SDR_CAPTURE),
        sdr_output = @intCast(bindings.V4L2_BUF_TYPE_SDR_OUTPUT),
        meta_capture = @intCast(bindings.V4L2_BUF_TYPE_META_CAPTURE),
        meta_output = @intCast(bindings.V4L2_BUF_TYPE_META_OUTPUT),
        private = @intCast(bindings.V4L2_BUF_TYPE_PRIVATE),
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
        mmap = @intCast(bindings.V4L2_MEMORY_MMAP),
        user_ptr = @intCast(bindings.V4L2_MEMORY_USERPTR),
        overlay = @intCast(bindings.V4L2_MEMORY_OVERLAY),
        dmabuf = @intCast(bindings.V4L2_MEMORY_DMABUF),
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
        mapped = @intCast(bindings.V4L2_BUF_FLAG_MAPPED),
        queued = @intCast(bindings.V4L2_BUF_FLAG_QUEUED),
        done = @intCast(bindings.V4L2_BUF_FLAG_DONE),
        keyframe = @intCast(bindings.V4L2_BUF_FLAG_KEYFRAME),
        pframe = @intCast(bindings.V4L2_BUF_FLAG_PFRAME),
        bframe = @intCast(bindings.V4L2_BUF_FLAG_BFRAME),
        err = @intCast(bindings.V4L2_BUF_FLAG_ERROR),
        in_request = @intCast(bindings.V4L2_BUF_FLAG_IN_REQUEST),
        timecode = @intCast(bindings.V4L2_BUF_FLAG_TIMECODE),
        m2m_hold_capture_buf = @intCast(bindings.V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF),
        prepared = @intCast(bindings.V4L2_BUF_FLAG_PREPARED),
        no_cache_invalidate = @intCast(bindings.V4L2_BUF_FLAG_NO_CACHE_INVALIDATE),
        no_cache_clean = @intCast(bindings.V4L2_BUF_FLAG_NO_CACHE_CLEAN),
        timestamp_mask = @intCast(bindings.V4L2_BUF_FLAG_TIMESTAMP_MASK),
        timestamp_unknown = @intCast(bindings.V4L2_BUF_FLAG_TIMESTAMP_UNKNOWN),
        timestamp_monotonic = @intCast(bindings.V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC),
        timestamp_copy = @intCast(bindings.V4L2_BUF_FLAG_TIMESTAMP_COPY),
        tstamp_src_mask = @intCast(bindings.V4L2_BUF_FLAG_TSTAMP_SRC_MASK),
        tstamp_src_soe = @intCast(bindings.V4L2_BUF_FLAG_TSTAMP_SRC_SOE),
        last = @intCast(bindings.V4L2_BUF_FLAG_LAST),
        request_fd = @intCast(bindings.V4L2_BUF_FLAG_REQUEST_FD),

        pub const tstamp_src_eof: Flag = .timestamp_unknown;
    };

    pub const Request = extern struct {
        count: u32,
        type: Type,
        memory: Memory,
        capabilities: u32,
        flags: u8,
        reserved: [3]u8,

        pub const RequestFlag = enum(u8) {
            non_coherent = @intCast(bindings.V4L2_MEMORY_FLAG_NON_COHERENT),
        };

        pub const Capabilities = enum(u32) {
            mmap = @intCast(bindings.V4L2_BUF_CAP_SUPPORTS_MMAP),
            userptr = @intCast(bindings.V4L2_BUF_CAP_SUPPORTS_USERPTR),
            dmabuf = @intCast(bindings.V4L2_BUF_CAP_SUPPORTS_DMABUF),
            requests = @intCast(bindings.V4L2_BUF_CAP_SUPPORTS_REQUESTS),
            orphaned_bufs = @intCast(bindings.V4L2_BUF_CAP_SUPPORTS_ORPHANED_BUFS),
            m2m_hold_capture_buf = @intCast(bindings.V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF),
            mmap_cache_hints = @intCast(bindings.V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS),
            max_num_buffers = @intCast(bindings.V4L2_BUF_CAP_SUPPORTS_MAX_NUM_BUFFERS),
            remove_bufs = @intCast(bindings.V4L2_BUF_CAP_SUPPORTS_REMOVE_BUFS),
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
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "index", .z_name = "index" },
        .{ .c_name = "type", .z_name = "type" },
        .{ .c_name = "bytesused", .z_name = "bytes_used" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "field", .z_name = "field" },
        .{ .c_name = "timestamp", .z_name = "timestamp" },
        .{ .c_name = "timecode", .z_name = "timecode" },
        .{ .c_name = "sequence", .z_name = "sequence" },
        .{ .c_name = "memory", .z_name = "memory" },
        .{ .c_name = "m", .z_name = "m" },
        .{ .c_name = "length", .z_name = "length" },
        .{ .c_name = "reserved2", .z_name = "reserved2" },
        .{ .c_name = "unnamed_0", .z_name = "r" },
    });
}

test "Buffer.Flag aliases match linux/videodev2.h" {
    try std.testing.expectEqual(@intFromEnum(Buffer.Flag.timestamp_unknown), @intFromEnum(Buffer.Flag.tstamp_src_eof));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.V4L2_BUF_FLAG_TSTAMP_SRC_EOF)), @intFromEnum(Buffer.Flag.tstamp_src_eof));
}

test "Buffer.m ABI matches unnamed union in struct_v4l2_buffer" {
    const C = @FieldType(bindings.struct_v4l2_buffer, "m");
    const Z = @FieldType(Buffer, "m");
    try abi.expectUnion(C, Z, &.{
        .{ .c_name = "offset", .z_name = "offset" },
        .{ .c_name = "userptr", .z_name = "user_ptr" },
        .{ .c_name = "planes", .z_name = "planes" },
        .{ .c_name = "fd", .z_name = "fd" },
    });
}

test "Buffer.r ABI matches unnamed union in struct_v4l2_buffer" {
    const C = @FieldType(bindings.struct_v4l2_buffer, "unnamed_0");
    const Z = @FieldType(Buffer, "r");
    try abi.expectUnion(C, Z, &.{
        .{ .c_name = "request_fd", .z_name = "request_fd" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Buffer.Timecode ABI matches struct_v4l2_timecode" {
    const C = bindings.struct_v4l2_timecode;
    const Z = Buffer.Timecode;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "type", .z_name = "type" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "frames", .z_name = "frames" },
        .{ .c_name = "seconds", .z_name = "seconds" },
        .{ .c_name = "minutes", .z_name = "minutes" },
        .{ .c_name = "hours", .z_name = "hours" },
        .{ .c_name = "userbits", .z_name = "userbits" },
    });
}

test "Buffer.Plane ABI matches struct_v4l2_plane" {
    const C = bindings.struct_v4l2_plane;
    const Z = Buffer.Plane;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "bytesused", .z_name = "bytes_used" },
        .{ .c_name = "length", .z_name = "length" },
        .{ .c_name = "m", .z_name = "m" },
        .{ .c_name = "data_offset", .z_name = "data_offset" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Buffer.Plane.m ABI matches unnamed union in struct_v4l2_plane" {
    const C = @FieldType(bindings.struct_v4l2_plane, "m");
    const Z = @FieldType(Buffer.Plane, "m");
    try abi.expectUnion(C, Z, &.{
        .{ .c_name = "mem_offset", .z_name = "mem_offset" },
        .{ .c_name = "userptr", .z_name = "userptr" },
        .{ .c_name = "fd", .z_name = "fd" },
    });
}

test "Buffer.Request ABI matches struct_v4l2_requestbuffers" {
    const C = bindings.struct_v4l2_requestbuffers;
    const Z = Buffer.Request;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "count", .z_name = "count" },
        .{ .c_name = "type", .z_name = "type" },
        .{ .c_name = "memory", .z_name = "memory" },
        .{ .c_name = "capabilities", .z_name = "capabilities" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Buffer.Export ABI matches struct_v4l2_exportbuffer" {
    const C = bindings.struct_v4l2_exportbuffer;
    const Z = Buffer.Export;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "type", .z_name = "type" },
        .{ .c_name = "index", .z_name = "index" },
        .{ .c_name = "plane", .z_name = "plane" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "fd", .z_name = "fd" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Buffer.Create ABI matches struct_v4l2_create_buffers" {
    const C = bindings.struct_v4l2_create_buffers;
    const Z = Buffer.Create;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "index", .z_name = "index" },
        .{ .c_name = "count", .z_name = "count" },
        .{ .c_name = "memory", .z_name = "memory" },
        .{ .c_name = "format", .z_name = "format" },
        .{ .c_name = "capabilities", .z_name = "capabilities" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "max_num_buffers", .z_name = "max_num_buffers" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Buffer.Remove ABI matches struct_v4l2_remove_buffers" {
    const C = bindings.struct_v4l2_remove_buffers;
    const Z = Buffer.Remove;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "index", .z_name = "index" },
        .{ .c_name = "count", .z_name = "count" },
        .{ .c_name = "type", .z_name = "type" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Buffer.Request.RequestFlag matches linux/videodev2.h" {
    try std.testing.expectEqual(@as(u8, @intCast(bindings.V4L2_MEMORY_FLAG_NON_COHERENT)), @intFromEnum(Buffer.Request.RequestFlag.non_coherent));
}
