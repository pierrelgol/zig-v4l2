const bindings = @import("bindings");
const std = @import("std");
const ControlType = @import("control.zig").Control.Type;

pub const Event = extern struct {
    type: u32,
    u: extern union {
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

    pub const Ctrl = extern struct {
        changes: u32,
        type: u32,
        value: extern union {
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

    pub const FrameSync = extern struct {
        frame_sequence: u32,
    };

    pub const SourceChange = extern struct {
        changes: u32,

        pub const Change = enum(u32) {
            resolution = 1 << 0,
        };
    };

    pub const MotionDetection = extern struct {
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

    pub const Subscription = extern struct {
        type: u32,
        id: u32,
        flags: u32,
        reserved: [5]u32,

        pub const Flag = enum(u32) {
            send_initial = 1 << 0,
            allow_feedback = 1 << 1,
        };
    };
};

test "Event ABI matches struct_v4l2_event" {
    const C = bindings.struct_v4l2_event;
    const Z = Event;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "u"), @offsetOf(Z, "u"));
    try std.testing.expectEqual(@offsetOf(C, "pending"), @offsetOf(Z, "pending"));
    try std.testing.expectEqual(@offsetOf(C, "sequence"), @offsetOf(Z, "sequence"));
    try std.testing.expectEqual(@offsetOf(C, "timestamp"), @offsetOf(Z, "timestamp"));
    try std.testing.expectEqual(@offsetOf(C, "id"), @offsetOf(Z, "id"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Event.Vsync ABI matches struct_v4l2_event_vsync" {
    const C = bindings.struct_v4l2_event_vsync;
    const Z = Event.Vsync;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "field"), @offsetOf(Z, "field"));
}

test "Event.Ctrl ABI matches struct_v4l2_event_ctrl" {
    const C = bindings.struct_v4l2_event_ctrl;
    const Z = Event.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "changes"), @offsetOf(Z, "changes"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "minimum"), @offsetOf(Z, "minimum"));
    try std.testing.expectEqual(@offsetOf(C, "maximum"), @offsetOf(Z, "maximum"));
    try std.testing.expectEqual(@offsetOf(C, "step"), @offsetOf(Z, "step"));
    try std.testing.expectEqual(@offsetOf(C, "default_value"), @offsetOf(Z, "default_value"));
}

test "Event.FrameSync ABI matches struct_v4l2_event_frame_sync" {
    const C = bindings.struct_v4l2_event_frame_sync;
    const Z = Event.FrameSync;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "frame_sequence"), @offsetOf(Z, "frame_sequence"));
}

test "Event.SourceChange ABI matches struct_v4l2_event_src_change" {
    const C = bindings.struct_v4l2_event_src_change;
    const Z = Event.SourceChange;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "changes"), @offsetOf(Z, "changes"));
}

test "Event.MotionDetection ABI matches struct_v4l2_event_motion_det" {
    const C = bindings.struct_v4l2_event_motion_det;
    const Z = Event.MotionDetection;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "frame_sequence"), @offsetOf(Z, "frame_sequence"));
    try std.testing.expectEqual(@offsetOf(C, "region_mask"), @offsetOf(Z, "region_mask"));
}

test "Event.Subscription ABI matches struct_v4l2_event_subscription" {
    const C = bindings.struct_v4l2_event_subscription;
    const Z = Event.Subscription;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "id"), @offsetOf(Z, "id"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}
