const c = @import("bindings");
const std = @import("std");

comptime {
    std.testing.refAllDecls(@This());
}

pub const base: u32 = c.V4L2_CID_CODEC_CX2341X_BASE;

pub const video = struct {
    pub const filter = struct {
        pub const spatial = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER;

            pub const Mode = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE;

                manual = c.V4L2_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE_MANUAL,
                auto = c.V4L2_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE_AUTO,
            };

            pub const Luma = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE;

                off = c.V4L2_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE_OFF,
                hor_1d = c.V4L2_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE_1D_HOR,
                vert_1d = c.V4L2_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE_1D_VERT,
                hv_separable_2d = c.V4L2_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE_2D_HV_SEPARABLE,
                sym_non_separable_2d = c.V4L2_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE_2D_SYM_NON_SEPARABLE,
            };

            pub const Chroma = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_SPATIAL_FILTER_TYPE;

                off = c.V4L2_MPEG_CX2341X_VIDEO_CHROMA_SPATIAL_FILTER_TYPE_OFF,
                hor_1d = c.V4L2_MPEG_CX2341X_VIDEO_CHROMA_SPATIAL_FILTER_TYPE_1D_HOR,
            };
        };

        pub const temporal = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER;

            pub const Mode = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER_MODE;

                manual = c.V4L2_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER_MODE_MANUAL,
                auto = c.V4L2_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER_MODE_AUTO,
            };
        };

        pub const Median = enum(i32) {
            pub const id: u32 = c.V4L2_CID_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE;

            off = c.V4L2_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE_OFF,
            hor = c.V4L2_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE_HOR,
            vert = c.V4L2_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE_VERT,
            hor_vert = c.V4L2_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE_HOR_VERT,
            diag = c.V4L2_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE_DIAG,

            pub const luma_bottom = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_MEDIAN_FILTER_BOTTOM;
            };

            pub const luma_top = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_MEDIAN_FILTER_TOP;
            };

            pub const chroma_bottom = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_MEDIAN_FILTER_BOTTOM;
            };

            pub const chroma_top = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_MEDIAN_FILTER_TOP;
            };
        };
    };
};

pub const stream = struct {
    pub const insert_nav_packets = struct {
        pub const id: u32 = c.V4L2_CID_MPEG_CX2341X_STREAM_INSERT_NAV_PACKETS;
    };
};
