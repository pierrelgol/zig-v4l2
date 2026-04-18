const c = @import("bindings");
const std = @import("std");
const geometry = @import("geometry.zig");
const Area = geometry.Area;
const Rectangle = geometry.Rectangle;

comptime {
    std.testing.refAllDecls(@This());
}

pub const Control = extern struct {
    id: u32,
    value: i32,

    pub const H264Sps = opaque {};
    pub const H264Pps = opaque {};
    pub const H264ScalingMatrix = opaque {};
    pub const H264PredWeights = opaque {};
    pub const H264SliceParams = opaque {};
    pub const H264DecodeParams = opaque {};
    pub const FwhtParams = opaque {};
    pub const Vp8Frame = opaque {};
    pub const Mpeg2Sequence = opaque {};
    pub const Mpeg2Picture = opaque {};
    pub const Mpeg2Quantisation = opaque {};
    pub const Vp9CompressedHdr = opaque {};
    pub const Vp9Frame = opaque {};
    pub const HevcSps = opaque {};
    pub const HevcPps = opaque {};
    pub const HevcSliceParams = opaque {};
    pub const HevcScalingMatrix = opaque {};
    pub const HevcDecodeParams = opaque {};
    pub const Av1Sequence = opaque {};
    pub const Av1TileGroupEntry = opaque {};
    pub const Av1Frame = opaque {};
    pub const Av1FilmGrain = opaque {};
    pub const Hdr10CllInfo = opaque {};
    pub const Hdr10MasteringDisplay = opaque {};

    pub const Ext = extern struct {
        id: u32 align(1),
        size: u32 align(1),
        reserved2: [1]u32 align(1),
        value: extern union {
            s32: i32 align(1),
            s64: i64 align(1),
            string: ?[*]u8 align(1),
            p_u8: ?[*]u8 align(1),
            p_u16: ?[*]u16 align(1),
            p_u32: ?[*]u32 align(1),
            p_s32: ?[*]i32 align(1),
            p_s64: ?[*]i64 align(1),
            p_area: ?*Area align(1),
            p_rect: ?*Rectangle align(1),
            p_h264_sps: ?*H264Sps align(1),
            p_h264_pps: ?*H264Pps align(1),
            p_h264_scaling_matrix: ?*H264ScalingMatrix align(1),
            p_h264_pred_weights: ?*H264PredWeights align(1),
            p_h264_slice_params: ?*H264SliceParams align(1),
            p_h264_decode_params: ?*H264DecodeParams align(1),
            p_fwht_params: ?*FwhtParams align(1),
            p_vp8_frame: ?*Vp8Frame align(1),
            p_mpeg2_sequence: ?*Mpeg2Sequence align(1),
            p_mpeg2_picture: ?*Mpeg2Picture align(1),
            p_mpeg2_quantisation: ?*Mpeg2Quantisation align(1),
            p_vp9_compressed_hdr_probs: ?*Vp9CompressedHdr align(1),
            p_vp9_frame: ?*Vp9Frame align(1),
            p_hevc_sps: ?*HevcSps align(1),
            p_hevc_pps: ?*HevcPps align(1),
            p_hevc_slice_params: ?*HevcSliceParams align(1),
            p_hevc_scaling_matrix: ?*HevcScalingMatrix align(1),
            p_hevc_decode_params: ?*HevcDecodeParams align(1),
            p_av1_sequence: ?*Av1Sequence align(1),
            p_av1_tile_group_entry: ?*Av1TileGroupEntry align(1),
            p_av1_frame: ?*Av1Frame align(1),
            p_av1_film_grain: ?*Av1FilmGrain align(1),
            p_hdr10_cll_info: ?*Hdr10CllInfo align(1),
            p_hdr10_mastering_display: ?*Hdr10MasteringDisplay align(1),
            ptr: ?*anyopaque align(1),
        },
    };

    pub const ExtSet = extern struct {
        which: u32,
        count: u32,
        error_idx: u32,
        request_fd: i32,
        reserved: [1]u32,
        controls: ?[*]Ext,

        pub const ctrl_id_mask: u32 = 0x0fffffff;
        pub const ctrl_max_dims: u32 = 4;
        pub const which_cur_val: u32 = 0;
        pub const which_def_val: u32 = 0x0f000000;
        pub const which_request_val: u32 = 0x0f010000;
        pub const which_min_val: u32 = 0x0f020000;
        pub const which_max_val: u32 = 0x0f030000;
        pub const cid_max_ctrls: u32 = 1024;
        pub const cid_private_base: u32 = 0x08000000;
        pub const flag_next_ctrl: u32 = 0x80000000;
        pub const flag_next_compound: u32 = 0x40000000;
    };

    pub const Type = enum(u32) {
        integer = @intCast(c.V4L2_CTRL_TYPE_INTEGER),
        boolean = @intCast(c.V4L2_CTRL_TYPE_BOOLEAN),
        menu = @intCast(c.V4L2_CTRL_TYPE_MENU),
        button = @intCast(c.V4L2_CTRL_TYPE_BUTTON),
        integer64 = @intCast(c.V4L2_CTRL_TYPE_INTEGER64),
        class = @intCast(c.V4L2_CTRL_TYPE_CTRL_CLASS),
        string = @intCast(c.V4L2_CTRL_TYPE_STRING),
        bitmask = @intCast(c.V4L2_CTRL_TYPE_BITMASK),
        integer_menu = @intCast(c.V4L2_CTRL_TYPE_INTEGER_MENU),
        u8 = @intCast(c.V4L2_CTRL_TYPE_U8),
        u16 = @intCast(c.V4L2_CTRL_TYPE_U16),
        u32 = @intCast(c.V4L2_CTRL_TYPE_U32),
        area = @intCast(c.V4L2_CTRL_TYPE_AREA),
        rect = @intCast(c.V4L2_CTRL_TYPE_RECT),
        hdr10_cll_info = @intCast(c.V4L2_CTRL_TYPE_HDR10_CLL_INFO),
        hdr10_mastering_display = @intCast(c.V4L2_CTRL_TYPE_HDR10_MASTERING_DISPLAY),
        h264_sps = @intCast(c.V4L2_CTRL_TYPE_H264_SPS),
        h264_pps = @intCast(c.V4L2_CTRL_TYPE_H264_PPS),
        h264_scaling_matrix = @intCast(c.V4L2_CTRL_TYPE_H264_SCALING_MATRIX),
        h264_slice_params = @intCast(c.V4L2_CTRL_TYPE_H264_SLICE_PARAMS),
        h264_decode_params = @intCast(c.V4L2_CTRL_TYPE_H264_DECODE_PARAMS),
        h264_pred_weights = @intCast(c.V4L2_CTRL_TYPE_H264_PRED_WEIGHTS),
        fwht_params = @intCast(c.V4L2_CTRL_TYPE_FWHT_PARAMS),
        vp8_frame = @intCast(c.V4L2_CTRL_TYPE_VP8_FRAME),
        mpeg2_quantisation = @intCast(c.V4L2_CTRL_TYPE_MPEG2_QUANTISATION),
        mpeg2_sequence = @intCast(c.V4L2_CTRL_TYPE_MPEG2_SEQUENCE),
        mpeg2_picture = @intCast(c.V4L2_CTRL_TYPE_MPEG2_PICTURE),
        vp9_compressed_hdr = @intCast(c.V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR),
        vp9_frame = @intCast(c.V4L2_CTRL_TYPE_VP9_FRAME),
        hevc_sps = @intCast(c.V4L2_CTRL_TYPE_HEVC_SPS),
        hevc_pps = @intCast(c.V4L2_CTRL_TYPE_HEVC_PPS),
        hevc_slice_params = @intCast(c.V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS),
        hevc_scaling_matrix = @intCast(c.V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX),
        hevc_decode_params = @intCast(c.V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS),
        av1_sequence = @intCast(c.V4L2_CTRL_TYPE_AV1_SEQUENCE),
        av1_tile_group_entry = @intCast(c.V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY),
        av1_frame = @intCast(c.V4L2_CTRL_TYPE_AV1_FRAME),
        av1_film_grain = @intCast(c.V4L2_CTRL_TYPE_AV1_FILM_GRAIN),

        pub const compound_types: u32 = 0x0100;
    };

    pub const Flag = enum(u32) {
        disabled = @intCast(c.V4L2_CTRL_FLAG_DISABLED),
        grabbed = @intCast(c.V4L2_CTRL_FLAG_GRABBED),
        read_only = @intCast(c.V4L2_CTRL_FLAG_READ_ONLY),
        update = @intCast(c.V4L2_CTRL_FLAG_UPDATE),
        inactive = @intCast(c.V4L2_CTRL_FLAG_INACTIVE),
        slider = @intCast(c.V4L2_CTRL_FLAG_SLIDER),
        write_only = @intCast(c.V4L2_CTRL_FLAG_WRITE_ONLY),
        @"volatile" = @intCast(c.V4L2_CTRL_FLAG_VOLATILE),
        has_payload = @intCast(c.V4L2_CTRL_FLAG_HAS_PAYLOAD),
        execute_on_write = @intCast(c.V4L2_CTRL_FLAG_EXECUTE_ON_WRITE),
        modify_layout = @intCast(c.V4L2_CTRL_FLAG_MODIFY_LAYOUT),
        dynamic_array = @intCast(c.V4L2_CTRL_FLAG_DYNAMIC_ARRAY),
        has_which_min_max = @intCast(c.V4L2_CTRL_FLAG_HAS_WHICH_MIN_MAX),
    };

    pub const Query = extern struct {
        id: u32,
        type: u32,
        name: [32]u8,
        minimum: i32,
        maximum: i32,
        step: i32,
        default_value: i32,
        flags: u32,
        reserved: [2]u32,
    };

    pub const ExtendedQuery = extern struct {
        id: u32,
        type: u32,
        name: [32]u8,
        minimum: i64,
        maximum: i64,
        step: u64,
        default_value: i64,
        flags: u32,
        elem_size: u32,
        elems: u32,
        nr_of_dims: u32,
        dims: [4]u32,
        reserved: [32]u32,
    };

    pub const MenuQuery = extern struct {
        id: u32 align(1),
        index: u32 align(1),
        value: extern union {
            name: [32]u8,
            s64: i64,
        } align(1),
        reserved: u32 align(1),
    };
};

