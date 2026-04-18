const c = @import("bindings");
pub const camera = @This();
const std = @import("std");

comptime {
    std.testing.refAllDecls(@This());
}

pub const base: u32 = c.V4L2_CID_CAMERA_CLASS_BASE;
pub const class: u32 = c.V4L2_CID_CAMERA_CLASS;

pub const Exposure = enum(i32) {
    pub const id: u32 = c.V4L2_CID_EXPOSURE_AUTO;
    automatic = c.V4L2_EXPOSURE_AUTO,
    manual = c.V4L2_EXPOSURE_MANUAL,
    shutter_priority = c.V4L2_EXPOSURE_SHUTTER_PRIORITY,
    aperture_priority = c.V4L2_EXPOSURE_APERTURE_PRIORITY,

    pub const absolute = struct {
        pub const id: u32 = c.V4L2_CID_EXPOSURE_ABSOLUTE;
    };

    pub const auto = struct {
        pub const priority = struct {
            pub const id: u32 = c.V4L2_CID_EXPOSURE_AUTO_PRIORITY;
        };

        pub const bias = struct {
            pub const id: u32 = c.V4L2_CID_AUTO_EXPOSURE_BIAS;
        };
    };

    pub const Metering = enum(i32) {
        pub const id: u32 = c.V4L2_CID_EXPOSURE_METERING;

        average = c.V4L2_EXPOSURE_METERING_AVERAGE,
        center_weighted = c.V4L2_EXPOSURE_METERING_CENTER_WEIGHTED,
        spot = c.V4L2_EXPOSURE_METERING_SPOT,
        matrix = c.V4L2_EXPOSURE_METERING_MATRIX,
    };
};

pub const pan = struct {
    pub const relative = struct {
        pub const id: u32 = c.V4L2_CID_PAN_RELATIVE;
    };
    pub const reset = struct {
        pub const id: u32 = c.V4L2_CID_PAN_RESET;
    };
    pub const absolute = struct {
        pub const id: u32 = c.V4L2_CID_PAN_ABSOLUTE;
    };
    pub const speed = struct {
        pub const id: u32 = c.V4L2_CID_PAN_SPEED;
    };
};

pub const tilt = struct {
    pub const relative = struct {
        pub const id: u32 = c.V4L2_CID_TILT_RELATIVE;
    };
    pub const reset = struct {
        pub const id: u32 = c.V4L2_CID_TILT_RESET;
    };
    pub const absolute = struct {
        pub const id: u32 = c.V4L2_CID_TILT_ABSOLUTE;
    };
    pub const speed = struct {
        pub const id: u32 = c.V4L2_CID_TILT_SPEED;
    };
};

pub const focus = struct {
    pub const absolute = struct {
        pub const id: u32 = c.V4L2_CID_FOCUS_ABSOLUTE;
    };
    pub const relative = struct {
        pub const id: u32 = c.V4L2_CID_FOCUS_RELATIVE;
    };

    pub const auto = struct {
        pub const id: u32 = c.V4L2_CID_FOCUS_AUTO;

        pub const start = struct {
            pub const id: u32 = c.V4L2_CID_AUTO_FOCUS_START;
        };
        pub const stop = struct {
            pub const id: u32 = c.V4L2_CID_AUTO_FOCUS_STOP;
        };

        pub const Status = enum(i32) {
            id = c.V4L2_CID_AUTO_FOCUS_STATUS,
            idle = c.V4L2_AUTO_FOCUS_STATUS_IDLE,
            busy = c.V4L2_AUTO_FOCUS_STATUS_BUSY,
            reached = c.V4L2_AUTO_FOCUS_STATUS_REACHED,
            failed = c.V4L2_AUTO_FOCUS_STATUS_FAILED,
        };

        pub const Range = enum(i32) {
            pub const id: u32 = c.V4L2_CID_AUTO_FOCUS_RANGE;

            auto = c.V4L2_AUTO_FOCUS_RANGE_AUTO,
            normal = c.V4L2_AUTO_FOCUS_RANGE_NORMAL,
            macro = c.V4L2_AUTO_FOCUS_RANGE_MACRO,
            infinity = c.V4L2_AUTO_FOCUS_RANGE_INFINITY,
        };
    };
};

pub const zoom = struct {
    pub const absolute = struct {
        pub const id: u32 = c.V4L2_CID_ZOOM_ABSOLUTE;
    };
    pub const relative = struct {
        pub const id: u32 = c.V4L2_CID_ZOOM_RELATIVE;
    };
    pub const continuous = struct {
        pub const id: u32 = c.V4L2_CID_ZOOM_CONTINUOUS;
    };
};

