const StdId = @import("Standard.zig").Standard.Id;
pub const Output = @This();

index: u32,
name: [32]u8,
type: Output.Type,
audioset: u32,
modulator: u32,
std: StdId,
capabilities: u32,
reserved: [3]u32,

pub const Type = enum(u32) {
    modulator = 1,
    analog = 2,
    analogvgaoverlay = 3,
};

pub const Cap = enum(u32) {
    dv_timings = 0x00000002,
    std = 0x00000004,
    native_size = 0x00000008,

    pub const custom_timings: Cap = .dv_timings;
};