pub const Class = enum(u32) {
    user = c.V4L2_CTRL_CLASS_USER,
    codec = c.V4L2_CTRL_CLASS_CODEC,
    camera = c.V4L2_CTRL_CLASS_CAMERA,
    fm_tx = c.V4L2_CTRL_CLASS_FM_TX,
    flash = c.V4L2_CTRL_CLASS_FLASH,
    jpeg = c.V4L2_CTRL_CLASS_JPEG,
    image_source = c.V4L2_CTRL_CLASS_IMAGE_SOURCE,
    image_proc = c.V4L2_CTRL_CLASS_IMAGE_PROC,
    dv = c.V4L2_CTRL_CLASS_DV,
    fm_rx = c.V4L2_CTRL_CLASS_FM_RX,
    rf_tuner = c.V4L2_CTRL_CLASS_RF_TUNER,
    detect = c.V4L2_CTRL_CLASS_DETECT,
    codec_stateless = c.V4L2_CTRL_CLASS_CODEC_STATELESS,
    colorimetry = c.V4L2_CTRL_CLASS_COLORIMETRY,
};

pub const base: u32 = c.V4L2_CID_BASE;
pub const user_base: u32 = c.V4L2_CID_USER_BASE;
pub const user_class: u32 = c.V4L2_CID_USER_CLASS;
pub const lastp1: u32 = c.V4L2_CID_LASTP1;

pub const brightness = struct {
    pub const id: u32 = c.V4L2_CID_BRIGHTNESS;
};

pub const contrast = struct {
    pub const id: u32 = c.V4L2_CID_CONTRAST;
};

pub const saturation = struct {
    pub const id: u32 = c.V4L2_CID_SATURATION;
};

pub const hue = struct {
    pub const id: u32 = c.V4L2_CID_HUE;
};

pub const audio_volume = struct {
    pub const id: u32 = c.V4L2_CID_AUDIO_VOLUME;
};

pub const audio_balance = struct {
    pub const id: u32 = c.V4L2_CID_AUDIO_BALANCE;
};

pub const audio_bass = struct {
    pub const id: u32 = c.V4L2_CID_AUDIO_BASS;
};

pub const audio_treble = struct {
    pub const id: u32 = c.V4L2_CID_AUDIO_TREBLE;
};

pub const audio_mute = struct {
    pub const id: u32 = c.V4L2_CID_AUDIO_MUTE;
};

pub const audio_loudness = struct {
    pub const id: u32 = c.V4L2_CID_AUDIO_LOUDNESS;
};

pub const black_level = struct {
    pub const id: u32 = c.V4L2_CID_BLACK_LEVEL;
};

pub const auto_white_balance = struct {
    pub const id: u32 = c.V4L2_CID_AUTO_WHITE_BALANCE;
};

pub const do_white_balance = struct {
    pub const id: u32 = c.V4L2_CID_DO_WHITE_BALANCE;
};

pub const red_balance = struct {
    pub const id: u32 = c.V4L2_CID_RED_BALANCE;
};

pub const blue_balance = struct {
    pub const id: u32 = c.V4L2_CID_BLUE_BALANCE;
};

pub const gamma = struct {
    pub const id: u32 = c.V4L2_CID_GAMMA;
};

pub const whiteness = struct {
    pub const id: u32 = c.V4L2_CID_WHITENESS;
};

pub const exposure = struct {
    pub const id: u32 = c.V4L2_CID_EXPOSURE;
};

pub const autogain = struct {
    pub const id: u32 = c.V4L2_CID_AUTOGAIN;
};

pub const gain = struct {
    pub const id: u32 = c.V4L2_CID_GAIN;
};

pub const h_flip = struct {
    pub const id: u32 = c.V4L2_CID_HFLIP;
};

pub const v_flip = struct {
    pub const id: u32 = c.V4L2_CID_VFLIP;
};

pub const power_line_frequency = enum(i32) {
    pub const id: u32 = c.V4L2_CID_POWER_LINE_FREQUENCY;

    disabled = c.V4L2_CID_POWER_LINE_FREQUENCY_DISABLED,
    hz_50 = c.V4L2_CID_POWER_LINE_FREQUENCY_50HZ,
    hz_60 = c.V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
    auto = c.V4L2_CID_POWER_LINE_FREQUENCY_AUTO,
};

pub const auto_brightness = struct {
    pub const id: u32 = c.V4L2_CID_AUTOBRIGHTNESS;
};

pub const band_stop_filter = struct {
    pub const id: u32 = c.V4L2_CID_BAND_STOP_FILTER;
};

pub const rotate = struct {
    pub const id: u32 = c.V4L2_CID_ROTATE;
};

pub const bg_color = struct {
    pub const id: u32 = c.V4L2_CID_BG_COLOR;
};

pub const chroma_gain = struct {
    pub const id: u32 = c.V4L2_CID_CHROMA_GAIN;
};

pub const illuminators1 = struct {
    pub const id: u32 = c.V4L2_CID_ILLUMINATORS_1;
};

pub const illuminators2 = struct {
    pub const id: u32 = c.V4L2_CID_ILLUMINATORS_2;
};

pub const min_buffers_for_capture = struct {
    pub const id: u32 = c.V4L2_CID_MIN_BUFFERS_FOR_CAPTURE;
};

pub const min_buffers_for_output = struct {
    pub const id: u32 = c.V4L2_CID_MIN_BUFFERS_FOR_OUTPUT;
};

pub const alpha_component = struct {
    pub const id: u32 = c.V4L2_CID_ALPHA_COMPONENT;
};

pub const color_fx = enum(i32) {
    pub const id: u32 = c.V4L2_CID_COLORFX;
    pub const cbcr_id: u32 = c.V4L2_CID_COLORFX_CBCR;
    pub const rgb_id: u32 = c.V4L2_CID_COLORFX_RGB;

    none = c.V4L2_COLORFX_NONE,
    bw = c.V4L2_COLORFX_BW,
    sepia = c.V4L2_COLORFX_SEPIA,
    negative = c.V4L2_COLORFX_NEGATIVE,
    emboss = c.V4L2_COLORFX_EMBOSS,
    sketch = c.V4L2_COLORFX_SKETCH,
    sky_blue = c.V4L2_COLORFX_SKY_BLUE,
    grass_green = c.V4L2_COLORFX_GRASS_GREEN,
    skin_whiten = c.V4L2_COLORFX_SKIN_WHITEN,
    vivid = c.V4L2_COLORFX_VIVID,
    aqua = c.V4L2_COLORFX_AQUA,
    art_freeze = c.V4L2_COLORFX_ART_FREEZE,
    silhouette = c.V4L2_COLORFX_SILHOUETTE,
    solarization = c.V4L2_COLORFX_SOLARIZATION,
    antique = c.V4L2_COLORFX_ANTIQUE,
    set_cbcr = c.V4L2_COLORFX_SET_CBCR,
    set_rgb = c.V4L2_COLORFX_SET_RGB,
};

pub const user = struct {
    pub const meye_base: u32 = c.V4L2_CID_USER_MEYE_BASE;
    pub const bttv_base: u32 = c.V4L2_CID_USER_BTTV_BASE;
    pub const s2255_base: u32 = c.V4L2_CID_USER_S2255_BASE;
    pub const si476x_base: u32 = c.V4L2_CID_USER_SI476X_BASE;
    pub const ti_vpe_base: u32 = c.V4L2_CID_USER_TI_VPE_BASE;
    pub const saa7134_base: u32 = c.V4L2_CID_USER_SAA7134_BASE;
    pub const adv7180_base: u32 = c.V4L2_CID_USER_ADV7180_BASE;
    pub const tc358743_base: u32 = c.V4L2_CID_USER_TC358743_BASE;
    pub const max217x_base: u32 = c.V4L2_CID_USER_MAX217X_BASE;
    pub const imx_base: u32 = c.V4L2_CID_USER_IMX_BASE;
    pub const atmel_isc_base: u32 = c.V4L2_CID_USER_ATMEL_ISC_BASE;
    pub const coda_base: u32 = c.V4L2_CID_USER_CODA_BASE;
    pub const ccs_base: u32 = c.V4L2_CID_USER_CCS_BASE;
    pub const allegro_base: u32 = c.V4L2_CID_USER_ALLEGRO_BASE;
    pub const isl7998x_base: u32 = c.V4L2_CID_USER_ISL7998X_BASE;
    pub const dw100_base: u32 = c.V4L2_CID_USER_DW100_BASE;
    pub const aspeed_base: u32 = c.V4L2_CID_USER_ASPEED_BASE;
    pub const npcm_base: u32 = c.V4L2_CID_USER_NPCM_BASE;
    pub const thp7312_base: u32 = c.V4L2_CID_USER_THP7312_BASE;
    pub const uvc_base: u32 = c.V4L2_CID_USER_UVC_BASE;
    pub const rkisp1_base: u32 = c.V4L2_CID_USER_RKISP1_BASE;
};

pub const codec = struct {
    pub const base: u32 = c.V4L2_CID_CODEC_BASE;
    pub const class: u32 = c.V4L2_CID_CODEC_CLASS;

    pub const cx2341x_base = struct {
        pub const id: u32 = c.V4L2_CID_CODEC_CX2341X_BASE;
    };

    pub const mfc51_base = struct {
        pub const id: u32 = c.V4L2_CID_CODEC_MFC51_BASE;
    };
};

