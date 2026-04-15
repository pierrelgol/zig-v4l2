const bindings = @import("bindings");
const std = @import("std");
const Buffer = @import("buffer.zig").Buffer;
const Fraction = @import("geometry.zig").Fraction;
const Rectangle = @import("geometry.zig").Rectangle;
const Pixel = @import("pixel.zig").Pixel;
const Vbi = @import("vbi.zig");
const Window = @import("frame.zig").Window;

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
        time_per_frame = 0x1000,
        _,
    };

    pub const Mode = enum(u32) {
        high_quality = 0x0001,
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
        crop = 0x0000,
        crop_default = 0x0001,
        crop_bounds = 0x0002,
        native_size = 0x0003,
        compose = 0x0100,
        compose_default = 0x0101,
        compose_bounds = 0x0102,
        compose_padded = 0x0103,
    };
};

pub const Selection = extern struct {
    type: Buffer.Type,
    target: Crop.Target,
    flags: Flag,
    rectangle: Rectangle,
    reserved: [9]u32,

    pub const Flag = enum(u32) {
        ge = (@as(u8, 1) << 0),
        le = (@as(u8, 1) << 1),
        keep_config = (@as(u8, 1) << 2),
    };
};

pub const Edid = extern struct {
    pad: u32,
    start_block: u32,
    blocks: u32,
    reserved: [5]u32,
    edid: ?[*]u8,
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
