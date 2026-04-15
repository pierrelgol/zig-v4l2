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
        tuner = 1,
        camera = 2,
        touch = 3,
    };

    pub const Status = enum(u32) {
        no_power = 0x00000001,
        no_signal = 0x00000002,
        no_color = 0x00000004,
        hflip = 0x00000010,
        vflip = 0x00000020,
        no_h_lock = 0x00000100,
        color_kill = 0x00000200,
        no_v_lock = 0x00000400,
        no_std_lock = 0x00000800,
        no_sync = 0x00010000,
        no_equ = 0x00020000,
        no_carrier = 0x00040000,
        macrovision = 0x01000000,
        no_access = 0x02000000,
        vtr = 0x04000000,
    };

    pub const Cap = enum(u32) {
        dv_timings = 0x00000002,
        std = 0x00000004,
        native_size = 0x00000008,
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
