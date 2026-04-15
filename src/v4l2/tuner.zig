const bindings = @import("bindings");
const std = @import("std");

pub const Type = enum(u32) {
    radio = 1,
    analog_tv = 2,
    digital_tv = 3,
    sdr = 4,
    rf = 5,
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
        vsb = 1 << 1,
        fm = 1 << 2,
        am = 1 << 3,
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
