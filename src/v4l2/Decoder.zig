pub const Decoder = @This();

cmd: Command,
flags: u32,
payload: union {
    stop: struct { pts: u64 },
    start: struct { speed: i32, format: u32 },
    raw: [16]u32,
},

pub const Command = enum(u32) {
    start = 0,
    stop = 1,
    pause = 2,
    @"resume" = 3,
    flush = 4,
};

pub const StartFlag = struct {
    pub const mute_audio: u32 = 1 << 0;
};

pub const PauseFlag = struct {
    pub const to_black: u32 = 1 << 0;
};

pub const StopFlag = struct {
    pub const to_black: u32 = 1 << 0;
    pub const immediately: u32 = 1 << 1;
};

pub const StartFormat = enum(u32) {
    none = 0,
    gop = 1,
};