pub const mpeg = struct {
    pub const stream = struct {
        pub const Type = enum(i32) {
            pub const id: u32 = c.V4L2_CID_MPEG_STREAM_TYPE;

            mpeg2_ps = c.V4L2_MPEG_STREAM_TYPE_MPEG2_PS,
            mpeg2_ts = c.V4L2_MPEG_STREAM_TYPE_MPEG2_TS,
            mpeg1_ss = c.V4L2_MPEG_STREAM_TYPE_MPEG1_SS,
            mpeg2_dvd = c.V4L2_MPEG_STREAM_TYPE_MPEG2_DVD,
            mpeg1_vcd = c.V4L2_MPEG_STREAM_TYPE_MPEG1_VCD,
            mpeg2_svcd = c.V4L2_MPEG_STREAM_TYPE_MPEG2_SVCD,
        };

        pub const pid_pmt = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_STREAM_PID_PMT;
        };
        pub const pid_audio = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_STREAM_PID_AUDIO;
        };
        pub const pid_video = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_STREAM_PID_VIDEO;
        };
        pub const pid_pcr = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_STREAM_PID_PCR;
        };
        pub const pes_id_audio = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_STREAM_PES_ID_AUDIO;
        };
        pub const pes_id_video = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_STREAM_PES_ID_VIDEO;
        };

        pub const vbi_fmt = enum(i32) {
            pub const id: u32 = c.V4L2_CID_MPEG_STREAM_VBI_FMT;

            none = c.V4L2_MPEG_STREAM_VBI_FMT_NONE,
            ivtv = c.V4L2_MPEG_STREAM_VBI_FMT_IVTV,
        };
    };

    pub const audio = struct {
        pub const sampling = enum(i32) {
            pub const id: u32 = c.V4L2_CID_MPEG_AUDIO_SAMPLING_FREQ;

            freq_44100 = c.V4L2_MPEG_AUDIO_SAMPLING_FREQ_44100,
            freq_48000 = c.V4L2_MPEG_AUDIO_SAMPLING_FREQ_48000,
            freq_32000 = c.V4L2_MPEG_AUDIO_SAMPLING_FREQ_32000,
        };

        pub const encoding = enum(i32) {
            pub const id: u32 = c.V4L2_CID_MPEG_AUDIO_ENCODING;

            layer_1 = c.V4L2_MPEG_AUDIO_ENCODING_LAYER_1,
            layer_2 = c.V4L2_MPEG_AUDIO_ENCODING_LAYER_2,
            layer_3 = c.V4L2_MPEG_AUDIO_ENCODING_LAYER_3,
            aac = c.V4L2_MPEG_AUDIO_ENCODING_AAC,
            ac3 = c.V4L2_MPEG_AUDIO_ENCODING_AC3,
        };

        pub const l1 = enum(i32) {
            pub const id: u32 = c.V4L2_CID_MPEG_AUDIO_L1_BITRATE;

            bitrate_32k = c.V4L2_MPEG_AUDIO_L1_BITRATE_32K,
            bitrate_64k = c.V4L2_MPEG_AUDIO_L1_BITRATE_64K,
            bitrate_96k = c.V4L2_MPEG_AUDIO_L1_BITRATE_96K,
            bitrate_128k = c.V4L2_MPEG_AUDIO_L1_BITRATE_128K,
            bitrate_160k = c.V4L2_MPEG_AUDIO_L1_BITRATE_160K,
            bitrate_192k = c.V4L2_MPEG_AUDIO_L1_BITRATE_192K,
            bitrate_224k = c.V4L2_MPEG_AUDIO_L1_BITRATE_224K,
            bitrate_256k = c.V4L2_MPEG_AUDIO_L1_BITRATE_256K,
            bitrate_288k = c.V4L2_MPEG_AUDIO_L1_BITRATE_288K,
            bitrate_320k = c.V4L2_MPEG_AUDIO_L1_BITRATE_320K,
            bitrate_352k = c.V4L2_MPEG_AUDIO_L1_BITRATE_352K,
            bitrate_384k = c.V4L2_MPEG_AUDIO_L1_BITRATE_384K,
            bitrate_416k = c.V4L2_MPEG_AUDIO_L1_BITRATE_416K,
            bitrate_448k = c.V4L2_MPEG_AUDIO_L1_BITRATE_448K,
        };

        pub const l2 = enum(i32) {
            pub const id: u32 = c.V4L2_CID_MPEG_AUDIO_L2_BITRATE;

            bitrate_32k = c.V4L2_MPEG_AUDIO_L2_BITRATE_32K,
            bitrate_48k = c.V4L2_MPEG_AUDIO_L2_BITRATE_48K,
            bitrate_56k = c.V4L2_MPEG_AUDIO_L2_BITRATE_56K,
            bitrate_64k = c.V4L2_MPEG_AUDIO_L2_BITRATE_64K,
            bitrate_80k = c.V4L2_MPEG_AUDIO_L2_BITRATE_80K,
            bitrate_96k = c.V4L2_MPEG_AUDIO_L2_BITRATE_96K,
            bitrate_112k = c.V4L2_MPEG_AUDIO_L2_BITRATE_112K,
            bitrate_128k = c.V4L2_MPEG_AUDIO_L2_BITRATE_128K,
            bitrate_160k = c.V4L2_MPEG_AUDIO_L2_BITRATE_160K,
            bitrate_192k = c.V4L2_MPEG_AUDIO_L2_BITRATE_192K,
            bitrate_224k = c.V4L2_MPEG_AUDIO_L2_BITRATE_224K,
            bitrate_256k = c.V4L2_MPEG_AUDIO_L2_BITRATE_256K,
            bitrate_320k = c.V4L2_MPEG_AUDIO_L2_BITRATE_320K,
            bitrate_384k = c.V4L2_MPEG_AUDIO_L2_BITRATE_384K,
        };

        pub const l3 = enum(i32) {
            pub const id: u32 = c.V4L2_CID_MPEG_AUDIO_L3_BITRATE;

            bitrate_32k = c.V4L2_MPEG_AUDIO_L3_BITRATE_32K,
            bitrate_40k = c.V4L2_MPEG_AUDIO_L3_BITRATE_40K,
            bitrate_48k = c.V4L2_MPEG_AUDIO_L3_BITRATE_48K,
            bitrate_56k = c.V4L2_MPEG_AUDIO_L3_BITRATE_56K,
            bitrate_64k = c.V4L2_MPEG_AUDIO_L3_BITRATE_64K,
            bitrate_80k = c.V4L2_MPEG_AUDIO_L3_BITRATE_80K,
            bitrate_96k = c.V4L2_MPEG_AUDIO_L3_BITRATE_96K,
            bitrate_112k = c.V4L2_MPEG_AUDIO_L3_BITRATE_112K,
            bitrate_128k = c.V4L2_MPEG_AUDIO_L3_BITRATE_128K,
            bitrate_160k = c.V4L2_MPEG_AUDIO_L3_BITRATE_160K,
            bitrate_192k = c.V4L2_MPEG_AUDIO_L3_BITRATE_192K,
            bitrate_224k = c.V4L2_MPEG_AUDIO_L3_BITRATE_224K,
            bitrate_256k = c.V4L2_MPEG_AUDIO_L3_BITRATE_256K,
            bitrate_320k = c.V4L2_MPEG_AUDIO_L3_BITRATE_320K,
        };

        pub const Mode = enum(i32) {
            pub const id: u32 = c.V4L2_CID_MPEG_AUDIO_MODE;

            stereo = c.V4L2_MPEG_AUDIO_MODE_STEREO,
            joint_stereo = c.V4L2_MPEG_AUDIO_MODE_JOINT_STEREO,
            dual = c.V4L2_MPEG_AUDIO_MODE_DUAL,
            mono = c.V4L2_MPEG_AUDIO_MODE_MONO,

            pub const Extension = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_AUDIO_MODE_EXTENSION;

                bound_4 = c.V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_4,
                bound_8 = c.V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_8,
                bound_12 = c.V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_12,
                bound_16 = c.V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_16,
            };
        };

        pub const emphasis = enum(i32) {
            pub const id: u32 = c.V4L2_CID_MPEG_AUDIO_EMPHASIS;

            emphasis_none = c.V4L2_MPEG_AUDIO_EMPHASIS_NONE,
            emphasis_50_div_15_Us = c.V4L2_MPEG_AUDIO_EMPHASIS_50_DIV_15_uS,
            emphasis_ccitt_j17 = c.V4L2_MPEG_AUDIO_EMPHASIS_CCITT_J17,
        };

        pub const cRC = enum(i32) {
            pub const id: u32 = c.V4L2_CID_MPEG_AUDIO_CRC;

            none = c.V4L2_MPEG_AUDIO_CRC_NONE,
            crc16 = c.V4L2_MPEG_AUDIO_CRC_CRC16,
        };

        pub const mute = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_AUDIO_MUTE;
        };

        pub const aac = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_AUDIO_AAC_BITRATE;
        };

        pub const ac3 = enum(i32) {
            pub const id: u32 = c.V4L2_CID_MPEG_AUDIO_AC3_BITRATE;

            bitrate_32k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_32K,
            bitrate_40k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_40K,
            bitrate_48k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_48K,
            bitrate_56k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_56K,
            bitrate_64k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_64K,
            bitrate_80k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_80K,
            bitrate_96k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_96K,
            bitrate_112k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_112K,
            bitrate_128k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_128K,
            bitrate_160k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_160K,
            bitrate_192k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_192K,
            bitrate_224k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_224K,
            bitrate_256k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_256K,
            bitrate_320k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_320K,
            bitrate_384k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_384K,
            bitrate_448k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_448K,
            bitrate_512k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_512K,
            bitrate_576k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_576K,
            bitrate_640k = c.V4L2_MPEG_AUDIO_AC3_BITRATE_640K,
        };

        pub const dec = enum(i32) {
            pub const id: u32 = c.V4L2_CID_MPEG_AUDIO_DEC_PLAYBACK;

            playback_auto = c.V4L2_MPEG_AUDIO_DEC_PLAYBACK_AUTO,
            playback_stereo = c.V4L2_MPEG_AUDIO_DEC_PLAYBACK_STEREO,
            playback_left = c.V4L2_MPEG_AUDIO_DEC_PLAYBACK_LEFT,
            playback_right = c.V4L2_MPEG_AUDIO_DEC_PLAYBACK_RIGHT,
            playback_mono = c.V4L2_MPEG_AUDIO_DEC_PLAYBACK_MONO,
            playback_swapped_stereo = c.V4L2_MPEG_AUDIO_DEC_PLAYBACK_SWAPPED_STEREO,

            pub const multilingual = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_AUDIO_DEC_MULTILINGUAL_PLAYBACK;
            };
        };
    };

    pub const video = struct {
        pub const Encoding = enum(i32) {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_ENCODING;

            mpeg_1 = c.V4L2_MPEG_VIDEO_ENCODING_MPEG_1,
            mpeg_2 = c.V4L2_MPEG_VIDEO_ENCODING_MPEG_2,
            mpeg_4_avc = c.V4L2_MPEG_VIDEO_ENCODING_MPEG_4_AVC,
        };

        pub const Aspect = enum(i32) {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_ASPECT;
            aspect_1x1 = c.V4L2_MPEG_VIDEO_ASPECT_1x1,
            aspect_4x3 = c.V4L2_MPEG_VIDEO_ASPECT_4x3,
            aspect_16x9 = c.V4L2_MPEG_VIDEO_ASPECT_16x9,
            aspect_221x100 = c.V4L2_MPEG_VIDEO_ASPECT_221x100,
        };

        pub const b_frames = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_B_FRAMES;
        };

        pub const gop_size = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_GOP_SIZE;
        };

        pub const gop_closure = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_GOP_CLOSURE;
        };

        pub const pull_down = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_PULLDOWN;
        };

        pub const bitrate = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_BITRATE;

            pub const Mode = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_BITRATE_MODE;

                vbr = c.V4L2_MPEG_VIDEO_BITRATE_MODE_VBR,
                cbr = c.V4L2_MPEG_VIDEO_BITRATE_MODE_CBR,
                cq = c.V4L2_MPEG_VIDEO_BITRATE_MODE_CQ,
            };

            pub const peak = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_BITRATE_PEAK;
            };
        };

        pub const temporal_decimation = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_TEMPORAL_DECIMATION;
        };

        pub const mute = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MUTE;

            pub const yuv = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MUTE_YUV;
            };
        };

        pub const decoder = struct {
            pub const slice_interface = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_DECODER_SLICE_INTERFACE;
            };

            pub const mpeg4_deblock_filter = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER;
            };

            pub const display_delay = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY;
            };

            pub const delay_enable = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE;
            };
        };

        pub const cyclic_intra_refresh_mb = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_CYCLIC_INTRA_REFRESH_MB;
        };

        pub const frame_rc_enable = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE;
        };

        pub const HeaderMode = enum(i32) {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEADER_MODE;

            separate = c.V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE,
            joined_with_1st_frame = c.V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME,
        };

        pub const max_ref_pic = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MAX_REF_PIC;
        };

        pub const mb_rc_enable = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE;
        };

        pub const multi_slice = struct {
            pub const Mode = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MODE;

                pub const Enum = enum(i32) {
                    single = c.V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE,
                    max_mb = c.V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_MB,
                    max_bytes = c.V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_BYTES,
                };
            };

            pub const max_bytes = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MAX_BYTES;
            };

            pub const max_mb = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MAX_MB;
            };
        };

        pub const vbv_size = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_VBV_SIZE;
        };

        pub const dec_pts = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_DEC_PTS;
        };

        pub const dec_frame = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_DEC_FRAME;
        };

        pub const vbv_delay = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_VBV_DELAY;
        };

        pub const repeat_seq_header = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_REPEAT_SEQ_HEADER;
        };

        pub const mv_h_search_range = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MV_H_SEARCH_RANGE;
        };

        pub const mv_v_search_range = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MV_V_SEARCH_RANGE;
        };

        pub const force_key_frame = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME;
        };

        pub const base_layer_priority = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_BASELAYER_PRIORITY_ID;
        };

        pub const au_delimiter = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_AU_DELIMITER;
        };

        pub const ltr_count = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_LTR_COUNT;
        };

        pub const ltr_index = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_FRAME_LTR_INDEX;
        };

        pub const ltr_frames = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES;
        };

        pub const conceal_color = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_DEC_CONCEAL_COLOR;
        };

        pub const intra_refresh_period = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD;
        };

        pub const intra_refresh_period_type = enum(i32) {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE;

            random = 0,
            cyclic = 1,
        };

        pub const mpeg2 = struct {
            pub const Level = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL;

                low = c.V4L2_MPEG_VIDEO_MPEG2_LEVEL_LOW,
                main = c.V4L2_MPEG_VIDEO_MPEG2_LEVEL_MAIN,
                high_1440 = c.V4L2_MPEG_VIDEO_MPEG2_LEVEL_HIGH_1440,
                high = c.V4L2_MPEG_VIDEO_MPEG2_LEVEL_HIGH,
            };

            pub const Profile = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE;

                simple = c.V4L2_MPEG_VIDEO_MPEG2_PROFILE_SIMPLE,
                main = c.V4L2_MPEG_VIDEO_MPEG2_PROFILE_MAIN,
                snr_scalable = c.V4L2_MPEG_VIDEO_MPEG2_PROFILE_SNR_SCALABLE,
                spatially_scalable = c.V4L2_MPEG_VIDEO_MPEG2_PROFILE_SPATIALLY_SCALABLE,
                high = c.V4L2_MPEG_VIDEO_MPEG2_PROFILE_HIGH,
                multiview = c.V4L2_MPEG_VIDEO_MPEG2_PROFILE_MULTIVIEW,
            };
        };

        pub const h263 = struct {
            pub const i_frame_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H263_I_FRAME_QP;
            };

            pub const p_frame_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H263_P_FRAME_QP;
            };

            pub const b_frame_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H263_B_FRAME_QP;
            };

            pub const min_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H263_MIN_QP;
            };

            pub const max_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H263_MAX_QP;
            };
        };

        pub const h264 = struct {
            pub const i_frame_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_I_FRAME_QP;
            };

            pub const p_frame_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_P_FRAME_QP;
            };

            pub const b_frame_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_B_FRAME_QP;
            };

            pub const min_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_MIN_QP;
            };

            pub const max_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_MAX_QP;
            };

            pub const transform_8_x_8 = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_8X8_TRANSFORM;
            };

            pub const cpb_size = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_CPB_SIZE;
            };

            pub const EntropyMode = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_ENTROPY_MODE;

                cavlc = c.V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CAVLC,
                cabac = c.V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC,
            };

            pub const i_period = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_I_PERIOD;
            };

            pub const Level = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_LEVEL;

                lvl_1_0 = c.V4L2_MPEG_VIDEO_H264_LEVEL_1_0,
                lvl_1b = c.V4L2_MPEG_VIDEO_H264_LEVEL_1B,
                lvl_1_1 = c.V4L2_MPEG_VIDEO_H264_LEVEL_1_1,
                lvl_1_2 = c.V4L2_MPEG_VIDEO_H264_LEVEL_1_2,
                lvl_1_3 = c.V4L2_MPEG_VIDEO_H264_LEVEL_1_3,
                lvl_2_0 = c.V4L2_MPEG_VIDEO_H264_LEVEL_2_0,
                lvl_2_1 = c.V4L2_MPEG_VIDEO_H264_LEVEL_2_1,
                lvl_2_2 = c.V4L2_MPEG_VIDEO_H264_LEVEL_2_2,
                lvl_3_0 = c.V4L2_MPEG_VIDEO_H264_LEVEL_3_0,
                lvl_3_1 = c.V4L2_MPEG_VIDEO_H264_LEVEL_3_1,
                lvl_3_2 = c.V4L2_MPEG_VIDEO_H264_LEVEL_3_2,
                lvl_4_0 = c.V4L2_MPEG_VIDEO_H264_LEVEL_4_0,
                lvl_4_1 = c.V4L2_MPEG_VIDEO_H264_LEVEL_4_1,
                lvl_4_2 = c.V4L2_MPEG_VIDEO_H264_LEVEL_4_2,
                lvl_5_0 = c.V4L2_MPEG_VIDEO_H264_LEVEL_5_0,
                lvl_5_1 = c.V4L2_MPEG_VIDEO_H264_LEVEL_5_1,
                lvl_5_2 = c.V4L2_MPEG_VIDEO_H264_LEVEL_5_2,
                lvl_6_0 = c.V4L2_MPEG_VIDEO_H264_LEVEL_6_0,
                lvl_6_1 = c.V4L2_MPEG_VIDEO_H264_LEVEL_6_1,
                lvl_6_2 = c.V4L2_MPEG_VIDEO_H264_LEVEL_6_2,
            };

            pub const loop_filter = struct {
                pub const alpha = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_ALPHA;
                };

                pub const beta = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_BETA;
                };

                pub const Mode = enum(i32) {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_MODE;

                    enabled = c.V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_ENABLED,
                    disabled = c.V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_DISABLED,
                    disabled_at_slice_boundary = c.V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_DISABLED_AT_SLICE_BOUNDARY,
                };
            };

            pub const Profile = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_PROFILE;

                baseline = c.V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
                constrained_baseline = c.V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE,
                main = c.V4L2_MPEG_VIDEO_H264_PROFILE_MAIN,
                extended = c.V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED,
                high = c.V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
                high_10 = c.V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10,
                high_422 = c.V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422,
                high_444_predictive = c.V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_444_PREDICTIVE,
                high_10_intra = c.V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10_INTRA,
                high_422_intra = c.V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422_INTRA,
                high_444_intra = c.V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_444_INTRA,
                cavlc_444_intra = c.V4L2_MPEG_VIDEO_H264_PROFILE_CAVLC_444_INTRA,
                scalable_baseline = c.V4L2_MPEG_VIDEO_H264_PROFILE_SCALABLE_BASELINE,
                scalable_high = c.V4L2_MPEG_VIDEO_H264_PROFILE_SCALABLE_HIGH,
                scalable_high_intra = c.V4L2_MPEG_VIDEO_H264_PROFILE_SCALABLE_HIGH_INTRA,
                stereo_high = c.V4L2_MPEG_VIDEO_H264_PROFILE_STEREO_HIGH,
                multiview_high = c.V4L2_MPEG_VIDEO_H264_PROFILE_MULTIVIEW_HIGH,
                constrained_high = c.V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH,
            };

            pub const vui_sar = struct {
                pub const height = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_VUI_EXT_SAR_HEIGHT;
                };

                pub const width = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_VUI_EXT_SAR_WIDTH;
                };

                pub const enable = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_ENABLE;
                };

                pub const Idc = enum(i32) {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_IDC;

                    idc_unspecified = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_UNSPECIFIED,
                    idc_1X1 = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_1x1,
                    idc_12X11 = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_12x11,
                    idc_10X11 = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_10x11,
                    idc_16X11 = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_16x11,
                    idc_40X33 = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_40x33,
                    idc_24X11 = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_24x11,
                    idc_20X11 = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_20x11,
                    idc_32X11 = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_32x11,
                    idc_80X33 = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_80x33,
                    idc_18X11 = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_18x11,
                    idc_15X11 = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_15x11,
                    idc_64X33 = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_64x33,
                    idc_160X99 = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_160x99,
                    idc_4X3 = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_4x3,
                    idc_3X2 = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_3x2,
                    idc_2X1 = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_2x1,
                    idc_extended = c.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_EXTENDED,
                };
            };

            pub const sei_frame_packing = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_SEI_FRAME_PACKING;

                pub const current_frame = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_SEI_FP_CURRENT_FRAME_0;
                };

                pub const ArrangementType = enum(i32) {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE;

                    checkerboard = c.V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_CHECKERBOARD,
                    column = c.V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_COLUMN,
                    row = c.V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_ROW,
                    side_by_side = c.V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_SIDE_BY_SIDE,
                    top_bottom = c.V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_TOP_BOTTOM,
                    temporal = c.V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_TEMPORAL,
                };
            };

            pub const fmo = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_FMO;

                pub const Type = enum(i32) {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_FMO_MAP_TYPE;

                    interleaved_slices = c.V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_INTERLEAVED_SLICES,
                    scattered_slices = c.V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_SCATTERED_SLICES,
                    foreground_with_left_over = c.V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_FOREGROUND_WITH_LEFT_OVER,
                    box_out = c.V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_BOX_OUT,
                    raster_scan = c.V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_RASTER_SCAN,
                    wipe_scan = c.V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_WIPE_SCAN,
                    explicit = c.V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_EXPLICIT,
                };

                pub const slice_group = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_FMO_SLICE_GROUP;
                };

                pub const ChangeDirection = enum(i32) {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_FMO_CHANGE_DIRECTION;

                    right = c.V4L2_MPEG_VIDEO_H264_FMO_CHANGE_DIR_RIGHT,
                    left = c.V4L2_MPEG_VIDEO_H264_FMO_CHANGE_DIR_LEFT,
                };

                pub const change_rate = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_FMO_CHANGE_RATE;
                };

                pub const run_length = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_FMO_RUN_LENGTH;
                };
            };

            pub const aso = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_ASO;

                pub const slice_order = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_ASO_SLICE_ORDER;
                };
            };

            pub const hierarchical_coding = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING;

                pub const Type = enum(i32) {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_TYPE;

                    V4L2_MPEG_VIDEO_H264_HIERARCHICAL_CODING_B = 0,
                    V4L2_MPEG_VIDEO_H264_HIERARCHICAL_CODING_P = 1,
                };

                pub const layer = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER;
                };
                pub const layer_qp = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER_QP;
                };
            };

            pub const constrained_intra_prediction = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_CONSTRAINED_INTRA_PREDICTION;
            };

            pub const chroma_qp_index_offset = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_CHROMA_QP_INDEX_OFFSET;
            };

            pub const i_frame_min_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP;
            };

            pub const i_frame_max_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP;
            };

            pub const p_frame_min_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP;
            };

            pub const p_frame_max_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP;
            };

            pub const b_frame_min_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_B_FRAME_MIN_QP;
            };

            pub const b_frame_max_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_H264_B_FRAME_MAX_QP;
            };

            pub const hier_coding = struct {
                pub const l0_br: u32 = c.V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L0_BR;
                pub const l1_br: u32 = c.V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L1_BR;
                pub const l2_br: u32 = c.V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L2_BR;
                pub const l3_br: u32 = c.V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L3_BR;
                pub const l4_br: u32 = c.V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L4_BR;
                pub const l5_br: u32 = c.V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L5_BR;
                pub const l6_br: u32 = c.V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L6_BR;
            };
        };

        pub const mpeg4 = struct {
            pub const i_frame_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP;
            };

            pub const p_frame_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP;
            };

            pub const b_frame_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP;
            };

            pub const min_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MPEG4_MIN_QP;
            };

            pub const max_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MPEG4_MAX_QP;
            };

            pub const Level = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MPEG4_LEVEL;

                lvl_0 = c.V4L2_MPEG_VIDEO_MPEG4_LEVEL_0,
                lvl_0B = c.V4L2_MPEG_VIDEO_MPEG4_LEVEL_0B,
                lvl_1 = c.V4L2_MPEG_VIDEO_MPEG4_LEVEL_1,
                lvl_2 = c.V4L2_MPEG_VIDEO_MPEG4_LEVEL_2,
                lvl_3 = c.V4L2_MPEG_VIDEO_MPEG4_LEVEL_3,
                lvl_3B = c.V4L2_MPEG_VIDEO_MPEG4_LEVEL_3B,
                lvl_4 = c.V4L2_MPEG_VIDEO_MPEG4_LEVEL_4,
                lvl_5 = c.V4L2_MPEG_VIDEO_MPEG4_LEVEL_5,
            };

            pub const Profile = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MPEG4_PROFILE;

                simple = c.V4L2_MPEG_VIDEO_MPEG4_PROFILE_SIMPLE,
                advanced_simple = c.V4L2_MPEG_VIDEO_MPEG4_PROFILE_ADVANCED_SIMPLE,
                core = c.V4L2_MPEG_VIDEO_MPEG4_PROFILE_CORE,
                simple_scalable = c.V4L2_MPEG_VIDEO_MPEG4_PROFILE_SIMPLE_SCALABLE,
                advanced_coding_efficiency = c.V4L2_MPEG_VIDEO_MPEG4_PROFILE_ADVANCED_CODING_EFFICIENCY,
            };

            pub const qpel = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_MPEG4_QPEL;
            };
        };

        pub const vp8 = struct {
            pub const NumPartions = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_VPX_NUM_PARTITIONS;

                p1 = c.V4L2_CID_MPEG_VIDEO_VPX_1_PARTITION,
                p2 = c.V4L2_CID_MPEG_VIDEO_VPX_2_PARTITIONS,
                p4 = c.V4L2_CID_MPEG_VIDEO_VPX_4_PARTITIONS,
                p8 = c.V4L2_CID_MPEG_VIDEO_VPX_8_PARTITIONS,
            };

            pub const imd_disable_4x4 = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_VPX_IMD_DISABLE_4X4;
            };

            pub const NumRefFrame = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_VPX_NUM_REF_FRAMES;

                ref_1 = c.V4L2_CID_MPEG_VIDEO_VPX_1_REF_FRAME,
                ref_2 = c.V4L2_CID_MPEG_VIDEO_VPX_2_REF_FRAME,
                ref_3 = c.V4L2_CID_MPEG_VIDEO_VPX_3_REF_FRAME,
            };

            pub const filter_level = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_VPX_FILTER_LEVEL;
            };

            pub const filter_sharpness = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_VPX_FILTER_SHARPNESS;
            };

            pub const golden_frame = struct {
                pub const period = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_REF_PERIOD;
                };

                pub const FrameSel = enum(i32) {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_SEL;

                    use_prev = c.V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_USE_PREV,
                    use_ref_period = c.V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_USE_REF_PERIOD,
                };
            };

            pub const min_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_VPX_MIN_QP;
            };

            pub const max_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_VPX_MAX_QP;
            };
            pub const i_frame_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_VPX_I_FRAME_QP;
            };

            pub const p_frame_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_VPX_P_FRAME_QP;
            };

            pub const Profile = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_VP8_PROFILE;

                p0 = c.V4L2_MPEG_VIDEO_VP8_PROFILE_0,
                p1 = c.V4L2_MPEG_VIDEO_VP8_PROFILE_1,
                p2 = c.V4L2_MPEG_VIDEO_VP8_PROFILE_2,
                p3 = c.V4L2_MPEG_VIDEO_VP8_PROFILE_3,
            };
        };

        pub const vp9 = struct {
            pub const Profile = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_VP9_PROFILE;

                p0 = c.V4L2_MPEG_VIDEO_VP9_PROFILE_0,
                p1 = c.V4L2_MPEG_VIDEO_VP9_PROFILE_1,
                p2 = c.V4L2_MPEG_VIDEO_VP9_PROFILE_2,
                p3 = c.V4L2_MPEG_VIDEO_VP9_PROFILE_3,
            };
            pub const Level = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_VP9_LEVEL;

                lvl_1_0 = c.V4L2_MPEG_VIDEO_VP9_LEVEL_1_0,
                lvl_1_1 = c.V4L2_MPEG_VIDEO_VP9_LEVEL_1_1,
                lvl_2_0 = c.V4L2_MPEG_VIDEO_VP9_LEVEL_2_0,
                lvl_2_1 = c.V4L2_MPEG_VIDEO_VP9_LEVEL_2_1,
                lvl_3_0 = c.V4L2_MPEG_VIDEO_VP9_LEVEL_3_0,
                lvl_3_1 = c.V4L2_MPEG_VIDEO_VP9_LEVEL_3_1,
                lvl_4_0 = c.V4L2_MPEG_VIDEO_VP9_LEVEL_4_0,
                lvl_4_1 = c.V4L2_MPEG_VIDEO_VP9_LEVEL_4_1,
                lvl_5_0 = c.V4L2_MPEG_VIDEO_VP9_LEVEL_5_0,
                lvl_5_1 = c.V4L2_MPEG_VIDEO_VP9_LEVEL_5_1,
                lvl_5_2 = c.V4L2_MPEG_VIDEO_VP9_LEVEL_5_2,
                lvl_6_0 = c.V4L2_MPEG_VIDEO_VP9_LEVEL_6_0,
                lvl_6_1 = c.V4L2_MPEG_VIDEO_VP9_LEVEL_6_1,
                lvl_6_2 = c.V4L2_MPEG_VIDEO_VP9_LEVEL_6_2,
            };
        };

        pub const hvec = struct {
            pub const min_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_MIN_QP;
            };

            pub const max_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_MAX_QP;
            };

            pub const i_frame_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_QP;
            };

            pub const p_frame_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_P_FRAME_QP;
            };

            pub const b_frame_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_B_FRAME_QP;
            };

            pub const hier = struct {
                pub const qp = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_HIER_QP;
                };

                pub const coding = enum(i32) {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_TYPE;

                    b = c.V4L2_MPEG_VIDEO_HEVC_HIERARCHICAL_CODING_B,
                    p = c.V4L2_MPEG_VIDEO_HEVC_HIERARCHICAL_CODING_P,
                };

                pub const layer = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_LAYER;
                    pub const l0: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L0_QP;
                    pub const l1: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L1_QP;
                    pub const l2: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L2_QP;
                    pub const l3: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L3_QP;
                    pub const l4: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L4_QP;
                    pub const l5: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L5_QP;
                    pub const l6: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L6_QP;
                };

                pub const l0_br: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L0_BR;
                pub const l1_br: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L1_BR;
                pub const l2_br: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L2_BR;
                pub const l3_br: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L3_BR;
                pub const l4_br: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L4_BR;
                pub const l5_br: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L5_BR;
                pub const l6_br: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L6_BR;
            };

            pub const Profile = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_PROFILE;

                main = c.V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
                main_still_picture = c.V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE,
                main_10 = c.V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10,
            };

            pub const Level = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_LEVEL;

                lvl_1 = c.V4L2_MPEG_VIDEO_HEVC_LEVEL_1,
                lvl_2 = c.V4L2_MPEG_VIDEO_HEVC_LEVEL_2,
                lvl_2_1 = c.V4L2_MPEG_VIDEO_HEVC_LEVEL_2_1,
                lvl_3 = c.V4L2_MPEG_VIDEO_HEVC_LEVEL_3,
                lvl_3_1 = c.V4L2_MPEG_VIDEO_HEVC_LEVEL_3_1,
                lvl_4 = c.V4L2_MPEG_VIDEO_HEVC_LEVEL_4,
                lvl_4_1 = c.V4L2_MPEG_VIDEO_HEVC_LEVEL_4_1,
                lvl_5 = c.V4L2_MPEG_VIDEO_HEVC_LEVEL_5,
                lvl_5_1 = c.V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1,
                lvl_5_2 = c.V4L2_MPEG_VIDEO_HEVC_LEVEL_5_2,
                lvl_6 = c.V4L2_MPEG_VIDEO_HEVC_LEVEL_6,
                lvl_6_1 = c.V4L2_MPEG_VIDEO_HEVC_LEVEL_6_1,
                lvl_6_2 = c.V4L2_MPEG_VIDEO_HEVC_LEVEL_6_2,
            };

            pub const frame_rate_resolution = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_FRAME_RATE_RESOLUTION;
            };

            pub const Tier = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_TIER;

                main = c.V4L2_MPEG_VIDEO_HEVC_TIER_MAIN,
                high = c.V4L2_MPEG_VIDEO_HEVC_TIER_HIGH,
            };

            pub const partion_depth = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_MAX_PARTITION_DEPTH;
            };

            pub const loop_filter = struct {
                pub const Mode = enum(i32) {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE;

                    disabled = c.V4L2_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE_DISABLED,
                    enabled = c.V4L2_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE_ENABLED,
                    disabled_at_slice_boundary = c.V4L2_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE_DISABLED_AT_SLICE_BOUNDARY,
                };

                pub const beta = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_LF_BETA_OFFSET_DIV2;
                };

                pub const tc = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_LF_TC_OFFSET_DIV2;
                };
            };

            pub const refresh = struct {
                pub const Type = enum(i32) {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_REFRESH_TYPE;

                    none = c.V4L2_MPEG_VIDEO_HEVC_REFRESH_NONE,
                    cra = c.V4L2_MPEG_VIDEO_HEVC_REFRESH_CRA,
                    idr = c.V4L2_MPEG_VIDEO_HEVC_REFRESH_IDR,
                };

                pub const period = struct {
                    pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_REFRESH_PERIOD;
                };
            };

            pub const lossless_cu = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_LOSSLESS_CU;
            };

            pub const intra_pred = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_CONST_INTRA_PRED;
            };

            pub const wavefront = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_WAVEFRONT;
            };

            pub const general_pb = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_GENERAL_PB;
            };

            pub const temporal_id = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_TEMPORAL_ID;
            };

            pub const strong_smoothing = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_STRONG_SMOOTHING;
            };

            pub const max_num_merge_mv_minus1 = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_MAX_NUM_MERGE_MV_MINUS1;
            };

            pub const intra_pu_split = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_INTRA_PU_SPLIT;
            };

            pub const tmv_prediction = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_TMV_PREDICTION;
            };

            pub const without_startcode = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_WITHOUT_STARTCODE;
            };

            pub const LengthField = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_SIZE_OF_LENGTH_FIELD;

                size_0 = c.V4L2_MPEG_VIDEO_HEVC_SIZE_0,
                size_1 = c.V4L2_MPEG_VIDEO_HEVC_SIZE_1,
                size_2 = c.V4L2_MPEG_VIDEO_HEVC_SIZE_2,
                size_4 = c.V4L2_MPEG_VIDEO_HEVC_SIZE_4,
            };

            pub const i_frame_min_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_MIN_QP;
            };

            pub const i_frame_max_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_MAX_QP;
            };

            pub const p_frame_min_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_P_FRAME_MIN_QP;
            };

            pub const p_frame_max_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_P_FRAME_MAX_QP;
            };

            pub const b_frame_min_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_B_FRAME_MIN_QP;
            };

            pub const b_frame_max_qp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_HEVC_B_FRAME_MAX_QP;
            };
        };

        pub const ref_number_per_frames = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES;
        };

        pub const prepend_spspps_to_idr = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR;
        };

        pub const constant_quality = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_CONSTANT_QUALITY;
        };

        pub const frame_skip_mode = struct {
            pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_FRAME_SKIP_MODE;
        };

        pub const av1 = struct {
            pub const Profile = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_AV1_PROFILE;

                main = c.V4L2_MPEG_VIDEO_AV1_PROFILE_MAIN,
                high = c.V4L2_MPEG_VIDEO_AV1_PROFILE_HIGH,
                professional = c.V4L2_MPEG_VIDEO_AV1_PROFILE_PROFESSIONAL,
            };

            pub const Level = enum(i32) {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_AV1_LEVEL;

                lvl_2_0 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_2_0,
                lvl_2_1 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_2_1,
                lvl_2_2 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_2_2,
                lvl_2_3 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_2_3,
                lvl_3_0 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_3_0,
                lvl_3_1 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_3_1,
                lvl_3_2 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_3_2,
                lvl_3_3 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_3_3,
                lvl_4_0 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_4_0,
                lvl_4_1 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_4_1,
                lvl_4_2 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_4_2,
                lvl_4_3 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_4_3,
                lvl_5_0 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_5_0,
                lvl_5_1 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_5_1,
                lvl_5_2 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_5_2,
                lvl_5_3 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_5_3,
                lvl_6_0 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_6_0,
                lvl_6_1 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_6_1,
                lvl_6_2 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_6_2,
                lvl_6_3 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_6_3,
                lvl_7_0 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_7_0,
                lvl_7_1 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_7_1,
                lvl_7_2 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_7_2,
                lvl_7_3 = c.V4L2_MPEG_VIDEO_AV1_LEVEL_7_3,
            };

            pub const AverageQp = struct {
                pub const id: u32 = c.V4L2_CID_MPEG_VIDEO_AVERAGE_QP;
            };
        };
    }; // video

    pub const cx2341x = struct {
        pub const codec = struct {
            pub const base: u32 = c.V4L2_CID_CODEC_CX2341X_BASE;
        };

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

                        OFF = c.V4L2_MPEG_CX2341X_VIDEO_CHROMA_SPATIAL_FILTER_TYPE_OFF,
                        HOR_1D = c.V4L2_MPEG_CX2341X_VIDEO_CHROMA_SPATIAL_FILTER_TYPE_1D_HOR,
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
    };

    pub const mfc51 = struct {
        pub const id: u32 = c.V4L2_CID_CODEC_MFC51_BASE;

        pub const codec = struct {
            pub const id: u32 = c.V4L2_CID_CODEC_MFC51_BASE;
        };

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
    };

    pub const fwht = struct {
        pub const i_frame_qp = struct {
            pub const id: u32 = c.V4L2_CID_FWHT_I_FRAME_QP;
        };

        pub const p_frame_qp = struct {
            pub const id: u32 = c.V4L2_CID_FWHT_P_FRAME_QP;
        };
    };
};

