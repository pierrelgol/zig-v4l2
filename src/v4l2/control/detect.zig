const c = @import("bindings");
const std = @import("std");
pub const detect = @This();

comptime {
    std.testing.refAllDecls(@This());
}

pub const base: u32 = c.V4L2_CID_DETECT_CLASS_BASE;
pub const class: u32 = c.V4L2_CID_DETECT_CLASS;

pub const motion = struct {
    pub const Mode = enum(i32) {
        pub const id: u32 = c.V4L2_CID_DETECT_MD_MODE;
        disabled = c.V4L2_DETECT_MD_MODE_DISABLED,
        global = c.V4L2_DETECT_MD_MODE_GLOBAL,
        threshold_grid = c.V4L2_DETECT_MD_MODE_THRESHOLD_GRID,
        region_grid = c.V4L2_DETECT_MD_MODE_REGION_GRID,
    };

    pub const global_threshold = struct {
        pub const id: u32 = c.V4L2_CID_DETECT_MD_GLOBAL_THRESHOLD;
    };
    pub const threshold_grid = struct {
        pub const id: u32 = c.V4L2_CID_DETECT_MD_THRESHOLD_GRID;
    };
    pub const region_grid = struct {
        pub const id: u32 = c.V4L2_CID_DETECT_MD_REGION_GRID;
    };
};
