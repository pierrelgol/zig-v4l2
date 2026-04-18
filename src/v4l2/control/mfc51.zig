const c = @import("bindings");
const std = @import("std");

comptime {
    std.testing.refAllDecls(@This());
}

pub const base: u32 = c.V4L2_CID_CODEC_MFC51_BASE;

pub const video = struct {
    pub const decoder = struct {
        pub const h264_display_delay = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_DECODER_H264_DISPLAY_DELAY;

            pub const enable = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_DECODER_H264_DISPLAY_DELAY_ENABLE;
            };
        };
    };

    pub const FrameSkipMode = enum(i32) {
        pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE;

        disabled = c.V4L2_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE_DISABLED,
        level_limit = c.V4L2_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE_LEVEL_LIMIT,
        buf_limit = c.V4L2_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE_BUF_LIMIT,
    };

    pub const ForceFrameType = enum(i32) {
        pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE;

        disabled = c.V4L2_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE_DISABLED,
        i_frame = c.V4L2_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE_I_FRAME,
        not_coded = c.V4L2_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE_NOT_CODED,
    };

    pub const padding = struct {
        pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_PADDING;

        pub const yuv = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_PADDING_YUV;
        };
    };

    pub const rc_fixed_target_bit = struct {
        pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_RC_FIXED_TARGET_BIT;
    };

    pub const rc_reaction_coeff = struct {
        pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_RC_REACTION_COEFF;
    };

    pub const h264_adaptive_rc = struct {
        pub const activity = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_ACTIVITY;
        };

        pub const dark = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_DARK;
        };

        pub const smooth = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_SMOOTH;
        };

        pub const static = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_STATIC;
        };

        pub const num_ref_pic_for_p = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_H264_NUM_REF_PIC_FOR_P;
        };
    };
};
