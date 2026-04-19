const std = @import("std");
const c = @import("bindings");

const abi = @import("abi.zig");
const Rectangle = @import("geometry.zig").Rectangle;
const Fraction = @import("geometry.zig").Fraction;
const Mediabus = @import("mediabus.zig");
const Standard = @import("standard.zig").Standard;
const Stream = @import("stream.zig");
const Timings = @import("timings.zig");
const ioctl = @import("ioctl.zig");

comptime {
    std.testing.refAllDecls(@This());
}

pub const Whence = enum(u32) {
    @"try" = @intCast(c.V4L2_SUBDEV_FORMAT_TRY),
    active = @intCast(c.V4L2_SUBDEV_FORMAT_ACTIVE),
};

pub const Format = extern struct {
    which: u32,
    pad: u32,
    format: Mediabus.FrameFormat,
    stream: u32,
    reserved: [7]u32,
};

pub const Crop = extern struct {
    which: u32,
    pad: u32,
    rect: Rectangle,
    stream: u32,
    reserved: [7]u32,
};

pub const MbusCode = extern struct {
    pad: u32,
    index: u32,
    code: u32,
    which: u32,
    flags: u32,
    stream: u32,
    reserved: [6]u32,

    pub const Flag = struct {
        pub const csc_colorspace: u32 = @intCast(c.V4L2_SUBDEV_MBUS_CODE_CSC_COLORSPACE);
        pub const csc_xfer_func: u32 = @intCast(c.V4L2_SUBDEV_MBUS_CODE_CSC_XFER_FUNC);
        pub const csc_ycbcr_enc: u32 = @intCast(c.V4L2_SUBDEV_MBUS_CODE_CSC_YCBCR_ENC);
        pub const csc_hsv_enc: u32 = @intCast(c.V4L2_SUBDEV_MBUS_CODE_CSC_HSV_ENC);
        pub const csc_quantization: u32 = @intCast(c.V4L2_SUBDEV_MBUS_CODE_CSC_QUANTIZATION);
    };
};

pub const frame = struct {
    pub const Size = extern struct {
        index: u32,
        pad: u32,
        code: u32,
        min_width: u32,
        max_width: u32,
        min_height: u32,
        max_height: u32,
        which: u32,
        stream: u32,
        reserved: [7]u32,
    };

    pub const Interval = extern struct {
        pad: u32,
        interval: Fraction,
        stream: u32,
        which: u32,
        reserved: [7]u32,
    };

    pub const IntervalEnum = extern struct {
        index: u32,
        pad: u32,
        code: u32,
        width: u32,
        height: u32,
        interval: Fraction,
        which: u32,
        stream: u32,
        reserved: [7]u32,
    };
};

pub const Selection = extern struct {
    which: u32,
    pad: u32,
    target: u32,
    flags: u32,
    rectangle: Rectangle,
    stream: u32,
    reserved: [7]u32,

    pub const Target = Stream.Crop.Target;
    pub const Flag = Stream.Selection.Flag;
};

pub const Capability = extern struct {
    version: u32,
    capabilities: u32,
    reserved: [14]u32,

    pub const Flag = struct {
        pub const ro_subdev: u32 = @intCast(c.V4L2_SUBDEV_CAP_RO_SUBDEV);
        pub const streams: u32 = @intCast(c.V4L2_SUBDEV_CAP_STREAMS);
    };
};

pub const Route = extern struct {
    sink_pad: u32,
    sink_stream: u32,
    source_pad: u32,
    source_stream: u32,
    flags: u32,
    reserved: [5]u32,

    pub const Flag = struct {
        pub const active: u32 = @intCast(c.V4L2_SUBDEV_ROUTE_FL_ACTIVE);
    };
};

pub const Routing = extern struct {
    which: u32,
    len_routes: u32,
    routes: u64,
    num_routes: u32,
    reserved: [11]u32,
};

pub const ClientCapability = extern struct {
    capabilities: u64,

    pub const Flag = struct {
        pub const streams: u64 = @intCast(c.V4L2_SUBDEV_CLIENT_CAP_STREAMS);
        pub const interval_uses_which: u64 = @intCast(c.V4L2_SUBDEV_CLIENT_CAP_INTERVAL_USES_WHICH);
    };
};