pub const camera = struct {
    pub const base: u32 = c.V4L2_CID_CAMERA_CLASS_BASE;
    pub const class: u32 = c.V4L2_CID_CAMERA_CLASS;

    pub const Exposure = enum(i32) {
        pub const id: u32 = c.V4L2_CID_EXPOSURE_AUTO;
        auto = c.V4L2_EXPOSURE_AUTO,
        manual = c.V4L2_EXPOSURE_MANUAL,
        shutter_priority = c.V4L2_EXPOSURE_SHUTTER_PRIORITY,
        aperture_priority = c.V4L2_EXPOSURE_APERTURE_PRIORITY,

        pub const absolute = struct {
            pub const id: u32 = c.V4L2_CID_EXPOSURE_ABSOLUTE;
        };

        pub const auto_priority = struct {
            pub const id: u32 = c.V4L2_CID_EXPOSURE_AUTO_PRIORITY;
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
    };

    pub const focus = struct {};

    pub const focus_absolute = struct {
        pub const id: u32 = c.V4L2_CID_FOCUS_ABSOLUTE;
    };

    pub const focus_relative = struct {
        pub const id: u32 = c.V4L2_CID_FOCUS_RELATIVE;
    };

    pub const focus_auto = struct {
        pub const id: u32 = c.V4L2_CID_FOCUS_AUTO;
    };

    pub const zoom_absolute = struct {
        pub const id: u32 = c.V4L2_CID_ZOOM_ABSOLUTE;
    };

    pub const zoom_relative = struct {
        pub const id: u32 = c.V4L2_CID_ZOOM_RELATIVE;
    };

    pub const zoom_continuous = struct {
        pub const id: u32 = c.V4L2_CID_ZOOM_CONTINUOUS;
    };

    pub const privacy = struct {
        pub const id: u32 = c.V4L2_CID_PRIVACY;
    };

    pub const iris_absolute = struct {
        pub const id: u32 = c.V4L2_CID_IRIS_ABSOLUTE;
    };

    pub const iris_relative = struct {
        pub const id: u32 = c.V4L2_CID_IRIS_RELATIVE;
    };

    pub const auto_exposure_bias = struct {
        pub const id: u32 = c.V4L2_CID_AUTO_EXPOSURE_BIAS;
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

    pub const ExposureMetering = enum(i32) {
        pub const id: u32 = c.V4L2_CID_EXPOSURE_METERING;

        average = c.V4L2_EXPOSURE_METERING_AVERAGE,
        center_weighted = c.V4L2_EXPOSURE_METERING_CENTER_WEIGHTED,
        spot = c.V4L2_EXPOSURE_METERING_SPOT,
        matrix = c.V4L2_EXPOSURE_METERING_MATRIX,
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

    pub const lock_3a = struct {
        pub const id: u32 = c.V4L2_CID_3A_LOCK;
        pub const exposure: u32 = c.V4L2_LOCK_EXPOSURE;
        pub const white_balance: u32 = c.V4L2_LOCK_WHITE_BALANCE;
        pub const focus: u32 = c.V4L2_LOCK_FOCUS;
    };

    pub const auto_focus = struct {
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

    pub const pan_speed = struct {
        pub const id: u32 = c.V4L2_CID_PAN_SPEED;
    };

    pub const tilt_speed = struct {
        pub const id: u32 = c.V4L2_CID_TILT_SPEED;
    };

    pub const orientation = enum(i32) {
        pub const id: u32 = c.V4L2_CID_CAMERA_ORIENTATION;

        front = c.V4L2_CAMERA_ORIENTATION_FRONT,
        back = c.V4L2_CAMERA_ORIENTATION_BACK,
        external = c.V4L2_CAMERA_ORIENTATION_EXTERNAL,
    };

    pub const sensor_rotation = struct {
        pub const id: u32 = c.V4L2_CID_CAMERA_SENSOR_ROTATION;
    };

    pub const hdr_sensor_mode = struct {
        pub const id: u32 = c.V4L2_CID_HDR_SENSOR_MODE;
    };
};

pub const fm_tx = struct {
    pub const base: u32 = c.V4L2_CID_FM_TX_CLASS_BASE;
    pub const class: u32 = c.V4L2_CID_FM_TX_CLASS;

    pub const rds_tx = struct {
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
};

pub const flash = struct {
    pub const base: u32 = c.V4L2_CID_FLASH_CLASS_BASE;
    pub const class: u32 = c.V4L2_CID_FLASH_CLASS;

    pub const LedMode = enum(i32) {
        pub const id: u32 = c.V4L2_CID_FLASH_LED_MODE;
        none = c.V4L2_FLASH_LED_MODE_NONE,
        flash = c.V4L2_FLASH_LED_MODE_FLASH,
        torch = c.V4L2_FLASH_LED_MODE_TORCH,
    };

    pub const StrobeSource = enum(i32) {
        pub const id: u32 = c.V4L2_CID_FLASH_STROBE_SOURCE;
        software = c.V4L2_FLASH_STROBE_SOURCE_SOFTWARE,
        external = c.V4L2_FLASH_STROBE_SOURCE_EXTERNAL,
    };

    pub const strobe = struct {
        pub const id: u32 = c.V4L2_CID_FLASH_STROBE;
    };

    pub const strobe_stop = struct {
        pub const id: u32 = c.V4L2_CID_FLASH_STROBE_STOP;
    };

    pub const strobe_status = struct {
        pub const id: u32 = c.V4L2_CID_FLASH_STROBE_STATUS;
    };

    pub const timeout = struct {
        pub const id: u32 = c.V4L2_CID_FLASH_TIMEOUT;
    };

    pub const intensity = struct {
        pub const id: u32 = c.V4L2_CID_FLASH_INTENSITY;
    };

    pub const torch_intensity = struct {
        pub const id: u32 = c.V4L2_CID_FLASH_TORCH_INTENSITY;
    };

    pub const indicator_intensity = struct {
        pub const id: u32 = c.V4L2_CID_FLASH_INDICATOR_INTENSITY;
    };

    pub const fault = struct {
        pub const id: u32 = c.V4L2_CID_FLASH_FAULT;
        pub const over_voltage: u32 = c.V4L2_FLASH_FAULT_OVER_VOLTAGE;
        pub const timeout: u32 = c.V4L2_FLASH_FAULT_TIMEOUT;
        pub const over_temperature: u32 = c.V4L2_FLASH_FAULT_OVER_TEMPERATURE;
        pub const short_circuit: u32 = c.V4L2_FLASH_FAULT_SHORT_CIRCUIT;
        pub const over_current: u32 = c.V4L2_FLASH_FAULT_OVER_CURRENT;
        pub const indicator: u32 = c.V4L2_FLASH_FAULT_INDICATOR;
        pub const under_voltage: u32 = c.V4L2_FLASH_FAULT_UNDER_VOLTAGE;
        pub const input_voltage: u32 = c.V4L2_FLASH_FAULT_INPUT_VOLTAGE;
        pub const led_over_temperature: u32 = c.V4L2_FLASH_FAULT_LED_OVER_TEMPERATURE;
    };
    pub const charge = struct {
        pub const id: u32 = c.V4L2_CID_FLASH_CHARGE;
    };
    pub const ready = struct {
        pub const id: u32 = c.V4L2_CID_FLASH_READY;
    };
};

pub const jpeg = struct {
    pub const base: u32 = c.V4L2_CID_JPEG_CLASS_BASE;
    pub const class: u32 = c.V4L2_CID_JPEG_CLASS;
    pub const ChromaSubsampling = enum(i32) {
        pub const id: u32 = c.V4L2_CID_JPEG_CHROMA_SUBSAMPLING;
        s444 = c.V4L2_JPEG_CHROMA_SUBSAMPLING_444,
        s422 = c.V4L2_JPEG_CHROMA_SUBSAMPLING_422,
        s420 = c.V4L2_JPEG_CHROMA_SUBSAMPLING_420,
        s411 = c.V4L2_JPEG_CHROMA_SUBSAMPLING_411,
        s410 = c.V4L2_JPEG_CHROMA_SUBSAMPLING_410,
        gray = c.V4L2_JPEG_CHROMA_SUBSAMPLING_GRAY,
    };
    pub const restart_interval = struct {
        pub const id: u32 = c.V4L2_CID_JPEG_RESTART_INTERVAL;
    };
    pub const compression_quality = struct {
        pub const id: u32 = c.V4L2_CID_JPEG_COMPRESSION_QUALITY;
    };
    pub const active_marker = struct {
        pub const id: u32 = c.V4L2_CID_JPEG_ACTIVE_MARKER;
        pub const app0: u32 = c.V4L2_JPEG_ACTIVE_MARKER_APP0;
        pub const app1: u32 = c.V4L2_JPEG_ACTIVE_MARKER_APP1;
        pub const com: u32 = c.V4L2_JPEG_ACTIVE_MARKER_COM;
        pub const dqt: u32 = c.V4L2_JPEG_ACTIVE_MARKER_DQT;
        pub const dht: u32 = c.V4L2_JPEG_ACTIVE_MARKER_DHT;
    };
};

pub const image_source = struct {
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

pub const image_proc = struct {
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

pub const dv = struct {
    pub const base: u32 = c.V4L2_CID_DV_CLASS_BASE;
    pub const class: u32 = c.V4L2_CID_DV_CLASS;
    pub const tx = struct {
        pub const hotplug = struct {
            pub const id: u32 = c.V4L2_CID_DV_TX_HOTPLUG;
        };
        pub const rxsense = struct {
            pub const id: u32 = c.V4L2_CID_DV_TX_RXSENSE;
        };
        pub const edid_present = struct {
            pub const id: u32 = c.V4L2_CID_DV_TX_EDID_PRESENT;
        };
        pub const TxMode = enum(i32) {
            pub const id: u32 = c.V4L2_CID_DV_TX_MODE;
            dvi_d = c.V4L2_DV_TX_MODE_DVI_D,
            hdmi = c.V4L2_DV_TX_MODE_HDMI,
        };
        pub const RgbRange = enum(i32) {
            pub const id: u32 = c.V4L2_CID_DV_TX_RGB_RANGE;
            auto = c.V4L2_DV_RGB_RANGE_AUTO,
            limited = c.V4L2_DV_RGB_RANGE_LIMITED,
            full = c.V4L2_DV_RGB_RANGE_FULL,
        };
        pub const ItContentType = enum(i32) {
            pub const id: u32 = c.V4L2_CID_DV_TX_IT_CONTENT_TYPE;
            graphics = c.V4L2_DV_IT_CONTENT_TYPE_GRAPHICS,
            photo = c.V4L2_DV_IT_CONTENT_TYPE_PHOTO,
            cinema = c.V4L2_DV_IT_CONTENT_TYPE_CINEMA,
            game = c.V4L2_DV_IT_CONTENT_TYPE_GAME,
            no_itc = c.V4L2_DV_IT_CONTENT_TYPE_NO_ITC,
        };
    };
    pub const rx = struct {
        pub const power_present = struct {
            pub const id: u32 = c.V4L2_CID_DV_RX_POWER_PRESENT;
        };
        pub const rgb_range = struct {
            pub const id: u32 = c.V4L2_CID_DV_RX_RGB_RANGE;
        };
        pub const it_content_type = struct {
            pub const id: u32 = c.V4L2_CID_DV_RX_IT_CONTENT_TYPE;
        };
    };
};

pub const fm_rx = struct {
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

pub const rf_tuner = struct {
    pub const base: u32 = c.V4L2_CID_RF_TUNER_CLASS_BASE;
    pub const class: u32 = c.V4L2_CID_RF_TUNER_CLASS;
    pub const bandwidth_auto = struct {
        pub const id: u32 = c.V4L2_CID_RF_TUNER_BANDWIDTH_AUTO;
    };
    pub const bandwidth = struct {
        pub const id: u32 = c.V4L2_CID_RF_TUNER_BANDWIDTH;
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

pub const detect = struct {
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
};

pub const stateless = struct {
    pub const base: u32 = c.V4L2_CID_CODEC_STATELESS_BASE;
    pub const class: u32 = c.V4L2_CID_CODEC_STATELESS_CLASS;
    pub const h264 = struct {
        pub const DecodeMode = enum(i32) {
            pub const id: u32 = c.V4L2_CID_STATELESS_H264_DECODE_MODE;
            slice_based = c.V4L2_STATELESS_H264_DECODE_MODE_SLICE_BASED,
            frame_based = c.V4L2_STATELESS_H264_DECODE_MODE_FRAME_BASED,
        };
        pub const StartCode = enum(i32) {
            pub const id: u32 = c.V4L2_CID_STATELESS_H264_START_CODE;
            none = c.V4L2_STATELESS_H264_START_CODE_NONE,
            annex_b = c.V4L2_STATELESS_H264_START_CODE_ANNEX_B,
        };
        pub const sps = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_H264_SPS;
        };
        pub const pps = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_H264_PPS;
        };
        pub const scaling_matrix = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_H264_SCALING_MATRIX;
        };
        pub const pred_weights = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_H264_PRED_WEIGHTS;
        };
        pub const slice_params = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_H264_SLICE_PARAMS;
        };
        pub const decode_params = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_H264_DECODE_PARAMS;
        };
    };
    pub const fwht_params = struct {
        pub const id: u32 = c.V4L2_CID_STATELESS_FWHT_PARAMS;
    };
    pub const vp8_frame = struct {
        pub const id: u32 = c.V4L2_CID_STATELESS_VP8_FRAME;
    };
    pub const mpeg2 = struct {
        pub const sequence = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_MPEG2_SEQUENCE;
        };
        pub const picture = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_MPEG2_PICTURE;
        };
        pub const quantisation = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_MPEG2_QUANTISATION;
        };
    };
    pub const hevc = struct {
        pub const sps = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_SPS;
        };
        pub const pps = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_PPS;
        };
        pub const slice_params = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_SLICE_PARAMS;
        };
        pub const scaling_matrix = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_SCALING_MATRIX;
        };
        pub const decode_params = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_DECODE_PARAMS;
        };
        pub const decode_mode = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_DECODE_MODE;
        };
        pub const start_code = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_START_CODE;
        };
        pub const entry_point_offsets = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS;
        };
    };
    pub const vp9 = struct {
        pub const frame = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_VP9_FRAME;
        };
        pub const compressed_hdr = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_VP9_COMPRESSED_HDR;
        };
    };
    pub const av1 = struct {
        pub const sequence = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_AV1_SEQUENCE;
        };
        pub const tile_group_entry = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY;
        };
        pub const frame = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_AV1_FRAME;
        };
        pub const film_grain = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_AV1_FILM_GRAIN;
        };
    };
};

