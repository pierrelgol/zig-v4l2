const std = @import("std");
const ControlType = @import("Control.zig").Control.Type;

tag: u32,
u: union {
    vsync: Vsync,
    ctrl: Ctrl,
    frame_sync: FrameSync,
    source_change: SourceChange,
    motion_detection: MotionDetection,
    data: [64]u8,
},
pending: u32,
sequence: u32,
timestamp: std.os.linux.timespec,
id: u32,
reserved: [8]u32,

pub const Vsync = extern struct {
    field: u8,
};

pub const Ctrl = struct {
    changes: u32,
    tag: ControlType,
    value: union {
        s32: i32,
        s64: i64,
    },
    flags: u32,
    minimum: i32,
    maximum: i32,
    step: i32,
    default_value: i32,

    pub const Change = enum(u32) {
        value = 1 << 0,
        flags = 1 << 1,
        range = 1 << 2,
        dimensions = 1 << 3,
    };
};

pub const FrameSync = struct {
    frame_sequence: u32,
};

pub const SourceChange = struct {
    changes: u32,

    pub const Change = enum(u32) {
        resolution = 1 << 0,
    };
};

pub const MotionDetection = struct {
    flags: u32,
    frame_sequence: u32,
    region_mask: u32,

    pub const Flag = enum(u32) {
        have_frame_seq = 1 << 0,
    };
};

pub const Type = enum(u32) {
    all = 0,
    vsync = 1,
    eos = 2,
    ctrl = 3,
    frame_sync = 4,
    source_change = 5,
    motion_detection = 6,
    private_start = 0x08000000,
};

pub const Subscription = struct {
    type: u32,
    id: u32,
    flags: u32,
    reserved: [5]u32,

    pub const Flag = enum(u32) {
        send_initial = 1 << 0,
        allow_feedback = 1 << 1,
    };
};