pub const Ioctl = struct {
    pub const querycap: u32 = ioctl.ior('V', 0, Capability);
    pub const g_fmt: u32 = ioctl.iowr('V', 4, Format);
    pub const s_fmt: u32 = ioctl.iowr('V', 5, Format);
    pub const g_frame_interval: u32 = ioctl.iowr('V', 21, frame.Interval);
    pub const s_frame_interval: u32 = ioctl.iowr('V', 22, frame.Interval);
    pub const enum_mbus_code: u32 = ioctl.iowr('V', 2, MbusCode);
    pub const enum_frame_size: u32 = ioctl.iowr('V', 74, frame.Size);
    pub const enum_frame_interval: u32 = ioctl.iowr('V', 75, frame.IntervalEnum);
    pub const g_crop: u32 = ioctl.iowr('V', 59, Crop);
    pub const s_crop: u32 = ioctl.iowr('V', 60, Crop);
    pub const g_selection: u32 = ioctl.iowr('V', 61, Selection);
    pub const s_selection: u32 = ioctl.iowr('V', 62, Selection);
    pub const g_routing: u32 = ioctl.iowr('V', 38, Routing);
    pub const s_routing: u32 = ioctl.iowr('V', 39, Routing);
    pub const g_client_cap: u32 = ioctl.ior('V', 101, ClientCapability);
    pub const s_client_cap: u32 = ioctl.iowr('V', 102, ClientCapability);

    pub const g_std: u32 = ioctl.ior('V', 23, Standard.Id);
    pub const s_std: u32 = ioctl.iow('V', 24, Standard.Id);
    pub const enumstd: u32 = ioctl.iowr('V', 25, Standard);
    pub const g_edid: u32 = ioctl.iowr('V', 40, Stream.Edid);
    pub const s_edid: u32 = ioctl.iowr('V', 41, Stream.Edid);
    pub const querystd: u32 = ioctl.ior('V', 63, Standard.Id);
    pub const s_dv_timings: u32 = ioctl.iowr('V', 87, Timings.DigitalVideo);
    pub const g_dv_timings: u32 = ioctl.iowr('V', 88, Timings.DigitalVideo);
    pub const enum_dv_timings: u32 = ioctl.iowr('V', 98, Timings.Enumeration);
    pub const query_dv_timings: u32 = ioctl.ior('V', 99, Timings.DigitalVideo);
    pub const dv_timings_cap: u32 = ioctl.iowr('V', 100, Timings.DigitalVideoCapabilities);
};

