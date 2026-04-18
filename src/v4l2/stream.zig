const bindings = @import("bindings");
const std = @import("std");
const abi = @import("abi.zig");
const Buffer = @import("buffer.zig").Buffer;
const Fraction = @import("geometry.zig").Fraction;
const Rectangle = @import("geometry.zig").Rectangle;
const Pixel = @import("pixel.zig").Pixel;
const Vbi = @import("vbi.zig");
const Window = @import("frame.zig").Window;

comptime {
    std.testing.refAllDecls(@This());
}

pub const Parameters = extern struct {
    pub const Capture = extern struct {
        capability: Capability,
        outputmode: u32,
        time_per_frame: Fraction,
        extended_mode: u32,
        read_buffers: u32,
        reserved: [4]u32,
    };

    pub const Output = extern struct {
        capability: Capability,
        outputmode: u32,
        time_per_frame: Fraction,
        extended_mode: u32,
        write_buffers: u32,
        reserved: [4]u32,
    };

    pub const Capability = enum(u32) {
        time_per_frame = @intCast(bindings.V4L2_CAP_TIMEPERFRAME),
        _,
    };

    pub const Mode = enum(u32) {
        high_quality = @intCast(bindings.V4L2_MODE_HIGHQUALITY),
        _,
    };
};

pub const Crop = extern struct {
    type: Buffer.Type,
    rectangle: Rectangle,

    pub const Capabilities = extern struct {
        type: Buffer.Type,
        bounds: Rectangle,
        default: Rectangle,
        pixel_aspect: Fraction,
    };

    pub const Target = enum(u32) {
        crop = @intCast(bindings.V4L2_SEL_TGT_CROP),
        crop_default = @intCast(bindings.V4L2_SEL_TGT_CROP_DEFAULT),
        crop_bounds = @intCast(bindings.V4L2_SEL_TGT_CROP_BOUNDS),
        native_size = @intCast(bindings.V4L2_SEL_TGT_NATIVE_SIZE),
        compose = @intCast(bindings.V4L2_SEL_TGT_COMPOSE),
        compose_default = @intCast(bindings.V4L2_SEL_TGT_COMPOSE_DEFAULT),
        compose_bounds = @intCast(bindings.V4L2_SEL_TGT_COMPOSE_BOUNDS),
        compose_padded = @intCast(bindings.V4L2_SEL_TGT_COMPOSE_PADDED),

        pub const crop_active: Target = .crop;
        pub const compose_active: Target = .compose;
    };
};

pub const Selection = extern struct {
    type: Buffer.Type,
    target: Crop.Target,
    flags: Flag,
    rectangle: Rectangle,
    reserved: [9]u32,

    pub const Flag = enum(u32) {
        ge = @intCast(bindings.V4L2_SEL_FLAG_GE),
        le = @intCast(bindings.V4L2_SEL_FLAG_LE),
        keep_config = @intCast(bindings.V4L2_SEL_FLAG_KEEP_CONFIG),
    };
};

pub const Edid = extern struct {
    pad: u32,
    start_block: u32,
    blocks: u32,
    reserved: [5]u32,
    edid: ?[*]u8,
};

pub const JpegCompression = extern struct {
    quality: i32,
    APPn: i32,
    APP_len: i32,
    APP_data: [60]u8,
    COM_len: i32,
    COM_data: [60]u8,
    jpeg_markers: u32,

    pub const Marker = enum(u32) {
        dht = @intCast(bindings.V4L2_JPEG_MARKER_DHT),
        dqt = @intCast(bindings.V4L2_JPEG_MARKER_DQT),
        dri = @intCast(bindings.V4L2_JPEG_MARKER_DRI),
        com = @intCast(bindings.V4L2_JPEG_MARKER_COM),
        app = @intCast(bindings.V4L2_JPEG_MARKER_APP),
    };
};

pub const Format = extern struct {
    type: Buffer.Type,
    value: extern union {
        pixel: Pixel,
        multi_plane: Pixel.Mplane,
        window: Window,
        vbi: Vbi.Format,
        sliced_vbi: Vbi.SlicedFormat,
        sdr: Pixel.SdrFormat,
        meta: Pixel.MetaFormat,
        raw_data: [200]u8,
    },
};

