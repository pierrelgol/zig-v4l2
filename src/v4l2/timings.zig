const Fraction = @import("geometry.zig").Fraction;

pub const Blanking = extern struct {
    width: u32,
    height: u32,
    interlaced: u32,
    polarities: u32,
    pixelclock: u64,
    hfrontporch: u32,
    hsync: u32,
    hbackporch: u32,
    vfrontporch: u32,
    vsync: u32,
    vbackporch: u32,
    il_vfrontporch: u32,
    il_vsync: u32,
    il_vbackporch: u32,
    standards: u32,
    flags: u32,
    picture_aspect: Fraction,
    cea861_vic: u8,
    hdmi_vic: u8,
    reserved: [46]u8,

    pub const Interlaced = enum(u32) {
        progressive = 0,
        interlaced = 1,
    };

    pub const Polarity = enum(u32) {
        vsync_pos = 0x00000001,
        hsync_pos = 0x00000002,
    };

    pub const Standard = enum(u32) {
        cea861 = 1 << 0,
        dmt = 1 << 1,
        cvt = 1 << 2,
        gtf = 1 << 3,
        sdi = 1 << 4,
    };

    pub const Flag = enum(u32) {
        reduced_blanking = 1 << 0,
        can_reduce_fps = 1 << 1,
        reduced_fps = 1 << 2,
        half_line = 1 << 3,
        is_ce_video = 1 << 4,
        first_field_extra_line = 1 << 5,
        has_picture_aspect = 1 << 6,
        has_cea861_vic = 1 << 7,
        has_hdmi_vic = 1 << 8,
        can_detect_reduced_fps = 1 << 9,
    };

    pub const Capability = enum(u32) {
        interlaced = 1 << 0,
        progressive = 1 << 1,
        reduced_blanking = 1 << 2,
        custom = 1 << 3,
    };
};

pub const DigitalVideo = struct {
    type: Kind,
    bt: Blanking,

    pub const Kind = enum(u32) {
        bt_656_1120 = 0,
    };
};

pub const Enumeration = struct {
    index: u32,
    pad: u32,
    reserved: [2]u32,
    timings: DigitalVideo,
};

pub const BlankingCapabilities = extern struct {
    min_width: u32,
    max_width: u32,
    min_height: u32,
    max_height: u32,
    min_pixelclock: u64,
    max_pixelclock: u64,
    standards: u32,
    capabilities: u32,
    reserved: [16]u32,
};

pub const DigitalVideoCapabilities = struct {
    type: u32,
    pad: u32,
    reserved: [2]u32,
    bt: BlankingCapabilities,
};