test "Subdev.Format ABI matches struct_v4l2_subdev_format" {
    try abi.expectStruct(c.struct_v4l2_subdev_format, Format, &.{
        .{ .c_name = "which", .z_name = "which" },
        .{ .c_name = "pad", .z_name = "pad" },
        .{ .c_name = "format", .z_name = "format" },
        .{ .c_name = "stream", .z_name = "stream" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Subdev.Crop ABI matches struct_v4l2_subdev_crop" {
    try abi.expectStruct(c.struct_v4l2_subdev_crop, Crop, &.{
        .{ .c_name = "which", .z_name = "which" },
        .{ .c_name = "pad", .z_name = "pad" },
        .{ .c_name = "rect", .z_name = "rect" },
        .{ .c_name = "stream", .z_name = "stream" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Subdev.MbusCode ABI matches struct_v4l2_subdev_mbus_code_enum" {
    try abi.expectStruct(c.struct_v4l2_subdev_mbus_code_enum, MbusCode, &.{
        .{ .c_name = "pad", .z_name = "pad" },
        .{ .c_name = "index", .z_name = "index" },
        .{ .c_name = "code", .z_name = "code" },
        .{ .c_name = "which", .z_name = "which" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "stream", .z_name = "stream" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Subdev.FrameSize ABI matches struct_v4l2_subdev_frame_size_enum" {
    try abi.expectStruct(c.struct_v4l2_subdev_frame_size_enum, frame.Size, &.{
        .{ .c_name = "index", .z_name = "index" },
        .{ .c_name = "pad", .z_name = "pad" },
        .{ .c_name = "code", .z_name = "code" },
        .{ .c_name = "min_width", .z_name = "min_width" },
        .{ .c_name = "max_width", .z_name = "max_width" },
        .{ .c_name = "min_height", .z_name = "min_height" },
        .{ .c_name = "max_height", .z_name = "max_height" },
        .{ .c_name = "which", .z_name = "which" },
        .{ .c_name = "stream", .z_name = "stream" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Subdev.FrameInterval ABI matches struct_v4l2_subdev_frame_interval" {
    try abi.expectStruct(c.struct_v4l2_subdev_frame_interval, frame.Interval, &.{
        .{ .c_name = "pad", .z_name = "pad" },
        .{ .c_name = "interval", .z_name = "interval" },
        .{ .c_name = "stream", .z_name = "stream" },
        .{ .c_name = "which", .z_name = "which" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Subdev.FrameIntervalEnum ABI matches struct_v4l2_subdev_frame_interval_enum" {
    try abi.expectStruct(c.struct_v4l2_subdev_frame_interval_enum, frame.IntervalEnum, &.{
        .{ .c_name = "index", .z_name = "index" },
        .{ .c_name = "pad", .z_name = "pad" },
        .{ .c_name = "code", .z_name = "code" },
        .{ .c_name = "width", .z_name = "width" },
        .{ .c_name = "height", .z_name = "height" },
        .{ .c_name = "interval", .z_name = "interval" },
        .{ .c_name = "which", .z_name = "which" },
        .{ .c_name = "stream", .z_name = "stream" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Subdev.Selection ABI matches struct_v4l2_subdev_selection" {
    try abi.expectStruct(c.struct_v4l2_subdev_selection, Selection, &.{
        .{ .c_name = "which", .z_name = "which" },
        .{ .c_name = "pad", .z_name = "pad" },
        .{ .c_name = "target", .z_name = "target" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "r", .z_name = "rectangle" },
        .{ .c_name = "stream", .z_name = "stream" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Subdev.Capability ABI matches struct_v4l2_subdev_capability" {
    try abi.expectStruct(c.struct_v4l2_subdev_capability, Capability, &.{
        .{ .c_name = "version", .z_name = "version" },
        .{ .c_name = "capabilities", .z_name = "capabilities" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Subdev.Route ABI matches struct_v4l2_subdev_route" {
    try abi.expectStruct(c.struct_v4l2_subdev_route, Route, &.{
        .{ .c_name = "sink_pad", .z_name = "sink_pad" },
        .{ .c_name = "sink_stream", .z_name = "sink_stream" },
        .{ .c_name = "source_pad", .z_name = "source_pad" },
        .{ .c_name = "source_stream", .z_name = "source_stream" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Subdev.Routing ABI matches struct_v4l2_subdev_routing" {
    try abi.expectStruct(c.struct_v4l2_subdev_routing, Routing, &.{
        .{ .c_name = "which", .z_name = "which" },
        .{ .c_name = "len_routes", .z_name = "len_routes" },
        .{ .c_name = "routes", .z_name = "routes" },
        .{ .c_name = "num_routes", .z_name = "num_routes" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Subdev.ClientCapability ABI matches struct_v4l2_subdev_client_capability" {
    try abi.expectStruct(c.struct_v4l2_subdev_client_capability, ClientCapability, &.{
        .{ .c_name = "capabilities", .z_name = "capabilities" },
    });
}

test "Subdev constants match linux/v4l2-subdev.h" {
    try std.testing.expectEqual(@as(u32, @intCast(c.V4L2_SUBDEV_FORMAT_TRY)), @intFromEnum(Whence.@"try"));
    try std.testing.expectEqual(@as(u32, @intCast(c.V4L2_SUBDEV_FORMAT_ACTIVE)), @intFromEnum(Whence.active));

    try std.testing.expectEqual(@as(u32, @intCast(c.V4L2_SUBDEV_MBUS_CODE_CSC_COLORSPACE)), MbusCode.Flag.csc_colorspace);
    try std.testing.expectEqual(@as(u32, @intCast(c.V4L2_SUBDEV_MBUS_CODE_CSC_XFER_FUNC)), MbusCode.Flag.csc_xfer_func);
    try std.testing.expectEqual(@as(u32, @intCast(c.V4L2_SUBDEV_MBUS_CODE_CSC_YCBCR_ENC)), MbusCode.Flag.csc_ycbcr_enc);
    try std.testing.expectEqual(@as(u32, @intCast(c.V4L2_SUBDEV_MBUS_CODE_CSC_HSV_ENC)), MbusCode.Flag.csc_hsv_enc);
    try std.testing.expectEqual(@as(u32, @intCast(c.V4L2_SUBDEV_MBUS_CODE_CSC_QUANTIZATION)), MbusCode.Flag.csc_quantization);

    try std.testing.expectEqual(@as(u32, @intCast(c.V4L2_SUBDEV_CAP_RO_SUBDEV)), Capability.Flag.ro_subdev);
    try std.testing.expectEqual(@as(u32, @intCast(c.V4L2_SUBDEV_CAP_STREAMS)), Capability.Flag.streams);
    try std.testing.expectEqual(@as(u32, @intCast(c.V4L2_SUBDEV_ROUTE_FL_ACTIVE)), Route.Flag.active);

    try std.testing.expectEqual(@as(u64, @intCast(c.V4L2_SUBDEV_CLIENT_CAP_STREAMS)), ClientCapability.Flag.streams);
    try std.testing.expectEqual(@as(u64, @intCast(c.V4L2_SUBDEV_CLIENT_CAP_INTERVAL_USES_WHICH)), ClientCapability.Flag.interval_uses_which);
}

test "Subdev ioctl constants match linux/v4l2-subdev.h" {
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_QUERYCAP)), Ioctl.querycap);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_G_FMT)), Ioctl.g_fmt);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_S_FMT)), Ioctl.s_fmt);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_G_FRAME_INTERVAL)), Ioctl.g_frame_interval);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_S_FRAME_INTERVAL)), Ioctl.s_frame_interval);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_ENUM_MBUS_CODE)), Ioctl.enum_mbus_code);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_ENUM_FRAME_SIZE)), Ioctl.enum_frame_size);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_ENUM_FRAME_INTERVAL)), Ioctl.enum_frame_interval);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_G_CROP)), Ioctl.g_crop);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_S_CROP)), Ioctl.s_crop);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_G_SELECTION)), Ioctl.g_selection);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_S_SELECTION)), Ioctl.s_selection);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_G_ROUTING)), Ioctl.g_routing);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_S_ROUTING)), Ioctl.s_routing);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_G_CLIENT_CAP)), Ioctl.g_client_cap);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_S_CLIENT_CAP)), Ioctl.s_client_cap);

    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_G_STD)), Ioctl.g_std);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_S_STD)), Ioctl.s_std);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_ENUMSTD)), Ioctl.enumstd);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_G_EDID)), Ioctl.g_edid);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_S_EDID)), Ioctl.s_edid);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_QUERYSTD)), Ioctl.querystd);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_S_DV_TIMINGS)), Ioctl.s_dv_timings);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_G_DV_TIMINGS)), Ioctl.g_dv_timings);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_ENUM_DV_TIMINGS)), Ioctl.enum_dv_timings);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_QUERY_DV_TIMINGS)), Ioctl.query_dv_timings);
    try std.testing.expectEqual(@as(u32, @intCast(c.VIDIOC_SUBDEV_DV_TIMINGS_CAP)), Ioctl.dv_timings_cap);
}