pub const privacy = struct {
    pub const id: u32 = c.V4L2_CID_PRIVACY;
};

pub const iris = struct {
    pub const absolute = struct {
        pub const id: u32 = c.V4L2_CID_IRIS_ABSOLUTE;
    };
    pub const relative = struct {
        pub const id: u32 = c.V4L2_CID_IRIS_RELATIVE;
    };
};

pub const WhiteBalance = enum(i32) {
    pub const id: u32 = c.V4L2_CID_AUTO_N_PRESET_WHITE_BALANCE;

    manual = c.V4L2_WHITE_BALANCE_MANUAL,
    auto = c.V4L2_WHITE_BALANCE_AUTO,
    incandescent = c.V4L2_WHITE_BALANCE_INCANDESCENT,
    fluorescent = c.V4L2_WHITE_BALANCE_FLUORESCENT,
    fluorescent_h = c.V4L2_WHITE_BALANCE_FLUORESCENT_H,
    horizon = c.V4L2_WHITE_BALANCE_HORIZON,
    daylight = c.V4L2_WHITE_BALANCE_DAYLIGHT,
    flash = c.V4L2_WHITE_BALANCE_FLASH,
    cloudy = c.V4L2_WHITE_BALANCE_CLOUDY,
    shade = c.V4L2_WHITE_BALANCE_SHADE,
};

pub const wide_dynamic_range = struct {
    pub const id: u32 = c.V4L2_CID_WIDE_DYNAMIC_RANGE;
};
pub const image_stabilization = struct {
    pub const id: u32 = c.V4L2_CID_IMAGE_STABILIZATION;
};
pub const iso_sensitivity = struct {
    pub const id: u32 = c.V4L2_CID_ISO_SENSITIVITY;
};

pub const IsoSensitivityAuto = enum(i32) {
    pub const id: u32 = c.V4L2_CID_ISO_SENSITIVITY_AUTO;
    manual = c.V4L2_ISO_SENSITIVITY_MANUAL,
    auto = c.V4L2_ISO_SENSITIVITY_AUTO,
};

pub const SceneMode = enum(i32) {
    pub const id: u32 = c.V4L2_CID_SCENE_MODE;

    none = c.V4L2_SCENE_MODE_NONE,
    backlight = c.V4L2_SCENE_MODE_BACKLIGHT,
    beach_snow = c.V4L2_SCENE_MODE_BEACH_SNOW,
    candle_light = c.V4L2_SCENE_MODE_CANDLE_LIGHT,
    dawn_dusk = c.V4L2_SCENE_MODE_DAWN_DUSK,
    fall_colors = c.V4L2_SCENE_MODE_FALL_COLORS,
    fireworks = c.V4L2_SCENE_MODE_FIREWORKS,
    landscape = c.V4L2_SCENE_MODE_LANDSCAPE,
    night = c.V4L2_SCENE_MODE_NIGHT,
    party_indoor = c.V4L2_SCENE_MODE_PARTY_INDOOR,
    portrait = c.V4L2_SCENE_MODE_PORTRAIT,
    sports = c.V4L2_SCENE_MODE_SPORTS,
    sunset = c.V4L2_SCENE_MODE_SUNSET,
    text = c.V4L2_SCENE_MODE_TEXT,
};

pub const lock_3a = enum(i32) {
    pub const id: u32 = c.V4L2_CID_3A_LOCK;
    exposure = c.V4L2_LOCK_EXPOSURE,
    white_balance = c.V4L2_LOCK_WHITE_BALANCE,
    focus = c.V4L2_LOCK_FOCUS,
};

pub const orientation = enum(i32) {
    pub const id: u32 = c.V4L2_CID_CAMERA_ORIENTATION;
    front = c.V4L2_CAMERA_ORIENTATION_FRONT,
    back = c.V4L2_CAMERA_ORIENTATION_BACK,
    external = c.V4L2_CAMERA_ORIENTATION_EXTERNAL,
};

pub const sensor = struct {
    pub const rotation = struct {
        pub const id: u32 = c.V4L2_CID_CAMERA_SENSOR_ROTATION;
    };
    pub const hdr_mode = struct {
        pub const id: u32 = c.V4L2_CID_HDR_SENSOR_MODE;
    };
};
