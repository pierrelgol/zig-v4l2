pub const Audio = @This();

index: u32,
name: [32]u8,
capability: u32,
mode: u32,
reserved: [2]u32,

pub const Capability = enum(u32) {
    stereo = 0x00001,
    avl = 0x00002,
};

pub const Mode = enum(u32) {
    avl = 0x00001,
};

pub const Output = extern struct {
    index: u32,
    name: [32]u8,
    capability: u32,
    mode: u32,
    reserved: [2]u32,
};

pub const Rds = extern struct {
    lsb: u8,
    msb: u8,
    block: u8,

    pub const Block = enum(u8) {
        a = 0,
        b = 1,
        c = 2,
        d = 3,
        c_alt = 4,
        invalid = 7,

        pub const msk: u8 = 0x7;
        pub const corrected: u8 = 0x40;
        pub const @"error": u8 = 0x80;
    };
};