test "Subdev compatibility ioctls stay aligned with the main V4L2 API" {
    try std.testing.expectEqual(ioctl.Ioctl.g_std, Ioctl.g_std);
    try std.testing.expectEqual(ioctl.Ioctl.s_std, Ioctl.s_std);
    try std.testing.expectEqual(ioctl.Ioctl.enumstd, Ioctl.enumstd);
    try std.testing.expectEqual(ioctl.Ioctl.g_edid, Ioctl.g_edid);
    try std.testing.expectEqual(ioctl.Ioctl.s_edid, Ioctl.s_edid);
    try std.testing.expectEqual(ioctl.Ioctl.querystd, Ioctl.querystd);
    try std.testing.expectEqual(ioctl.Ioctl.s_dv_timings, Ioctl.s_dv_timings);
    try std.testing.expectEqual(ioctl.Ioctl.g_dv_timings, Ioctl.g_dv_timings);
    try std.testing.expectEqual(ioctl.Ioctl.enum_dv_timings, Ioctl.enum_dv_timings);
    try std.testing.expectEqual(ioctl.Ioctl.query_dv_timings, Ioctl.query_dv_timings);
    try std.testing.expectEqual(ioctl.Ioctl.dv_timings_cap, Ioctl.dv_timings_cap);
}
