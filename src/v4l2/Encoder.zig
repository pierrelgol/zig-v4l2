pub const Encoder = @This();

cmd: Command,
flags: u32,
raw: [8]u32,

pub const Command = enum(u32) {
    start = 0,
    stop = 1,
    pause = 2,
    @"resume" = 3,
};

pub const Flag = struct {
    pub const stop_at_gop_end: u32 = 1 << 0;
};

pub const Index = struct {
    entries: u32,
    entries_cap: u32,
    reserved: [4]u32,
    entry: [64]Entry,

    pub const Entry = struct {
        offset: u64,
        pts: u64,
        length: u32,
        flags: u32,
        reserved: [2]u32,

        pub const FrameType = struct {
            pub const i: u32 = 0;
            pub const p: u32 = 1;
            pub const b: u32 = 2;
            pub const mask: u32 = 0xf;
        };
    };
};
