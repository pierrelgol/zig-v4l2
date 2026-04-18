const c = @import("bindings");
pub const fm = @This();
const std = @import("std");

comptime {
    std.testing.refAllDecls(@This());
}

pub const base: u32 = c.V4L2_CID_FM_TX_CLASS_BASE;
pub const class: u32 = c.V4L2_CID_FM_TX_CLASS;

pub const tx = struct {
    pub const deviation = struct {
        pub const id: u32 = c.V4L2_CID_RDS_TX_DEVIATION;
    };
    pub const pi = struct {
        pub const id: u32 = c.V4L2_CID_RDS_TX_PI;
    };
    pub const pty = struct {
        pub const id: u32 = c.V4L2_CID_RDS_TX_PTY;
    };
    pub const ps_name = struct {
        pub const id: u32 = c.V4L2_CID_RDS_TX_PS_NAME;
    };
    pub const radio_text = struct {
        pub const id: u32 = c.V4L2_CID_RDS_TX_RADIO_TEXT;
    };
    pub const mono_stereo = struct {
        pub const id: u32 = c.V4L2_CID_RDS_TX_MONO_STEREO;
    };
    pub const artificial_head = struct {
        pub const id: u32 = c.V4L2_CID_RDS_TX_ARTIFICIAL_HEAD;
    };
    pub const compressed = struct {
        pub const id: u32 = c.V4L2_CID_RDS_TX_COMPRESSED;
    };
    pub const dynamic_pty = struct {
        pub const id: u32 = c.V4L2_CID_RDS_TX_DYNAMIC_PTY;
    };
    pub const traffic_announcement = struct {
        pub const id: u32 = c.V4L2_CID_RDS_TX_TRAFFIC_ANNOUNCEMENT;
    };
    pub const traffic_program = struct {
        pub const id: u32 = c.V4L2_CID_RDS_TX_TRAFFIC_PROGRAM;
    };
    pub const music_speech = struct {
        pub const id: u32 = c.V4L2_CID_RDS_TX_MUSIC_SPEECH;
    };
    pub const alt_freqs_enable = struct {
        pub const id: u32 = c.V4L2_CID_RDS_TX_ALT_FREQS_ENABLE;
    };
    pub const alt_freqs = struct {
        pub const id: u32 = c.V4L2_CID_RDS_TX_ALT_FREQS;
    };
};

pub const audio = struct {
    pub const limiter = struct {
        pub const enabled = struct {
            pub const id: u32 = c.V4L2_CID_AUDIO_LIMITER_ENABLED;
        };
        pub const release_time = struct {
            pub const id: u32 = c.V4L2_CID_AUDIO_LIMITER_RELEASE_TIME;
        };
        pub const deviation = struct {
            pub const id: u32 = c.V4L2_CID_AUDIO_LIMITER_DEVIATION;
        };
    };

    pub const compression = struct {
        pub const enabled = struct {
            pub const id: u32 = c.V4L2_CID_AUDIO_COMPRESSION_ENABLED;
        };
        pub const gain = struct {
            pub const id: u32 = c.V4L2_CID_AUDIO_COMPRESSION_GAIN;
        };
        pub const threshold = struct {
            pub const id: u32 = c.V4L2_CID_AUDIO_COMPRESSION_THRESHOLD;
        };
        pub const attack_time = struct {
            pub const id: u32 = c.V4L2_CID_AUDIO_COMPRESSION_ATTACK_TIME;
        };
        pub const release_time = struct {
            pub const id: u32 = c.V4L2_CID_AUDIO_COMPRESSION_RELEASE_TIME;
        };
    };
};

pub const pilot_tone = struct {
    pub const enabled = struct {
        pub const id: u32 = c.V4L2_CID_PILOT_TONE_ENABLED;
    };
    pub const deviation = struct {
        pub const id: u32 = c.V4L2_CID_PILOT_TONE_DEVIATION;
    };
    pub const frequency = struct {
        pub const id: u32 = c.V4L2_CID_PILOT_TONE_FREQUENCY;
    };
};

pub const Preemphasis = enum(i32) {
    pub const id: u32 = c.V4L2_CID_TUNE_PREEMPHASIS;
    disabled = c.V4L2_PREEMPHASIS_DISABLED,
    us_50 = c.V4L2_PREEMPHASIS_50_uS,
    us_75 = c.V4L2_PREEMPHASIS_75_uS,
};

pub const tune_power_level = struct {
    pub const id: u32 = c.V4L2_CID_TUNE_POWER_LEVEL;
};
pub const tune_antenna_capacitor = struct {
    pub const id: u32 = c.V4L2_CID_TUNE_ANTENNA_CAPACITOR;
};

pub const rx = struct {
    pub const base: u32 = c.V4L2_CID_FM_RX_CLASS_BASE;
    pub const class: u32 = c.V4L2_CID_FM_RX_CLASS;

    pub const Deemphasis = enum(i32) {
        pub const id: u32 = c.V4L2_CID_TUNE_DEEMPHASIS;
        disabled = c.V4L2_DEEMPHASIS_DISABLED,
        us_50 = c.V4L2_DEEMPHASIS_50_uS,
        us_75 = c.V4L2_DEEMPHASIS_75_uS,
    };

    pub const rds_reception = struct {
        pub const id: u32 = c.V4L2_CID_RDS_RECEPTION;
    };

    pub const rds_rx = struct {
        pub const pty = struct {
            pub const id: u32 = c.V4L2_CID_RDS_RX_PTY;
        };
        pub const ps_name = struct {
            pub const id: u32 = c.V4L2_CID_RDS_RX_PS_NAME;
        };
        pub const radio_text = struct {
            pub const id: u32 = c.V4L2_CID_RDS_RX_RADIO_TEXT;
        };
        pub const traffic_announcement = struct {
            pub const id: u32 = c.V4L2_CID_RDS_RX_TRAFFIC_ANNOUNCEMENT;
        };
        pub const traffic_program = struct {
            pub const id: u32 = c.V4L2_CID_RDS_RX_TRAFFIC_PROGRAM;
        };
        pub const music_speech = struct {
            pub const id: u32 = c.V4L2_CID_RDS_RX_MUSIC_SPEECH;
        };
    };
};