pub const colorimetry = struct {
    pub const base: u32 = c.V4L2_CID_COLORIMETRY_CLASS_BASE;
    pub const class: u32 = c.V4L2_CID_COLORIMETRY_CLASS;
    pub const hdr10_cll_info = struct {
        pub const id: u32 = c.V4L2_CID_COLORIMETRY_HDR10_CLL_INFO;
    };
    pub const hdr10_mastering_display = struct {
        pub const id: u32 = c.V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY;
        // #define V4L2_HDR10_MASTERING_PRIMARIES_X_LOW  5
        // #define V4L2_HDR10_MASTERING_PRIMARIES_X_HIGH 37000
        // #define V4L2_HDR10_MASTERING_PRIMARIES_Y_LOW  5
        // #define V4L2_HDR10_MASTERING_PRIMARIES_Y_HIGH 42000
        // #define V4L2_HDR10_MASTERING_WHITE_POINT_X_LOW  5
        // #define V4L2_HDR10_MASTERING_WHITE_POINT_X_HIGH 37000
        // #define V4L2_HDR10_MASTERING_WHITE_POINT_Y_LOW  5
        // #define V4L2_HDR10_MASTERING_WHITE_POINT_Y_HIGH 42000
        // #define V4L2_HDR10_MASTERING_MAX_LUMA_LOW  50000
        // #define V4L2_HDR10_MASTERING_MAX_LUMA_HIGH 100000000
        // #define V4L2_HDR10_MASTERING_MIN_LUMA_LOW  1
        // #define V4L2_HDR10_MASTERING_MIN_LUMA_HIGH 50000
    };
};