pub const Parameter = extern struct {
    type: Buffer.Type,
    value: extern union {
        capture: Parameters.Capture,
        output: Parameters.Output,
        raw_data: [200]u8,
    },
};

test "Stream.Parameters.Capture ABI matches struct_v4l2_captureparm" {
    const C = bindings.struct_v4l2_captureparm;
    const Z = Parameters.Capture;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "capability"), @offsetOf(Z, "capability"));
    try std.testing.expectEqual(@offsetOf(C, "capturemode"), @offsetOf(Z, "outputmode"));
    try std.testing.expectEqual(@offsetOf(C, "timeperframe"), @offsetOf(Z, "time_per_frame"));
    try std.testing.expectEqual(@offsetOf(C, "extendedmode"), @offsetOf(Z, "extended_mode"));
    try std.testing.expectEqual(@offsetOf(C, "readbuffers"), @offsetOf(Z, "read_buffers"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Stream.Parameters.Output ABI matches struct_v4l2_outputparm" {
    const C = bindings.struct_v4l2_outputparm;
    const Z = Parameters.Output;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "capability"), @offsetOf(Z, "capability"));
    try std.testing.expectEqual(@offsetOf(C, "outputmode"), @offsetOf(Z, "outputmode"));
    try std.testing.expectEqual(@offsetOf(C, "timeperframe"), @offsetOf(Z, "time_per_frame"));
    try std.testing.expectEqual(@offsetOf(C, "extendedmode"), @offsetOf(Z, "extended_mode"));
    try std.testing.expectEqual(@offsetOf(C, "writebuffers"), @offsetOf(Z, "write_buffers"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Stream.Crop ABI matches struct_v4l2_crop" {
    const C = bindings.struct_v4l2_crop;
    const Z = Crop;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "c"), @offsetOf(Z, "rectangle"));
}

test "Stream.Crop.Capabilities ABI matches struct_v4l2_cropcap" {
    const C = bindings.struct_v4l2_cropcap;
    const Z = Crop.Capabilities;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "bounds"), @offsetOf(Z, "bounds"));
    try std.testing.expectEqual(@offsetOf(C, "defrect"), @offsetOf(Z, "default"));
    try std.testing.expectEqual(@offsetOf(C, "pixelaspect"), @offsetOf(Z, "pixel_aspect"));
}

test "Stream.Selection ABI matches struct_v4l2_selection" {
    const C = bindings.struct_v4l2_selection;
    const Z = Selection;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "target"), @offsetOf(Z, "target"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "r"), @offsetOf(Z, "rectangle"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Stream.Edid ABI matches struct_v4l2_edid" {
    const C = bindings.struct_v4l2_edid;
    const Z = Edid;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "pad"), @offsetOf(Z, "pad"));
    try std.testing.expectEqual(@offsetOf(C, "start_block"), @offsetOf(Z, "start_block"));
    try std.testing.expectEqual(@offsetOf(C, "blocks"), @offsetOf(Z, "blocks"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
    try std.testing.expectEqual(@offsetOf(C, "edid"), @offsetOf(Z, "edid"));
}

test "Stream.JpegCompression ABI matches struct_v4l2_jpegcompression" {
    const C = bindings.struct_v4l2_jpegcompression;
    const Z = JpegCompression;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "quality"), @offsetOf(Z, "quality"));
    try std.testing.expectEqual(@offsetOf(C, "APPn"), @offsetOf(Z, "APPn"));
    try std.testing.expectEqual(@offsetOf(C, "APP_len"), @offsetOf(Z, "APP_len"));
    try std.testing.expectEqual(@offsetOf(C, "APP_data"), @offsetOf(Z, "APP_data"));
    try std.testing.expectEqual(@offsetOf(C, "COM_len"), @offsetOf(Z, "COM_len"));
    try std.testing.expectEqual(@offsetOf(C, "COM_data"), @offsetOf(Z, "COM_data"));
    try std.testing.expectEqual(@offsetOf(C, "jpeg_markers"), @offsetOf(Z, "jpeg_markers"));
}

