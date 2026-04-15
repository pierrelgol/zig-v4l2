const bindings = @import("bindings");
const std = @import("std");
const StdId = @import("standard.zig").Standard.Id;

pub const Input = extern struct {
    index: u32,
    name: [32]u8,
    type: Type,
    audioset: u32,
    tuner: u32,
    std: StdId,
    status: u32,
    capabilities: u32,
    reserved: [3]u32,

    pub const Type = enum(u32) {
        tuner = @intCast(bindings.V4L2_INPUT_TYPE_TUNER),
        camera = @intCast(bindings.V4L2_INPUT_TYPE_CAMERA),
        touch = @intCast(bindings.V4L2_INPUT_TYPE_TOUCH),
    };

    pub const Status = enum(u32) {
        no_power = @intCast(bindings.V4L2_IN_ST_NO_POWER),
        no_signal = @intCast(bindings.V4L2_IN_ST_NO_SIGNAL),
        no_color = @intCast(bindings.V4L2_IN_ST_NO_COLOR),
        hflip = @intCast(bindings.V4L2_IN_ST_HFLIP),
        vflip = @intCast(bindings.V4L2_IN_ST_VFLIP),
        no_h_lock = @intCast(bindings.V4L2_IN_ST_NO_H_LOCK),
        color_kill = @intCast(bindings.V4L2_IN_ST_COLOR_KILL),
        no_v_lock = @intCast(bindings.V4L2_IN_ST_NO_V_LOCK),
        no_std_lock = @intCast(bindings.V4L2_IN_ST_NO_STD_LOCK),
        no_sync = @intCast(bindings.V4L2_IN_ST_NO_SYNC),
        no_equ = @intCast(bindings.V4L2_IN_ST_NO_EQU),
        no_carrier = @intCast(bindings.V4L2_IN_ST_NO_CARRIER),
        macrovision = @intCast(bindings.V4L2_IN_ST_MACROVISION),
        no_access = @intCast(bindings.V4L2_IN_ST_NO_ACCESS),
        vtr = @intCast(bindings.V4L2_IN_ST_VTR),
    };

    pub const Cap = enum(u32) {
        dv_timings = @intCast(bindings.V4L2_IN_CAP_DV_TIMINGS),
        std = @intCast(bindings.V4L2_IN_CAP_STD),
        native_size = @intCast(bindings.V4L2_IN_CAP_NATIVE_SIZE),
        pub const custom_timings: Cap = .dv_timings;
    };
};

test "Input ABI matches struct_v4l2_input" {
    const C = bindings.struct_v4l2_input;
    const Z = Input;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "name"), @offsetOf(Z, "name"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "audioset"), @offsetOf(Z, "audioset"));
    try std.testing.expectEqual(@offsetOf(C, "tuner"), @offsetOf(Z, "tuner"));
    try std.testing.expectEqual(@offsetOf(C, "std"), @offsetOf(Z, "std"));
    try std.testing.expectEqual(@offsetOf(C, "status"), @offsetOf(Z, "status"));
    try std.testing.expectEqual(@offsetOf(C, "capabilities"), @offsetOf(Z, "capabilities"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}
