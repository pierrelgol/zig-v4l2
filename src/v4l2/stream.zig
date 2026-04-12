const Buffer = @import("Buffer.zig").Buffer;
const Fraction = @import("geometry.zig").Fraction;
const Rectangle = @import("geometry.zig").Rectangle;
const Pixel = @import("Pixel.zig").Pixel;
const Vbi = @import("vbi.zig");
const Window = @import("Frame.zig").Frame.Window;

pub const Parameters = struct {
    pub const Capture = struct {
        capability: Capability,
        outputmode: u32,
        time_per_frame: Fraction,
        extended_mode: u32,
        read_buffers: u32,
        reserved: [4]u32,
    };

    pub const Output = struct {
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

pub const Crop = struct {
    type: Buffer.Type,
    rectangle: Rectangle,

    pub const Capabilities = struct {
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

pub const Selection = struct {
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

pub const Edid = struct {
    pad: u32,
    start_block: u32,
    blocks: u32,
    reserved: [5]u32,
    edid: ?[*]u8,
};

pub const Format = struct {
    type: Buffer.Type,
    value: union {
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

pub const Parameter = struct {
    type: Buffer.Type,
    value: union {
        capture: Parameters.Capture,
        output: Parameters.Output,
        raw_data: [200]u8,
    },
};
