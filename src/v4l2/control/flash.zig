const c = @import("bindings");
const std = @import("std");
const abi = @import("../abi_test.zig");
pub const flash = @This();

comptime {
    std.testing.refAllDecls(@This());
}

pub const base: u32 = c.V4L2_CID_FLASH_CLASS_BASE;
pub const class: u32 = c.V4L2_CID_FLASH_CLASS;

pub const LedMode = enum(i32) {
    pub const id: u32 = c.V4L2_CID_FLASH_LED_MODE;
    none = c.V4L2_FLASH_LED_MODE_NONE,
    flash = c.V4L2_FLASH_LED_MODE_FLASH,
    torch = c.V4L2_FLASH_LED_MODE_TORCH,
};

pub const strobe = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_STROBE;

    pub const Source = enum(i32) {
        pub const id: u32 = c.V4L2_CID_FLASH_STROBE_SOURCE;
        software = c.V4L2_FLASH_STROBE_SOURCE_SOFTWARE,
        external = c.V4L2_FLASH_STROBE_SOURCE_EXTERNAL,
    };

    pub const stop = struct {
        pub const id: u32 = c.V4L2_CID_FLASH_STROBE_STOP;
    };
    pub const status = struct {
        pub const id: u32 = c.V4L2_CID_FLASH_STROBE_STATUS;
    };
};

pub const timeout = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_TIMEOUT;
};

pub const intensity = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_INTENSITY;
};

pub const torch_intensity = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_TORCH_INTENSITY;
};

pub const indicator_intensity = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_INDICATOR_INTENSITY;
};

pub const fault = packed struct(u32) {
    over_voltage: bool = false,
    timeout: bool = false,
    over_temperature: bool = false,
    short_circuit: bool = false,
    over_current: bool = false,
    indicator: bool = false,
    under_voltage: bool = false,
    input_voltage: bool = false,
    led_over_temperature: bool = false,
    _padding: u23 = 0,

    pub const id: u32 = c.V4L2_CID_FLASH_FAULT;

    comptime {
        if (@bitSizeOf(@This()) != 32) @compileError("flash.fault must be 32 bits");
    }
};

pub const charge = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_CHARGE;
};
pub const ready = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_READY;
};

test "flash.fault ABI matches V4L2 flash fault bitmasks" {
    try abi.expectPackedStruct(fault, u32);
    try abi.expectPackedFlag(fault, "over_voltage", c.V4L2_FLASH_FAULT_OVER_VOLTAGE);
    try abi.expectPackedFlag(fault, "timeout", c.V4L2_FLASH_FAULT_TIMEOUT);
    try abi.expectPackedFlag(fault, "over_temperature", c.V4L2_FLASH_FAULT_OVER_TEMPERATURE);
    try abi.expectPackedFlag(fault, "short_circuit", c.V4L2_FLASH_FAULT_SHORT_CIRCUIT);
    try abi.expectPackedFlag(fault, "over_current", c.V4L2_FLASH_FAULT_OVER_CURRENT);
    try abi.expectPackedFlag(fault, "indicator", c.V4L2_FLASH_FAULT_INDICATOR);
    try abi.expectPackedFlag(fault, "under_voltage", c.V4L2_FLASH_FAULT_UNDER_VOLTAGE);
    try abi.expectPackedFlag(fault, "input_voltage", c.V4L2_FLASH_FAULT_INPUT_VOLTAGE);
    try abi.expectPackedFlag(fault, "led_over_temperature", c.V4L2_FLASH_FAULT_LED_OVER_TEMPERATURE);
}
