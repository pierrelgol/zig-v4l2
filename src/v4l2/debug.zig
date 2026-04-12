pub const Match = extern struct {
    type: Type,
    addr_or_name: extern union {
        addr: u32,
        name: [32]u8,
    },

    pub const Type = enum(u32) {
        bridge = 0,
        i2c_driver = 1,
        i2c_addr = 2,
        ac97 = 3,
        subdev = 4,
        host = 0,
    };
};

pub const Register = extern struct {
    match: Match,
    size: u32,
    reg: u64,
    val: u64,

    pub const Flag = enum(u32) {
        readable = 1 << 0,
        writable = 1 << 1,
    };
};

pub const ChipInfo = extern struct {
    match: Match,
    name: [32]u8,
    flags: u32,
    reserved: [32]u32,
};
