const bindings = @import("bindings");
const std = @import("std");
const abi = @import("abi.zig");
const ControlType = @import("control.zig").Control.Type;

comptime {
    std.testing.refAllDecls(@This());
}

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
            value = @intCast(bindings.V4L2_EVENT_CTRL_CH_VALUE),
            flags = @intCast(bindings.V4L2_EVENT_CTRL_CH_FLAGS),
            range = @intCast(bindings.V4L2_EVENT_CTRL_CH_RANGE),
            dimensions = @intCast(bindings.V4L2_EVENT_CTRL_CH_DIMENSIONS),
        };
    };

    pub const FrameSync = extern struct {
        frame_sequence: u32,
    };

    pub const SourceChange = extern struct {
        changes: u32,

        pub const Change = struct {
            pub const resolution: u32 = @intCast(bindings.V4L2_EVENT_SRC_CH_RESOLUTION);
        };
    };

    pub const MotionDetection = extern struct {
        flags: u32,
        frame_sequence: u32,
        region_mask: u32,

        pub const Flag = struct {
            pub const have_frame_seq: u32 = @intCast(bindings.V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ);
        };
    };

    pub const Type = enum(u32) {
        all = @intCast(bindings.V4L2_EVENT_ALL),
        vsync = @intCast(bindings.V4L2_EVENT_VSYNC),
        eos = @intCast(bindings.V4L2_EVENT_EOS),
        ctrl = @intCast(bindings.V4L2_EVENT_CTRL),
        frame_sync = @intCast(bindings.V4L2_EVENT_FRAME_SYNC),
        source_change = @intCast(bindings.V4L2_EVENT_SOURCE_CHANGE),
        motion_detection = @intCast(bindings.V4L2_EVENT_MOTION_DET),
        private_start = @intCast(bindings.V4L2_EVENT_PRIVATE_START),
    };

    pub const Subscription = extern struct {
        type: u32,
        id: u32,
        flags: u32,
        reserved: [5]u32,

        pub const Flag = struct {
            pub const send_initial: u32 = @intCast(bindings.V4L2_EVENT_SUB_FL_SEND_INITIAL);
            pub const allow_feedback: u32 = @intCast(bindings.V4L2_EVENT_SUB_FL_ALLOW_FEEDBACK);
        };
    };
};

test "Event ABI matches struct_v4l2_event" {
    const C = bindings.struct_v4l2_event;
    const Z = Event;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "type", .z_name = "type" },
        .{ .c_name = "u", .z_name = "u" },
        .{ .c_name = "pending", .z_name = "pending" },
        .{ .c_name = "sequence", .z_name = "sequence" },
        .{ .c_name = "timestamp", .z_name = "timestamp" },
        .{ .c_name = "id", .z_name = "id" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Event.u ABI matches unnamed union in struct_v4l2_event" {
    const C = @FieldType(bindings.struct_v4l2_event, "u");
    const Z = @FieldType(Event, "u");
    try abi.expectUnion(C, Z, &.{
        .{ .c_name = "vsync", .z_name = "vsync" },
        .{ .c_name = "ctrl", .z_name = "ctrl" },
        .{ .c_name = "frame_sync", .z_name = "frame_sync" },
        .{ .c_name = "src_change", .z_name = "source_change" },
        .{ .c_name = "motion_det", .z_name = "motion_detection" },
        .{ .c_name = "data", .z_name = "data" },
    });
}

test "Event.Vsync ABI matches struct_v4l2_event_vsync" {
    const C = bindings.struct_v4l2_event_vsync;
    const Z = Event.Vsync;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "field", .z_name = "field" },
    });
}

test "Event.Ctrl ABI matches struct_v4l2_event_ctrl" {
    const C = bindings.struct_v4l2_event_ctrl;
    const Z = Event.Ctrl;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "changes", .z_name = "changes" },
        .{ .c_name = "type", .z_name = "type" },
        .{ .c_name = "unnamed_0", .z_name = "value" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "minimum", .z_name = "minimum" },
        .{ .c_name = "maximum", .z_name = "maximum" },
        .{ .c_name = "step", .z_name = "step" },
        .{ .c_name = "default_value", .z_name = "default_value" },
    });
}

test "Event.Ctrl.value ABI matches unnamed union in struct_v4l2_event_ctrl" {
    const C = @FieldType(bindings.struct_v4l2_event_ctrl, "unnamed_0");
    const Z = @FieldType(Event.Ctrl, "value");
    try abi.expectUnion(C, Z, &.{
        .{ .c_name = "value", .z_name = "s32" },
        .{ .c_name = "value64", .z_name = "s64" },
    });
}

test "Event.FrameSync ABI matches struct_v4l2_event_frame_sync" {
    const C = bindings.struct_v4l2_event_frame_sync;
    const Z = Event.FrameSync;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "frame_sequence", .z_name = "frame_sequence" },
    });
}

test "Event.SourceChange ABI matches struct_v4l2_event_src_change" {
    const C = bindings.struct_v4l2_event_src_change;
    const Z = Event.SourceChange;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "changes", .z_name = "changes" },
    });
}

test "Event.MotionDetection ABI matches struct_v4l2_event_motion_det" {
    const C = bindings.struct_v4l2_event_motion_det;
    const Z = Event.MotionDetection;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "frame_sequence", .z_name = "frame_sequence" },
        .{ .c_name = "region_mask", .z_name = "region_mask" },
    });
}

test "Event.Subscription ABI matches struct_v4l2_event_subscription" {
    const C = bindings.struct_v4l2_event_subscription;
    const Z = Event.Subscription;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "type", .z_name = "type" },
        .{ .c_name = "id", .z_name = "id" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}
