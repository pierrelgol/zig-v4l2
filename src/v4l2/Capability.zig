const Buffer = @import("Buffer.zig").Buffer;

pub const Capability = @This();

driver: [16]u8,
card: [32]u8,
bus_info: [32]u8,
version: u32,
capabilities: u32,

pub const Flag = enum(u32) {
    video_capture = 0x00000001,
    video_output = 0x00000002,
    video_overlay = 0x00000004,
    vbi_capture = 0x00000010,
    vbi_output = 0x00000020,
    sliced_vbi_capture = 0x00000040,
    sliced_vbi_output = 0x00000080,
    rds_capture = 0x00000100,
    video_output_overlay = 0x00000200,
    hw_freq_seek = 0x00000400,
    rds_output = 0x00000800,
    video_capture_mplane = 0x00001000,
    video_output_mplane = 0x00002000,
    video_m2m_mplane = 0x00004000,
    video_m2m = 0x00008000,
    tuner = 0x00010000,
    audio = 0x00020000,
    radio = 0x00040000,
    modulator = 0x00080000,
    sdr_capture = 0x00100000,
    ext_pix_format = 0x00200000,
    sdr_output = 0x00400000,
    meta_capture = 0x00800000,
    readwrite = 0x01000000,
    edid = 0x02000000,
    streaming = 0x04000000,
    meta_output = 0x08000000,
    touch = 0x10000000,
    io_mc = 0x20000000,
    device_caps = 0x80000000,
};

pub const Description = extern struct {
    index: u32,
    type: Buffer.Type,
    flags: FlagSet,

    pub const FlagSet = enum(u32) {
        compressed = 0x0001,
        emulated = 0x0002,
        continuous_bytestream = 0x0004,
        dyn_resolution = 0x0008,
        enc_cap_frame_interval = 0x0010,
        csc_colorspace = 0x0020,
        csc_xfer_func = 0x0040,
        csc_ycbcr_enc = 0x0080,
        csc_quantization = 0x0100,
        meta_line_based = 0x0200,

        pub const csc_hsv_enc: FlagSet = .csc_ycbcr_enc;
        pub const enum_all: u32 = 0x80000000;
    };
};
