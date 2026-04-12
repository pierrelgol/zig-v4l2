pub const Type = enum(u32) {
    radio = 1,
    analog_tv = 2,
    digital_tv = 3,
    sdr = 4,
    rf = 5,
    adc = 4,
};

pub const Tuner = struct {
    index: u32,
    name: [32]u8,
    type: Type,
    capability: u32,
    rangelow: u32,
    rangehigh: u32,
    rxsubchans: u32,
    audmode: u32,
    signal: i32,
    afc: i32,
    reserved: [4]u32,

    pub const Capability = enum(u32) {
        low = 0x0001,
        norm = 0x0002,
        hwseek_bounded = 0x0004,
        hwseek_wrap = 0x0008,
        stereo = 0x0010,
        lang2 = 0x0020,
        sap = 0x0020,
        lang1 = 0x0040,
        rds = 0x0080,
        rds_block_io = 0x0100,
        rds_controls = 0x0200,
        freq_bands = 0x0400,
        hwseek_prog_lim = 0x0800,
        @"1hz" = 0x1000,
    };

    pub const SubChannel = enum(u32) {
        mono = 0x0001,
        stereo = 0x0002,
        lang2 = 0x0004,
        sap = 0x0004,
        lang1 = 0x0008,
        rds = 0x0010,
    };

    pub const Mode = enum(u32) {
        mono = 0x0000,
        stereo = 0x0001,
        lang2 = 0x0002,
        sap = 0x0002,
        lang1 = 0x0003,
        lang1_lang2 = 0x0004,
    };
};

pub const Modulator = struct {
    index: u32,
    name: [32]u8,
    capability: u32,
    rangelow: u32,
    rangehigh: u32,
    txsubchans: u32,
    type: Type,
    reserved: [3]u32,
};

pub const Frequency = struct {
    tuner: u32,
    type: Type,
    frequency: u32,
    reserved: [8]u32,
};

pub const Band = struct {
    tuner: u32,
    type: Type,
    index: u32,
    capability: u32,
    rangelow: u32,
    rangehigh: u32,
    modulation: u32,
    reserved: [9]u32,

    pub const Modulation = enum(u32) {
        vsb = 1 << 1,
        fm = 1 << 2,
        am = 1 << 3,
    };
};

pub const HardwareFrequencySeek = struct {
    tuner: u32,
    type: Type,
    seek_upward: u32,
    wrap_around: u32,
    spacing: u32,
    rangelow: u32,
    rangehigh: u32,
    reserved: [5]u32,
};