// #define V4L2_CTRL_CLASS_MPEG (V4L2_CTRL_CLASS_CODEC)
pub const V4L2_CID_MPEG_CLASS = struct {
    pub const id: u32 = c.V4L2_CID_MPEG_CLASS;
};
pub const V4L2_CID_MPEG_BASE = struct {
    pub const id: u32 = c.V4L2_CID_MPEG_BASE;
};
pub const V4L2_CID_MPEG_CX2341X_BASE = struct {
    pub const id: u32 = c.V4L2_CID_MPEG_CX2341X_BASE;
};
pub const V4L2_CID_MPEG_MFC51_BASE = struct {
    pub const id: u32 = c.V4L2_CID_MPEG_MFC51_BASE;
};

test "Control ABI matches struct_v4l2_control" {
    const C = c.struct_v4l2_control;
    const Z = Control;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "id"), @offsetOf(Z, "id"));
    try std.testing.expectEqual(@offsetOf(C, "value"), @offsetOf(Z, "value"));
}

test "Control.Ext ABI matches struct_v4l2_ext_control" {
    const C = c.struct_v4l2_ext_control;
    const Z = Control.Ext;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "id"), @offsetOf(Z, "id"));
    try std.testing.expectEqual(@offsetOf(C, "size"), @offsetOf(Z, "size"));
    try std.testing.expectEqual(@offsetOf(C, "reserved2"), @offsetOf(Z, "reserved2"));
}

