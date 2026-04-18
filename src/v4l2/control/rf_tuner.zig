const c = @import("bindings");
const std = @import("std");

comptime {
    std.testing.refAllDecls(@This());
}

pub const rf_tuner = struct {
    pub const base: u32 = c.V4L2_CID_RF_TUNER_CLASS_BASE;
    pub const class: u32 = c.V4L2_CID_RF_TUNER_CLASS;

    pub const bandwidth = struct {
        pub const id: u32 = c.V4L2_CID_RF_TUNER_BANDWIDTH;
        pub const auto = struct {
            pub const id: u32 = c.V4L2_CID_RF_TUNER_BANDWIDTH_AUTO;
        };
    };

    pub const rf_gain = struct {
        pub const id: u32 = c.V4L2_CID_RF_TUNER_RF_GAIN;
    };

    pub const lna = struct {
        pub const gain_auto = struct {
            pub const id: u32 = c.V4L2_CID_RF_TUNER_LNA_GAIN_AUTO;
        };
        pub const gain = struct {
            pub const id: u32 = c.V4L2_CID_RF_TUNER_LNA_GAIN;
        };
    };

    pub const mixer = struct {
        pub const gain_auto = struct {
            pub const id: u32 = c.V4L2_CID_RF_TUNER_MIXER_GAIN_AUTO;
        };
        pub const gain = struct {
            pub const id: u32 = c.V4L2_CID_RF_TUNER_MIXER_GAIN;
        };
    };

    pub const if_gain = struct {
        pub const auto = struct {
            pub const id: u32 = c.V4L2_CID_RF_TUNER_IF_GAIN_AUTO;
        };
        pub const gain = struct {
            pub const id: u32 = c.V4L2_CID_RF_TUNER_IF_GAIN;
        };
    };

    pub const pll_lock = struct {
        pub const id: u32 = c.V4L2_CID_RF_TUNER_PLL_LOCK;
    };
};