test "Stream target aliases and JPEG marker constants match linux/videodev2.h" {
    try std.testing.expectEqual(@intFromEnum(Crop.Target.crop), @intFromEnum(Crop.Target.crop_active));
    try std.testing.expectEqual(@intFromEnum(Crop.Target.compose), @intFromEnum(Crop.Target.compose_active));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.V4L2_SEL_TGT_CROP_ACTIVE)), @intFromEnum(Crop.Target.crop_active));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.V4L2_SEL_TGT_COMPOSE_ACTIVE)), @intFromEnum(Crop.Target.compose_active));

    try std.testing.expectEqual(@as(u32, @intCast(bindings.V4L2_JPEG_MARKER_DHT)), @intFromEnum(JpegCompression.Marker.dht));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.V4L2_JPEG_MARKER_DQT)), @intFromEnum(JpegCompression.Marker.dqt));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.V4L2_JPEG_MARKER_DRI)), @intFromEnum(JpegCompression.Marker.dri));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.V4L2_JPEG_MARKER_COM)), @intFromEnum(JpegCompression.Marker.com));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.V4L2_JPEG_MARKER_APP)), @intFromEnum(JpegCompression.Marker.app));
}

test "Stream.Format ABI matches struct_v4l2_format" {
    const C = bindings.struct_v4l2_format;
    const Z = Format;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "fmt"), @offsetOf(Z, "value"));
}

test "Stream.Parameter ABI matches struct_v4l2_streamparm" {
    const C = bindings.struct_v4l2_streamparm;
    const Z = Parameter;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "parm"), @offsetOf(Z, "value"));
}

test "Stream.Parameters ABI groups match capture and output structs" {
    try abi.expectStruct(bindings.struct_v4l2_captureparm, Parameters.Capture, &.{
        .{ .c_name = "capability", .z_name = "capability" },
        .{ .c_name = "capturemode", .z_name = "outputmode" },
        .{ .c_name = "timeperframe", .z_name = "time_per_frame" },
        .{ .c_name = "extendedmode", .z_name = "extended_mode" },
        .{ .c_name = "readbuffers", .z_name = "read_buffers" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
    try abi.expectStruct(bindings.struct_v4l2_outputparm, Parameters.Output, &.{
        .{ .c_name = "capability", .z_name = "capability" },
        .{ .c_name = "outputmode", .z_name = "outputmode" },
        .{ .c_name = "timeperframe", .z_name = "time_per_frame" },
        .{ .c_name = "extendedmode", .z_name = "extended_mode" },
        .{ .c_name = "writebuffers", .z_name = "write_buffers" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Stream.Format.value ABI matches unnamed union in struct_v4l2_format" {
    const C = @FieldType(bindings.struct_v4l2_format, "fmt");
    const Z = @FieldType(Format, "value");
    try abi.expectUnion(C, Z, &.{
        .{ .c_name = "pix", .z_name = "pixel" },
        .{ .c_name = "pix_mp", .z_name = "multi_plane" },
        .{ .c_name = "win", .z_name = "window" },
        .{ .c_name = "vbi", .z_name = "vbi" },
        .{ .c_name = "sliced", .z_name = "sliced_vbi" },
        .{ .c_name = "sdr", .z_name = "sdr" },
        .{ .c_name = "meta", .z_name = "meta" },
        .{ .c_name = "raw_data", .z_name = "raw_data" },
    });
}

test "Stream.Parameter.value ABI matches unnamed union in struct_v4l2_streamparm" {
    const C = @FieldType(bindings.struct_v4l2_streamparm, "parm");
    const Z = @FieldType(Parameter, "value");
    try abi.expectUnion(C, Z, &.{
        .{ .c_name = "capture", .z_name = "capture" },
        .{ .c_name = "output", .z_name = "output" },
        .{ .c_name = "raw_data", .z_name = "raw_data" },
    });
}
