const StdId = @import("Standard.zig").Standard.Id;
pub const Input = @This();

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
