const Pixel = @import("Pixel.zig").Pixel;
const geometry = @import("geometry.zig");
const Rectangle = geometry.Rectangle;
const Fraction = geometry.Fraction;

pub const Frame = @This();

pub const Clip = struct {
    rectangle: Rectangle,
    next: ?*Clip,
};

pub const Window = struct {
    rectangle: Rectangle,
    field: Pixel.Field,
    chromakey: u32,
    clips: ?*Clip,
    clip_count: u32,
    bitmap: ?[*]anyopaque,
    global_alpha: u8,
};

pub const Buffer = struct {
    capability: Capability,
    flags: Flag,
    base: ?[*]anyopaque,
    format: Format,

    pub const Capability = enum(u32) {
        externoverlay = 0x0001,
        chromakey = 0x0002,
        list_clipping = 0x0004,
        bitmap_clipping = 0x0008,
        local_alpha = 0x0010,
        global_alpha = 0x0020,
        local_inv_alpha = 0x0040,
        src_chromakey = 0x0080,
    };

    pub const Flag = enum(u32) {
        primary = 0x0001,
        overlay = 0x0002,
        chromakey = 0x0004,
        local_alpha = 0x0008,
        global_alpha = 0x0010,
        local_inv_alpha = 0x0020,
        src_chromakey = 0x0040,
    };

    pub const Format = struct {
        width: u32,
        height: u32,
        pixel_format: Pixel.Format,
        field: Pixel.Field,
        bytes_per_line: u32,
        size_image: u32,
        colorspace: Pixel.Colorspace,
        priv: u32,
    };
};

pub const Size = struct {
    index: u32,
    pixel_format: Pixel.Format,
    type: Type,
    size: union(Type) {
        discrete: Discrete,
        step_wise: StepWise,
    },
    reserved: [2]u32,

    pub const Type = enum(u32) {
        discrete = 1,
        continuous = 2,
        stepwise = 3,
    };

    pub const Discrete = struct {
        width: u32,
        height: u32,
    };

    pub const StepWise = struct {
        min_width: u32,
        max_width: u32,
        step_width: u32,
        min_height: u32,
        max_height: u32,
        step_height: u32,
    };
};

pub const Interval = struct {
    index: u32,
    pixel_format: Pixel.Format,
    width: u32,
    height: u32,
    type: Type,
    interval: union(Type) {
        discrete: Fraction,
        step_wise: StepWise,
    },

    pub const Type = enum(u32) {
        discrete = 1,
        continuous = 2,
        step_wise = 3,
        _,
    };

    pub const StepWise = struct {
        min: Fraction,
        max: Fraction,
        step: Fraction,
    };
};
