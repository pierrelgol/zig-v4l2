const c = @import("bindings");
const std = @import("std");
pub const image = @This();

comptime {
    std.testing.refAllDecls(@This());
}

pub const source = struct {
    pub const base: u32 = c.V4L2_CID_IMAGE_SOURCE_CLASS_BASE;
    pub const class: u32 = c.V4L2_CID_IMAGE_SOURCE_CLASS;

    pub const vblank = struct {
        pub const id: u32 = c.V4L2_CID_VBLANK;
    };
    pub const hblank = struct {
        pub const id: u32 = c.V4L2_CID_HBLANK;
    };
    pub const analogue_gain = struct {
        pub const id: u32 = c.V4L2_CID_ANALOGUE_GAIN;
    };

    pub const test_pattern = struct {
        pub const red = struct {
            pub const id: u32 = c.V4L2_CID_TEST_PATTERN_RED;
        };
        pub const greenr = struct {
            pub const id: u32 = c.V4L2_CID_TEST_PATTERN_GREENR;
        };
        pub const blue = struct {
            pub const id: u32 = c.V4L2_CID_TEST_PATTERN_BLUE;
        };
        pub const greenb = struct {
            pub const id: u32 = c.V4L2_CID_TEST_PATTERN_GREENB;
        };
    };

    pub const unit_cell_size = struct {
        pub const id: u32 = c.V4L2_CID_UNIT_CELL_SIZE;
    };
    pub const notify_gains = struct {
        pub const id: u32 = c.V4L2_CID_NOTIFY_GAINS;
    };
};

pub const processing = struct {
    pub const base: u32 = c.V4L2_CID_IMAGE_PROC_CLASS_BASE;
    pub const class: u32 = c.V4L2_CID_IMAGE_PROC_CLASS;

    pub const link_freq = struct {
        pub const id: u32 = c.V4L2_CID_LINK_FREQ;
    };
    pub const pixel_rate = struct {
        pub const id: u32 = c.V4L2_CID_PIXEL_RATE;
    };
    pub const test_pattern = struct {
        pub const id: u32 = c.V4L2_CID_TEST_PATTERN;
    };
    pub const deinterlacing_mode = struct {
        pub const id: u32 = c.V4L2_CID_DEINTERLACING_MODE;
    };
    pub const digital_gain = struct {
        pub const id: u32 = c.V4L2_CID_DIGITAL_GAIN;
    };
};