test "Control.ExtSet ABI matches struct_v4l2_ext_controls" {
    const C = c.struct_v4l2_ext_controls;
    const Z = Control.ExtSet;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "count"), @offsetOf(Z, "count"));
    try std.testing.expectEqual(@offsetOf(C, "error_idx"), @offsetOf(Z, "error_idx"));
    try std.testing.expectEqual(@offsetOf(C, "request_fd"), @offsetOf(Z, "request_fd"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
    try std.testing.expectEqual(@offsetOf(C, "controls"), @offsetOf(Z, "controls"));
}

test "Control.Query ABI matches struct_v4l2_queryctrl" {
    const C = c.struct_v4l2_queryctrl;
    const Z = Control.Query;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "id"), @offsetOf(Z, "id"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "name"), @offsetOf(Z, "name"));
    try std.testing.expectEqual(@offsetOf(C, "minimum"), @offsetOf(Z, "minimum"));
    try std.testing.expectEqual(@offsetOf(C, "maximum"), @offsetOf(Z, "maximum"));
    try std.testing.expectEqual(@offsetOf(C, "step"), @offsetOf(Z, "step"));
    try std.testing.expectEqual(@offsetOf(C, "default_value"), @offsetOf(Z, "default_value"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Control.ExtendedQuery ABI matches struct_v4l2_query_ext_ctrl" {
    const C = c.struct_v4l2_query_ext_ctrl;
    const Z = Control.ExtendedQuery;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "id"), @offsetOf(Z, "id"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "name"), @offsetOf(Z, "name"));
    try std.testing.expectEqual(@offsetOf(C, "minimum"), @offsetOf(Z, "minimum"));
    try std.testing.expectEqual(@offsetOf(C, "maximum"), @offsetOf(Z, "maximum"));
    try std.testing.expectEqual(@offsetOf(C, "step"), @offsetOf(Z, "step"));
    try std.testing.expectEqual(@offsetOf(C, "default_value"), @offsetOf(Z, "default_value"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "elem_size"), @offsetOf(Z, "elem_size"));
    try std.testing.expectEqual(@offsetOf(C, "elems"), @offsetOf(Z, "elems"));
    try std.testing.expectEqual(@offsetOf(C, "nr_of_dims"), @offsetOf(Z, "nr_of_dims"));
    try std.testing.expectEqual(@offsetOf(C, "dims"), @offsetOf(Z, "dims"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Control.MenuQuery ABI matches struct_v4l2_querymenu" {
    const C = c.struct_v4l2_querymenu;
    const Z = Control.MenuQuery;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "id"), @offsetOf(Z, "id"));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}
