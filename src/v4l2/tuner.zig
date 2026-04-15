const bindings = @import("bindings");
const std = @import("std");

pub const Type = enum(u32) {
    radio = @intCast(bindings.V4L2_TUNER_RADIO),
    analog_tv = @intCast(bindings.V4L2_TUNER_ANALOG_TV),
    digital_tv = @intCast(bindings.V4L2_TUNER_DIGITAL_TV),
    sdr = @intCast(bindings.V4L2_TUNER_SDR),
    rf = @intCast(bindings.V4L2_TUNER_RF),
};

pub const Tuner = extern struct {
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
        low = @intCast(bindings.V4L2_TUNER_CAP_LOW),
        norm = @intCast(bindings.V4L2_TUNER_CAP_NORM),
        hwseek_bounded = @intCast(bindings.V4L2_TUNER_CAP_HWSEEK_BOUNDED),
        hwseek_wrap = @intCast(bindings.V4L2_TUNER_CAP_HWSEEK_WRAP),
        stereo = @intCast(bindings.V4L2_TUNER_CAP_STEREO),
        lang2 = @intCast(bindings.V4L2_TUNER_CAP_LANG2),
        sap = @intCast(bindings.V4L2_TUNER_CAP_SAP),
        lang1 = @intCast(bindings.V4L2_TUNER_CAP_LANG1),
        rds = @intCast(bindings.V4L2_TUNER_CAP_RDS),
        rds_block_io = @intCast(bindings.V4L2_TUNER_CAP_RDS_BLOCK_IO),
        rds_controls = @intCast(bindings.V4L2_TUNER_CAP_RDS_CONTROLS),
        freq_bands = @intCast(bindings.V4L2_TUNER_CAP_FREQ_BANDS),
        hwseek_prog_lim = @intCast(bindings.V4L2_TUNER_CAP_HWSEEK_PROG_LIM),
        @"1hz" = @intCast(bindings.V4L2_TUNER_CAP_1HZ),
    };

    pub const SubChannel = enum(u32) {
        mono = @intCast(bindings.V4L2_TUNER_SUB_MONO),
        stereo = @intCast(bindings.V4L2_TUNER_SUB_STEREO),
        lang2 = @intCast(bindings.V4L2_TUNER_SUB_LANG2),
        sap = @intCast(bindings.V4L2_TUNER_SUB_SAP),
        lang1 = @intCast(bindings.V4L2_TUNER_SUB_LANG1),
        rds = @intCast(bindings.V4L2_TUNER_SUB_RDS),
    };

    pub const Mode = enum(u32) {
        mono = @intCast(bindings.V4L2_TUNER_MODE_MONO),
        stereo = @intCast(bindings.V4L2_TUNER_MODE_STEREO),
        lang2 = @intCast(bindings.V4L2_TUNER_MODE_LANG2),
        sap = @intCast(bindings.V4L2_TUNER_MODE_SAP),
        lang1 = @intCast(bindings.V4L2_TUNER_MODE_LANG1),
        lang1_lang2 = @intCast(bindings.V4L2_TUNER_MODE_LANG1_LANG2),
    };
};

pub const Modulator = extern struct {
    index: u32,
    name: [32]u8,
    capability: u32,
    rangelow: u32,
    rangehigh: u32,
    txsubchans: u32,
    type: Type,
    reserved: [3]u32,
};

pub const Frequency = extern struct {
    tuner: u32,
    type: Type,
    frequency: u32,
    reserved: [8]u32,
};

pub const Band = extern struct {
    tuner: u32,
    type: Type,
    index: u32,
    capability: u32,
    rangelow: u32,
    rangehigh: u32,
    modulation: u32,
    reserved: [9]u32,

    pub const Modulation = enum(u32) {
        vsb = @intCast(bindings.V4L2_BAND_MODULATION_VSB),
        fm = @intCast(bindings.V4L2_BAND_MODULATION_FM),
        am = @intCast(bindings.V4L2_BAND_MODULATION_AM),
    };
};

pub const HardwareFrequencySeek = extern struct {
    tuner: u32,
    type: Type,
    seek_upward: u32,
    wrap_around: u32,
    spacing: u32,
    rangelow: u32,
    rangehigh: u32,
    reserved: [5]u32,
};

test "Tuner ABI matches struct_v4l2_tuner" {
    const C = bindings.struct_v4l2_tuner;
    const Z = Tuner;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "name"), @offsetOf(Z, "name"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "capability"), @offsetOf(Z, "capability"));
    try std.testing.expectEqual(@offsetOf(C, "rangelow"), @offsetOf(Z, "rangelow"));
    try std.testing.expectEqual(@offsetOf(C, "rangehigh"), @offsetOf(Z, "rangehigh"));
    try std.testing.expectEqual(@offsetOf(C, "rxsubchans"), @offsetOf(Z, "rxsubchans"));
    try std.testing.expectEqual(@offsetOf(C, "audmode"), @offsetOf(Z, "audmode"));
    try std.testing.expectEqual(@offsetOf(C, "signal"), @offsetOf(Z, "signal"));
    try std.testing.expectEqual(@offsetOf(C, "afc"), @offsetOf(Z, "afc"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Modulator ABI matches struct_v4l2_modulator" {
    const C = bindings.struct_v4l2_modulator;
    const Z = Modulator;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "name"), @offsetOf(Z, "name"));
    try std.testing.expectEqual(@offsetOf(C, "capability"), @offsetOf(Z, "capability"));
    try std.testing.expectEqual(@offsetOf(C, "rangelow"), @offsetOf(Z, "rangelow"));
    try std.testing.expectEqual(@offsetOf(C, "rangehigh"), @offsetOf(Z, "rangehigh"));
    try std.testing.expectEqual(@offsetOf(C, "txsubchans"), @offsetOf(Z, "txsubchans"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Frequency ABI matches struct_v4l2_frequency" {
    const C = bindings.struct_v4l2_frequency;
    const Z = Frequency;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "tuner"), @offsetOf(Z, "tuner"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "frequency"), @offsetOf(Z, "frequency"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Band ABI matches struct_v4l2_frequency_band" {
    const C = bindings.struct_v4l2_frequency_band;
    const Z = Band;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "tuner"), @offsetOf(Z, "tuner"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "capability"), @offsetOf(Z, "capability"));
    try std.testing.expectEqual(@offsetOf(C, "rangelow"), @offsetOf(Z, "rangelow"));
    try std.testing.expectEqual(@offsetOf(C, "rangehigh"), @offsetOf(Z, "rangehigh"));
    try std.testing.expectEqual(@offsetOf(C, "modulation"), @offsetOf(Z, "modulation"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "HardwareFrequencySeek ABI matches struct_v4l2_hw_freq_seek" {
    const C = bindings.struct_v4l2_hw_freq_seek;
    const Z = HardwareFrequencySeek;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "tuner"), @offsetOf(Z, "tuner"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "seek_upward"), @offsetOf(Z, "seek_upward"));
    try std.testing.expectEqual(@offsetOf(C, "wrap_around"), @offsetOf(Z, "wrap_around"));
    try std.testing.expectEqual(@offsetOf(C, "spacing"), @offsetOf(Z, "spacing"));
    try std.testing.expectEqual(@offsetOf(C, "rangelow"), @offsetOf(Z, "rangelow"));
    try std.testing.expectEqual(@offsetOf(C, "rangehigh"), @offsetOf(Z, "rangehigh"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}
