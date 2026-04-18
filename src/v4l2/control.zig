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
    }; // audio

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
    }; // mpeg
};

pub const V4L2_CID_MPEG_MFC51_VIDEO_DECODER_H264_DISPLAY_DELAY = struct {};
pub const V4L2_CID_MPEG_MFC51_VIDEO_DECODER_H264_DISPLAY_DELAY_ENABLE = struct {
    pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_DECODER_H264_DISPLAY_DELAY_ENABLE;
};
pub const V4L2_CID_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE = struct {
    pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE;
};
pub const V4L2_CID_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE = struct {
    pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE;
};
pub const V4L2_CID_MPEG_MFC51_VIDEO_PADDING = struct {
    pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_PADDING;
};
pub const V4L2_CID_MPEG_MFC51_VIDEO_PADDING_YUV = struct {
    pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_PADDING_YUV;
};
pub const V4L2_CID_MPEG_MFC51_VIDEO_RC_FIXED_TARGET_BIT = struct {
    pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_RC_FIXED_TARGET_BIT;
};
pub const V4L2_CID_MPEG_MFC51_VIDEO_RC_REACTION_COEFF = struct {
    pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_RC_REACTION_COEFF;
};
pub const V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_ACTIVITY = struct {
    pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_ACTIVITY;
};
pub const V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_DARK = struct {
    pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_DARK;
};
pub const V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_SMOOTH = struct {
    pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_SMOOTH;
};
pub const V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_STATIC = struct {
    pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_STATIC;
};
pub const V4L2_CID_MPEG_MFC51_VIDEO_H264_NUM_REF_PIC_FOR_P = struct {
    pub const id: u32 = c.V4L2_CID_MPEG_MFC51_VIDEO_H264_NUM_REF_PIC_FOR_P;
};
pub const V4L2_CID_CAMERA_CLASS_BASE = struct {
    pub const id: u32 = c.V4L2_CID_CAMERA_CLASS_BASE;
};
pub const V4L2_CID_CAMERA_CLASS = struct {
    pub const id: u32 = c.V4L2_CID_CAMERA_CLASS;
};
pub const V4L2_CID_EXPOSURE_AUTO = struct {
    pub const id: u32 = c.V4L2_CID_EXPOSURE_AUTO;
};
pub const V4L2_CID_EXPOSURE_ABSOLUTE = struct {
    pub const id: u32 = c.V4L2_CID_EXPOSURE_ABSOLUTE;
};
pub const V4L2_CID_EXPOSURE_AUTO_PRIORITY = struct {
    pub const id: u32 = c.V4L2_CID_EXPOSURE_AUTO_PRIORITY;
};
pub const V4L2_CID_PAN_RELATIVE = struct {
    pub const id: u32 = c.V4L2_CID_PAN_RELATIVE;
};
pub const V4L2_CID_TILT_RELATIVE = struct {
    pub const id: u32 = c.V4L2_CID_TILT_RELATIVE;
};
pub const V4L2_CID_PAN_RESET = struct {
    pub const id: u32 = c.V4L2_CID_PAN_RESET;
};
pub const V4L2_CID_TILT_RESET = struct {
    pub const id: u32 = c.V4L2_CID_TILT_RESET;
};
pub const V4L2_CID_PAN_ABSOLUTE = struct {
    pub const id: u32 = c.V4L2_CID_PAN_ABSOLUTE;
};
pub const V4L2_CID_TILT_ABSOLUTE = struct {
    pub const id: u32 = c.V4L2_CID_TILT_ABSOLUTE;
};
pub const V4L2_CID_FOCUS_ABSOLUTE = struct {
    pub const id: u32 = c.V4L2_CID_FOCUS_ABSOLUTE;
};
pub const V4L2_CID_FOCUS_RELATIVE = struct {
    pub const id: u32 = c.V4L2_CID_FOCUS_RELATIVE;
};
pub const V4L2_CID_FOCUS_AUTO = struct {
    pub const id: u32 = c.V4L2_CID_FOCUS_AUTO;
};
pub const V4L2_CID_ZOOM_ABSOLUTE = struct {
    pub const id: u32 = c.V4L2_CID_ZOOM_ABSOLUTE;
};
pub const V4L2_CID_ZOOM_RELATIVE = struct {
    pub const id: u32 = c.V4L2_CID_ZOOM_RELATIVE;
};
pub const V4L2_CID_ZOOM_CONTINUOUS = struct {
    pub const id: u32 = c.V4L2_CID_ZOOM_CONTINUOUS;
};
pub const V4L2_CID_PRIVACY = struct {
    pub const id: u32 = c.V4L2_CID_PRIVACY;
};
pub const V4L2_CID_IRIS_ABSOLUTE = struct {
    pub const id: u32 = c.V4L2_CID_IRIS_ABSOLUTE;
};
pub const V4L2_CID_IRIS_RELATIVE = struct {
    pub const id: u32 = c.V4L2_CID_IRIS_RELATIVE;
};
pub const V4L2_CID_AUTO_EXPOSURE_BIAS = struct {
    pub const id: u32 = c.V4L2_CID_AUTO_EXPOSURE_BIAS;
};
pub const V4L2_CID_AUTO_N_PRESET_WHITE_BALANCE = struct {
    pub const id: u32 = c.V4L2_CID_AUTO_N_PRESET_WHITE_BALANCE;
};
pub const V4L2_CID_WIDE_DYNAMIC_RANGE = struct {
    pub const id: u32 = c.V4L2_CID_WIDE_DYNAMIC_RANGE;
};
pub const V4L2_CID_IMAGE_STABILIZATION = struct {
    pub const id: u32 = c.V4L2_CID_IMAGE_STABILIZATION;
};
pub const V4L2_CID_ISO_SENSITIVITY = struct {
    pub const id: u32 = c.V4L2_CID_ISO_SENSITIVITY;
};
pub const V4L2_CID_ISO_SENSITIVITY_AUTO = struct {
    pub const id: u32 = c.V4L2_CID_ISO_SENSITIVITY_AUTO;
};
pub const V4L2_CID_EXPOSURE_METERING = struct {
    pub const id: u32 = c.V4L2_CID_EXPOSURE_METERING;
};
pub const V4L2_CID_SCENE_MODE = struct {
    pub const id: u32 = c.V4L2_CID_SCENE_MODE;
};
pub const V4L2_CID_3A_LOCK = struct {
    pub const id: u32 = c.V4L2_CID_3A_LOCK;
};
pub const V4L2_LOCK_EXPOSURE = struct {
    pub const id: u32 = c.V4L2_LOCK_EXPOSURE;
};
pub const V4L2_LOCK_WHITE_BALANCE = struct {
    pub const id: u32 = c.V4L2_LOCK_WHITE_BALANCE;
};
pub const V4L2_LOCK_FOCUS = struct {
    pub const id: u32 = c.V4L2_LOCK_FOCUS;
};
pub const V4L2_CID_AUTO_FOCUS_START = struct {
    pub const id: u32 = c.V4L2_CID_AUTO_FOCUS_START;
};
pub const V4L2_CID_AUTO_FOCUS_STOP = struct {
    pub const id: u32 = c.V4L2_CID_AUTO_FOCUS_STOP;
};
pub const V4L2_CID_AUTO_FOCUS_STATUS = struct {
    pub const id: u32 = c.V4L2_CID_AUTO_FOCUS_STATUS;
};
pub const V4L2_AUTO_FOCUS_STATUS_IDLE = struct {
    pub const id: u32 = c.V4L2_AUTO_FOCUS_STATUS_IDLE;
};
pub const V4L2_AUTO_FOCUS_STATUS_BUSY = struct {
    pub const id: u32 = c.V4L2_AUTO_FOCUS_STATUS_BUSY;
};
pub const V4L2_AUTO_FOCUS_STATUS_REACHED = struct {
    pub const id: u32 = c.V4L2_AUTO_FOCUS_STATUS_REACHED;
};
pub const V4L2_AUTO_FOCUS_STATUS_FAILED = struct {
    pub const id: u32 = c.V4L2_AUTO_FOCUS_STATUS_FAILED;
};
pub const V4L2_CID_AUTO_FOCUS_RANGE = struct {
    pub const id: u32 = c.V4L2_CID_AUTO_FOCUS_RANGE;
};
pub const V4L2_CID_PAN_SPEED = struct {
    pub const id: u32 = c.V4L2_CID_PAN_SPEED;
};
pub const V4L2_CID_TILT_SPEED = struct {
    pub const id: u32 = c.V4L2_CID_TILT_SPEED;
};
pub const V4L2_CID_CAMERA_ORIENTATION = struct {
    pub const id: u32 = c.V4L2_CID_CAMERA_ORIENTATION;
};

// #define V4L2_CAMERA_ORIENTATION_FRONT  0
// #define V4L2_CAMERA_ORIENTATION_BACK  1
// #define V4L2_CAMERA_ORIENTATION_EXTERNAL 2

pub const V4L2_CID_CAMERA_SENSOR_ROTATION = struct {
    pub const id: u32 = c.V4L2_CID_CAMERA_SENSOR_ROTATION;
};
pub const V4L2_CID_HDR_SENSOR_MODE = struct {
    pub const id: u32 = c.V4L2_CID_HDR_SENSOR_MODE;
};
pub const V4L2_CID_FM_TX_CLASS_BASE = struct {
    pub const id: u32 = c.V4L2_CID_FM_TX_CLASS_BASE;
};
pub const V4L2_CID_FM_TX_CLASS = struct {
    pub const id: u32 = c.V4L2_CID_FM_TX_CLASS;
};
pub const V4L2_CID_RDS_TX_DEVIATION = struct {
    pub const id: u32 = c.V4L2_CID_RDS_TX_DEVIATION;
};
pub const V4L2_CID_RDS_TX_PI = struct {
    pub const id: u32 = c.V4L2_CID_RDS_TX_PI;
};
pub const V4L2_CID_RDS_TX_PTY = struct {
    pub const id: u32 = c.V4L2_CID_RDS_TX_PTY;
};
pub const V4L2_CID_RDS_TX_PS_NAME = struct {
    pub const id: u32 = c.V4L2_CID_RDS_TX_PS_NAME;
};
pub const V4L2_CID_RDS_TX_RADIO_TEXT = struct {
    pub const id: u32 = c.V4L2_CID_RDS_TX_RADIO_TEXT;
};
pub const V4L2_CID_RDS_TX_MONO_STEREO = struct {
    pub const id: u32 = c.V4L2_CID_RDS_TX_MONO_STEREO;
};
pub const V4L2_CID_RDS_TX_ARTIFICIAL_HEAD = struct {
    pub const id: u32 = c.V4L2_CID_RDS_TX_ARTIFICIAL_HEAD;
};
pub const V4L2_CID_RDS_TX_COMPRESSED = struct {
    pub const id: u32 = c.V4L2_CID_RDS_TX_COMPRESSED;
};
pub const V4L2_CID_RDS_TX_DYNAMIC_PTY = struct {
    pub const id: u32 = c.V4L2_CID_RDS_TX_DYNAMIC_PTY;
};
pub const V4L2_CID_RDS_TX_TRAFFIC_ANNOUNCEMENT = struct {
    pub const id: u32 = c.V4L2_CID_RDS_TX_TRAFFIC_ANNOUNCEMENT;
};
pub const V4L2_CID_RDS_TX_TRAFFIC_PROGRAM = struct {
    pub const id: u32 = c.V4L2_CID_RDS_TX_TRAFFIC_PROGRAM;
};
pub const V4L2_CID_RDS_TX_MUSIC_SPEECH = struct {
    pub const id: u32 = c.V4L2_CID_RDS_TX_MUSIC_SPEECH;
};
pub const V4L2_CID_RDS_TX_ALT_FREQS_ENABLE = struct {
    pub const id: u32 = c.V4L2_CID_RDS_TX_ALT_FREQS_ENABLE;
};
pub const V4L2_CID_RDS_TX_ALT_FREQS = struct {
    pub const id: u32 = c.V4L2_CID_RDS_TX_ALT_FREQS;
};
pub const V4L2_CID_AUDIO_LIMITER_ENABLED = struct {
    pub const id: u32 = c.V4L2_CID_AUDIO_LIMITER_ENABLED;
};
pub const V4L2_CID_AUDIO_LIMITER_RELEASE_TIME = struct {
    pub const id: u32 = c.V4L2_CID_AUDIO_LIMITER_RELEASE_TIME;
};
pub const V4L2_CID_AUDIO_LIMITER_DEVIATION = struct {
    pub const id: u32 = c.V4L2_CID_AUDIO_LIMITER_DEVIATION;
};
pub const V4L2_CID_AUDIO_COMPRESSION_ENABLED = struct {
    pub const id: u32 = c.V4L2_CID_AUDIO_COMPRESSION_ENABLED;
};
pub const V4L2_CID_AUDIO_COMPRESSION_GAIN = struct {
    pub const id: u32 = c.V4L2_CID_AUDIO_COMPRESSION_GAIN;
};
pub const V4L2_CID_AUDIO_COMPRESSION_THRESHOLD = struct {
    pub const id: u32 = c.V4L2_CID_AUDIO_COMPRESSION_THRESHOLD;
};
pub const V4L2_CID_AUDIO_COMPRESSION_ATTACK_TIME = struct {
    pub const id: u32 = c.V4L2_CID_AUDIO_COMPRESSION_ATTACK_TIME;
};
pub const V4L2_CID_AUDIO_COMPRESSION_RELEASE_TIME = struct {
    pub const id: u32 = c.V4L2_CID_AUDIO_COMPRESSION_RELEASE_TIME;
};
pub const V4L2_CID_PILOT_TONE_ENABLED = struct {
    pub const id: u32 = c.V4L2_CID_PILOT_TONE_ENABLED;
};
pub const V4L2_CID_PILOT_TONE_DEVIATION = struct {
    pub const id: u32 = c.V4L2_CID_PILOT_TONE_DEVIATION;
};
pub const V4L2_CID_PILOT_TONE_FREQUENCY = struct {
    pub const id: u32 = c.V4L2_CID_PILOT_TONE_FREQUENCY;
};
pub const V4L2_CID_TUNE_PREEMPHASIS = struct {
    pub const id: u32 = c.V4L2_CID_TUNE_PREEMPHASIS;
};
pub const V4L2_CID_TUNE_POWER_LEVEL = struct {
    pub const id: u32 = c.V4L2_CID_TUNE_POWER_LEVEL;
};
pub const V4L2_CID_TUNE_ANTENNA_CAPACITOR = struct {
    pub const id: u32 = c.V4L2_CID_TUNE_ANTENNA_CAPACITOR;
};
pub const V4L2_CID_FLASH_CLASS_BASE = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_CLASS_BASE;
};
pub const V4L2_CID_FLASH_CLASS = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_CLASS;
};
pub const V4L2_CID_FLASH_LED_MODE = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_LED_MODE;
};
pub const V4L2_CID_FLASH_STROBE_SOURCE = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_STROBE_SOURCE;
};
pub const V4L2_CID_FLASH_STROBE = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_STROBE;
};
pub const V4L2_CID_FLASH_STROBE_STOP = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_STROBE_STOP;
};
pub const V4L2_CID_FLASH_STROBE_STATUS = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_STROBE_STATUS;
};
pub const V4L2_CID_FLASH_TIMEOUT = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_TIMEOUT;
};
pub const V4L2_CID_FLASH_INTENSITY = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_INTENSITY;
};
pub const V4L2_CID_FLASH_TORCH_INTENSITY = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_TORCH_INTENSITY;
};
pub const V4L2_CID_FLASH_INDICATOR_INTENSITY = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_INDICATOR_INTENSITY;
};
pub const V4L2_CID_FLASH_FAULT = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_FAULT;
};
pub const V4L2_FLASH_FAULT_OVER_VOLTAGE = struct {
    pub const id: u32 = c.V4L2_FLASH_FAULT_OVER_VOLTAGE;
};
pub const V4L2_FLASH_FAULT_TIMEOUT = struct {
    pub const id: u32 = c.V4L2_FLASH_FAULT_TIMEOUT;
};
pub const V4L2_FLASH_FAULT_OVER_TEMPERATURE = struct {
    pub const id: u32 = c.V4L2_FLASH_FAULT_OVER_TEMPERATURE;
};
pub const V4L2_FLASH_FAULT_SHORT_CIRCUIT = struct {
    pub const id: u32 = c.V4L2_FLASH_FAULT_SHORT_CIRCUIT;
};
pub const V4L2_FLASH_FAULT_OVER_CURRENT = struct {
    pub const id: u32 = c.V4L2_FLASH_FAULT_OVER_CURRENT;
};
pub const V4L2_FLASH_FAULT_INDICATOR = struct {
    pub const id: u32 = c.V4L2_FLASH_FAULT_INDICATOR;
};
pub const V4L2_FLASH_FAULT_UNDER_VOLTAGE = struct {
    pub const id: u32 = c.V4L2_FLASH_FAULT_UNDER_VOLTAGE;
};
pub const V4L2_FLASH_FAULT_INPUT_VOLTAGE = struct {
    pub const id: u32 = c.V4L2_FLASH_FAULT_INPUT_VOLTAGE;
};
pub const V4L2_FLASH_FAULT_LED_OVER_TEMPERATURE = struct {
    pub const id: u32 = c.V4L2_FLASH_FAULT_LED_OVER_TEMPERATURE;
};
pub const V4L2_CID_FLASH_CHARGE = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_CHARGE;
};
pub const V4L2_CID_FLASH_READY = struct {
    pub const id: u32 = c.V4L2_CID_FLASH_READY;
};
pub const V4L2_CID_JPEG_CLASS_BASE = struct {
    pub const id: u32 = c.V4L2_CID_JPEG_CLASS_BASE;
};
pub const V4L2_CID_JPEG_CLASS = struct {
    pub const id: u32 = c.V4L2_CID_JPEG_CLASS;
};
pub const V4L2_CID_JPEG_CHROMA_SUBSAMPLING = struct {
    pub const id: u32 = c.V4L2_CID_JPEG_CHROMA_SUBSAMPLING;
};
pub const V4L2_CID_JPEG_RESTART_INTERVAL = struct {
    pub const id: u32 = c.V4L2_CID_JPEG_RESTART_INTERVAL;
};
pub const V4L2_CID_JPEG_COMPRESSION_QUALITY = struct {
    pub const id: u32 = c.V4L2_CID_JPEG_COMPRESSION_QUALITY;
};
pub const V4L2_CID_JPEG_ACTIVE_MARKER = struct {
    pub const id: u32 = c.V4L2_CID_JPEG_ACTIVE_MARKER;
};
pub const V4L2_JPEG_ACTIVE_MARKER_APP0 = struct {
    pub const id: u32 = c.V4L2_JPEG_ACTIVE_MARKER_APP0;
};
pub const V4L2_JPEG_ACTIVE_MARKER_APP1 = struct {
    pub const id: u32 = c.V4L2_JPEG_ACTIVE_MARKER_APP1;
};
pub const V4L2_JPEG_ACTIVE_MARKER_COM = struct {
    pub const id: u32 = c.V4L2_JPEG_ACTIVE_MARKER_COM;
};
pub const V4L2_JPEG_ACTIVE_MARKER_DQT = struct {
    pub const id: u32 = c.V4L2_JPEG_ACTIVE_MARKER_DQT;
};
pub const V4L2_JPEG_ACTIVE_MARKER_DHT = struct {
    pub const id: u32 = c.V4L2_JPEG_ACTIVE_MARKER_DHT;
};
pub const V4L2_CID_IMAGE_SOURCE_CLASS_BASE = struct {
    pub const id: u32 = c.V4L2_CID_IMAGE_SOURCE_CLASS_BASE;
};
pub const V4L2_CID_IMAGE_SOURCE_CLASS = struct {
    pub const id: u32 = c.V4L2_CID_IMAGE_SOURCE_CLASS;
};
pub const V4L2_CID_VBLANK = struct {
    pub const id: u32 = c.V4L2_CID_VBLANK;
};
pub const V4L2_CID_HBLANK = struct {
    pub const id: u32 = c.V4L2_CID_HBLANK;
};
pub const V4L2_CID_ANALOGUE_GAIN = struct {
    pub const id: u32 = c.V4L2_CID_ANALOGUE_GAIN;
};
pub const V4L2_CID_TEST_PATTERN_RED = struct {
    pub const id: u32 = c.V4L2_CID_TEST_PATTERN_RED;
};
pub const V4L2_CID_TEST_PATTERN_GREENR = struct {
    pub const id: u32 = c.V4L2_CID_TEST_PATTERN_GREENR;
};
pub const V4L2_CID_TEST_PATTERN_BLUE = struct {
    pub const id: u32 = c.V4L2_CID_TEST_PATTERN_BLUE;
};
pub const V4L2_CID_TEST_PATTERN_GREENB = struct {
    pub const id: u32 = c.V4L2_CID_TEST_PATTERN_GREENB;
};
pub const V4L2_CID_UNIT_CELL_SIZE = struct {
    pub const id: u32 = c.V4L2_CID_UNIT_CELL_SIZE;
};
pub const V4L2_CID_NOTIFY_GAINS = struct {
    pub const id: u32 = c.V4L2_CID_NOTIFY_GAINS;
};
pub const V4L2_CID_IMAGE_PROC_CLASS_BASE = struct {
    pub const id: u32 = c.V4L2_CID_IMAGE_PROC_CLASS_BASE;
};
pub const V4L2_CID_IMAGE_PROC_CLASS = struct {
    pub const id: u32 = c.V4L2_CID_IMAGE_PROC_CLASS;
};
pub const V4L2_CID_LINK_FREQ = struct {
    pub const id: u32 = c.V4L2_CID_LINK_FREQ;
};
pub const V4L2_CID_PIXEL_RATE = struct {
    pub const id: u32 = c.V4L2_CID_PIXEL_RATE;
};
pub const V4L2_CID_TEST_PATTERN = struct {
    pub const id: u32 = c.V4L2_CID_TEST_PATTERN;
};
pub const V4L2_CID_DEINTERLACING_MODE = struct {
    pub const id: u32 = c.V4L2_CID_DEINTERLACING_MODE;
};
pub const V4L2_CID_DIGITAL_GAIN = struct {
    pub const id: u32 = c.V4L2_CID_DIGITAL_GAIN;
};
pub const V4L2_CID_DV_CLASS_BASE = struct {
    pub const id: u32 = c.V4L2_CID_DV_CLASS_BASE;
};
pub const V4L2_CID_DV_CLASS = struct {
    pub const id: u32 = c.V4L2_CID_DV_CLASS;
};
pub const V4L2_CID_DV_TX_HOTPLUG = struct {
    pub const id: u32 = c.V4L2_CID_DV_TX_HOTPLUG;
};
pub const V4L2_CID_DV_TX_RXSENSE = struct {
    pub const id: u32 = c.V4L2_CID_DV_TX_RXSENSE;
};
pub const V4L2_CID_DV_TX_EDID_PRESENT = struct {
    pub const id: u32 = c.V4L2_CID_DV_TX_EDID_PRESENT;
};
pub const V4L2_CID_DV_TX_MODE = struct {
    pub const id: u32 = c.V4L2_CID_DV_TX_MODE;
};
pub const V4L2_CID_DV_TX_RGB_RANGE = struct {
    pub const id: u32 = c.V4L2_CID_DV_TX_RGB_RANGE;
};
pub const V4L2_CID_DV_TX_IT_CONTENT_TYPE = struct {
    pub const id: u32 = c.V4L2_CID_DV_TX_IT_CONTENT_TYPE;
};
pub const V4L2_CID_DV_RX_POWER_PRESENT = struct {
    pub const id: u32 = c.V4L2_CID_DV_RX_POWER_PRESENT;
};
pub const V4L2_CID_DV_RX_RGB_RANGE = struct {
    pub const id: u32 = c.V4L2_CID_DV_RX_RGB_RANGE;
};
pub const V4L2_CID_DV_RX_IT_CONTENT_TYPE = struct {
    pub const id: u32 = c.V4L2_CID_DV_RX_IT_CONTENT_TYPE;
};
pub const V4L2_CID_FM_RX_CLASS_BASE = struct {
    pub const id: u32 = c.V4L2_CID_FM_RX_CLASS_BASE;
};
pub const V4L2_CID_FM_RX_CLASS = struct {
    pub const id: u32 = c.V4L2_CID_FM_RX_CLASS;
};
pub const V4L2_CID_TUNE_DEEMPHASIS = struct {
    pub const id: u32 = c.V4L2_CID_TUNE_DEEMPHASIS;
};
pub const V4L2_CID_RDS_RECEPTION = struct {
    pub const id: u32 = c.V4L2_CID_RDS_RECEPTION;
};
pub const V4L2_CID_RDS_RX_PTY = struct {
    pub const id: u32 = c.V4L2_CID_RDS_RX_PTY;
};
pub const V4L2_CID_RDS_RX_PS_NAME = struct {
    pub const id: u32 = c.V4L2_CID_RDS_RX_PS_NAME;
};
pub const V4L2_CID_RDS_RX_RADIO_TEXT = struct {
    pub const id: u32 = c.V4L2_CID_RDS_RX_RADIO_TEXT;
};
pub const V4L2_CID_RDS_RX_TRAFFIC_ANNOUNCEMENT = struct {
    pub const id: u32 = c.V4L2_CID_RDS_RX_TRAFFIC_ANNOUNCEMENT;
};
pub const V4L2_CID_RDS_RX_TRAFFIC_PROGRAM = struct {
    pub const id: u32 = c.V4L2_CID_RDS_RX_TRAFFIC_PROGRAM;
};
pub const V4L2_CID_RDS_RX_MUSIC_SPEECH = struct {
    pub const id: u32 = c.V4L2_CID_RDS_RX_MUSIC_SPEECH;
};
pub const V4L2_CID_RF_TUNER_CLASS_BASE = struct {
    pub const id: u32 = c.V4L2_CID_RF_TUNER_CLASS_BASE;
};
pub const V4L2_CID_RF_TUNER_CLASS = struct {
    pub const id: u32 = c.V4L2_CID_RF_TUNER_CLASS;
};
pub const V4L2_CID_RF_TUNER_BANDWIDTH_AUTO = struct {
    pub const id: u32 = c.V4L2_CID_RF_TUNER_BANDWIDTH_AUTO;
};
pub const V4L2_CID_RF_TUNER_BANDWIDTH = struct {
    pub const id: u32 = c.V4L2_CID_RF_TUNER_BANDWIDTH;
};
pub const V4L2_CID_RF_TUNER_RF_GAIN = struct {
    pub const id: u32 = c.V4L2_CID_RF_TUNER_RF_GAIN;
};
pub const V4L2_CID_RF_TUNER_LNA_GAIN_AUTO = struct {
    pub const id: u32 = c.V4L2_CID_RF_TUNER_LNA_GAIN_AUTO;
};
pub const V4L2_CID_RF_TUNER_LNA_GAIN = struct {
    pub const id: u32 = c.V4L2_CID_RF_TUNER_LNA_GAIN;
};
pub const V4L2_CID_RF_TUNER_MIXER_GAIN_AUTO = struct {
    pub const id: u32 = c.V4L2_CID_RF_TUNER_MIXER_GAIN_AUTO;
};
pub const V4L2_CID_RF_TUNER_MIXER_GAIN = struct {
    pub const id: u32 = c.V4L2_CID_RF_TUNER_MIXER_GAIN;
};
pub const V4L2_CID_RF_TUNER_IF_GAIN_AUTO = struct {
    pub const id: u32 = c.V4L2_CID_RF_TUNER_IF_GAIN_AUTO;
};
pub const V4L2_CID_RF_TUNER_IF_GAIN = struct {
    pub const id: u32 = c.V4L2_CID_RF_TUNER_IF_GAIN;
};
pub const V4L2_CID_RF_TUNER_PLL_LOCK = struct {
    pub const id: u32 = c.V4L2_CID_RF_TUNER_PLL_LOCK;
};
pub const V4L2_CID_DETECT_CLASS_BASE = struct {
    pub const id: u32 = c.V4L2_CID_DETECT_CLASS_BASE;
};
pub const V4L2_CID_DETECT_CLASS = struct {
    pub const id: u32 = c.V4L2_CID_DETECT_CLASS;
};
pub const V4L2_CID_DETECT_MD_MODE = struct {
    pub const id: u32 = c.V4L2_CID_DETECT_MD_MODE;
};
pub const V4L2_CID_DETECT_MD_GLOBAL_THRESHOLD = struct {
    pub const id: u32 = c.V4L2_CID_DETECT_MD_GLOBAL_THRESHOLD;
};
pub const V4L2_CID_DETECT_MD_THRESHOLD_GRID = struct {
    pub const id: u32 = c.V4L2_CID_DETECT_MD_THRESHOLD_GRID;
};
pub const V4L2_CID_DETECT_MD_REGION_GRID = struct {
    pub const id: u32 = c.V4L2_CID_DETECT_MD_REGION_GRID;
};
pub const V4L2_CID_CODEC_STATELESS_BASE = struct {
    pub const id: u32 = c.V4L2_CID_CODEC_STATELESS_BASE;
};
pub const V4L2_CID_CODEC_STATELESS_CLASS = struct {
    pub const id: u32 = c.V4L2_CID_CODEC_STATELESS_CLASS;
};
pub const V4L2_CID_STATELESS_H264_DECODE_MODE = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_H264_DECODE_MODE;
};
pub const V4L2_CID_STATELESS_H264_START_CODE = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_H264_START_CODE;
};

// #define V4L2_H264_SPS_CONSTRAINT_SET0_FLAG   0x01
// #define V4L2_H264_SPS_CONSTRAINT_SET1_FLAG   0x02
// #define V4L2_H264_SPS_CONSTRAINT_SET2_FLAG   0x04
// #define V4L2_H264_SPS_CONSTRAINT_SET3_FLAG   0x08
// #define V4L2_H264_SPS_CONSTRAINT_SET4_FLAG   0x10
// #define V4L2_H264_SPS_CONSTRAINT_SET5_FLAG   0x20
// #define V4L2_H264_SPS_FLAG_SEPARATE_COLOUR_PLANE  0x01
// #define V4L2_H264_SPS_FLAG_QPPRIME_Y_ZERO_TRANSFORM_BYPASS 0x02
// #define V4L2_H264_SPS_FLAG_DELTA_PIC_ORDER_ALWAYS_ZERO  0x04
// #define V4L2_H264_SPS_FLAG_GAPS_IN_FRAME_NUM_VALUE_ALLOWED 0x08
// #define V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY   0x10
// #define V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD  0x20
// #define V4L2_H264_SPS_FLAG_DIRECT_8X8_INFERENCE   0x40
// #define V4L2_H264_SPS_HAS_CHROMA_FORMAT(sps) \
pub const V4L2_CID_STATELESS_H264_SPS = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_H264_SPS;
};
// #define V4L2_H264_PPS_FLAG_ENTROPY_CODING_MODE    0x0001
// #define V4L2_H264_PPS_FLAG_BOTTOM_FIELD_PIC_ORDER_IN_FRAME_PRESENT 0x0002
// #define V4L2_H264_PPS_FLAG_WEIGHTED_PRED    0x0004
// #define V4L2_H264_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT  0x0008
// #define V4L2_H264_PPS_FLAG_CONSTRAINED_INTRA_PRED   0x0010
// #define V4L2_H264_PPS_FLAG_REDUNDANT_PIC_CNT_PRESENT   0x0020
// #define V4L2_H264_PPS_FLAG_TRANSFORM_8X8_MODE    0x0040
// #define V4L2_H264_PPS_FLAG_SCALING_MATRIX_PRESENT   0x0080
pub const V4L2_CID_STATELESS_H264_PPS = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_H264_PPS;
};
pub const V4L2_CID_STATELESS_H264_SCALING_MATRIX = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_H264_SCALING_MATRIX;
};
// #define V4L2_H264_CTRL_PRED_WEIGHTS_REQUIRED(pps, slice) \
pub const V4L2_CID_STATELESS_H264_PRED_WEIGHTS = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_H264_PRED_WEIGHTS;
};
// #define V4L2_H264_SLICE_TYPE_P    0
// #define V4L2_H264_SLICE_TYPE_B    1
// #define V4L2_H264_SLICE_TYPE_I    2
// #define V4L2_H264_SLICE_TYPE_SP    3
// #define V4L2_H264_SLICE_TYPE_SI    4
// #define V4L2_H264_SLICE_FLAG_DIRECT_SPATIAL_MV_PRED 0x01
// #define V4L2_H264_SLICE_FLAG_SP_FOR_SWITCH  0x02
// #define V4L2_H264_TOP_FIELD_REF    0x1
// #define V4L2_H264_BOTTOM_FIELD_REF   0x2
// #define V4L2_H264_FRAME_REF    0x3
// #define V4L2_H264_NUM_DPB_ENTRIES 16
// #define V4L2_H264_REF_LIST_LEN (2 * V4L2_H264_NUM_DPB_ENTRIES)

pub const V4L2_CID_STATELESS_H264_SLICE_PARAMS = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_H264_SLICE_PARAMS;
};
// #define V4L2_H264_DPB_ENTRY_FLAG_VALID  0x01
// #define V4L2_H264_DPB_ENTRY_FLAG_ACTIVE  0x02
// #define V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM 0x04
// #define V4L2_H264_DPB_ENTRY_FLAG_FIELD  0x08
// #define V4L2_H264_DECODE_PARAM_FLAG_IDR_PIC  0x01
// #define V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC  0x02
// #define V4L2_H264_DECODE_PARAM_FLAG_BOTTOM_FIELD 0x04
// #define V4L2_H264_DECODE_PARAM_FLAG_PFRAME  0x08
// #define V4L2_H264_DECODE_PARAM_FLAG_BFRAME  0x10
pub const V4L2_CID_STATELESS_H264_DECODE_PARAMS = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_H264_DECODE_PARAMS;
};
// #define V4L2_FWHT_VERSION   3
// #define V4L2_FWHT_FL_IS_INTERLACED  _BITUL(0)
// #define V4L2_FWHT_FL_IS_BOTTOM_FIRST  _BITUL(1)
// #define V4L2_FWHT_FL_IS_ALTERNATE  _BITUL(2)
// #define V4L2_FWHT_FL_IS_BOTTOM_FIELD  _BITUL(3)
// #define V4L2_FWHT_FL_LUMA_IS_UNCOMPRESSED _BITUL(4)
// #define V4L2_FWHT_FL_CB_IS_UNCOMPRESSED  _BITUL(5)
// #define V4L2_FWHT_FL_CR_IS_UNCOMPRESSED  _BITUL(6)
// #define V4L2_FWHT_FL_CHROMA_FULL_HEIGHT  _BITUL(7)
// #define V4L2_FWHT_FL_CHROMA_FULL_WIDTH  _BITUL(8)
// #define V4L2_FWHT_FL_ALPHA_IS_UNCOMPRESSED _BITUL(9)
// #define V4L2_FWHT_FL_I_FRAME   _BITUL(10)
// #define V4L2_FWHT_FL_COMPONENTS_NUM_MSK  GENMASK(18, 16)
// #define V4L2_FWHT_FL_COMPONENTS_NUM_OFFSET 16
// #define V4L2_FWHT_FL_PIXENC_MSK   GENMASK(20, 19)
// #define V4L2_FWHT_FL_PIXENC_OFFSET  19
// #define V4L2_FWHT_FL_PIXENC_YUV   (1 << V4L2_FWHT_FL_PIXENC_OFFSET)
// #define V4L2_FWHT_FL_PIXENC_RGB   (2 << V4L2_FWHT_FL_PIXENC_OFFSET)
// #define V4L2_FWHT_FL_PIXENC_HSV   (3 << V4L2_FWHT_FL_PIXENC_OFFSET)
pub const V4L2_CID_STATELESS_FWHT_PARAMS = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_FWHT_PARAMS;
};
// #define V4L2_VP8_SEGMENT_FLAG_ENABLED              0x01
// #define V4L2_VP8_SEGMENT_FLAG_UPDATE_MAP           0x02
// #define V4L2_VP8_SEGMENT_FLAG_UPDATE_FEATURE_DATA  0x04
// #define V4L2_VP8_SEGMENT_FLAG_DELTA_VALUE_MODE     0x08
// #define V4L2_VP8_LF_ADJ_ENABLE 0x01
// #define V4L2_VP8_LF_DELTA_UPDATE 0x02
// #define V4L2_VP8_LF_FILTER_TYPE_SIMPLE 0x04
// #define V4L2_VP8_COEFF_PROB_CNT 11
// #define V4L2_VP8_MV_PROB_CNT 19
// #define V4L2_VP8_FRAME_FLAG_KEY_FRAME  0x01
// #define V4L2_VP8_FRAME_FLAG_EXPERIMENTAL  0x02
// #define V4L2_VP8_FRAME_FLAG_SHOW_FRAME  0x04
// #define V4L2_VP8_FRAME_FLAG_MB_NO_SKIP_COEFF 0x08
// #define V4L2_VP8_FRAME_FLAG_SIGN_BIAS_GOLDEN 0x10
// #define V4L2_VP8_FRAME_FLAG_SIGN_BIAS_ALT 0x20
// #define V4L2_VP8_FRAME_IS_KEY_FRAME(hdr) \
pub const V4L2_CID_STATELESS_VP8_FRAME = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_VP8_FRAME;
};
// #define V4L2_MPEG2_SEQ_FLAG_PROGRESSIVE 0x01
pub const V4L2_CID_STATELESS_MPEG2_SEQUENCE = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_MPEG2_SEQUENCE;
};
// #define V4L2_MPEG2_PIC_CODING_TYPE_I   1
// #define V4L2_MPEG2_PIC_CODING_TYPE_P   2
// #define V4L2_MPEG2_PIC_CODING_TYPE_B   3
// #define V4L2_MPEG2_PIC_CODING_TYPE_D   4
// #define V4L2_MPEG2_PIC_TOP_FIELD   0x1
// #define V4L2_MPEG2_PIC_BOTTOM_FIELD   0x2
// #define V4L2_MPEG2_PIC_FRAME    0x3
// #define V4L2_MPEG2_PIC_FLAG_TOP_FIELD_FIRST  0x0001
// #define V4L2_MPEG2_PIC_FLAG_FRAME_PRED_DCT  0x0002
// #define V4L2_MPEG2_PIC_FLAG_CONCEALMENT_MV  0x0004
// #define V4L2_MPEG2_PIC_FLAG_Q_SCALE_TYPE  0x0008
// #define V4L2_MPEG2_PIC_FLAG_INTRA_VLC   0x0010
// #define V4L2_MPEG2_PIC_FLAG_ALT_SCAN   0x0020
// #define V4L2_MPEG2_PIC_FLAG_REPEAT_FIRST  0x0040
// #define V4L2_MPEG2_PIC_FLAG_PROGRESSIVE   0x0080
pub const V4L2_CID_STATELESS_MPEG2_PICTURE = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_MPEG2_PICTURE;
};
pub const V4L2_CID_STATELESS_MPEG2_QUANTISATION = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_MPEG2_QUANTISATION;
};
pub const V4L2_CID_STATELESS_HEVC_SPS = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_SPS;
};
pub const V4L2_CID_STATELESS_HEVC_PPS = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_PPS;
};
pub const V4L2_CID_STATELESS_HEVC_SLICE_PARAMS = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_SLICE_PARAMS;
};
pub const V4L2_CID_STATELESS_HEVC_SCALING_MATRIX = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_SCALING_MATRIX;
};
pub const V4L2_CID_STATELESS_HEVC_DECODE_PARAMS = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_DECODE_PARAMS;
};
pub const V4L2_CID_STATELESS_HEVC_DECODE_MODE = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_DECODE_MODE;
};
pub const V4L2_CID_STATELESS_HEVC_START_CODE = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_START_CODE;
};
pub const V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS;
};
// #define V4L2_HEVC_SLICE_TYPE_B 0
// #define V4L2_HEVC_SLICE_TYPE_P 1
// #define V4L2_HEVC_SLICE_TYPE_I 2
// #define V4L2_HEVC_SPS_FLAG_SEPARATE_COLOUR_PLANE  (1ULL << 0)
// #define V4L2_HEVC_SPS_FLAG_SCALING_LIST_ENABLED   (1ULL << 1)
// #define V4L2_HEVC_SPS_FLAG_AMP_ENABLED    (1ULL << 2)
// #define V4L2_HEVC_SPS_FLAG_SAMPLE_ADAPTIVE_OFFSET  (1ULL << 3)
// #define V4L2_HEVC_SPS_FLAG_PCM_ENABLED    (1ULL << 4)
// #define V4L2_HEVC_SPS_FLAG_PCM_LOOP_FILTER_DISABLED  (1ULL << 5)
// #define V4L2_HEVC_SPS_FLAG_LONG_TERM_REF_PICS_PRESENT  (1ULL << 6)
// #define V4L2_HEVC_SPS_FLAG_SPS_TEMPORAL_MVP_ENABLED  (1ULL << 7)
// #define V4L2_HEVC_SPS_FLAG_STRONG_INTRA_SMOOTHING_ENABLED (1ULL << 8)
// #define V4L2_HEVC_PPS_FLAG_DEPENDENT_SLICE_SEGMENT_ENABLED (1ULL << 0)
// #define V4L2_HEVC_PPS_FLAG_OUTPUT_FLAG_PRESENT   (1ULL << 1)
// #define V4L2_HEVC_PPS_FLAG_SIGN_DATA_HIDING_ENABLED  (1ULL << 2)
// #define V4L2_HEVC_PPS_FLAG_CABAC_INIT_PRESENT   (1ULL << 3)
// #define V4L2_HEVC_PPS_FLAG_CONSTRAINED_INTRA_PRED  (1ULL << 4)
// #define V4L2_HEVC_PPS_FLAG_TRANSFORM_SKIP_ENABLED  (1ULL << 5)
// #define V4L2_HEVC_PPS_FLAG_CU_QP_DELTA_ENABLED   (1ULL << 6)
// #define V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT (1ULL << 7)
// #define V4L2_HEVC_PPS_FLAG_WEIGHTED_PRED   (1ULL << 8)
// #define V4L2_HEVC_PPS_FLAG_WEIGHTED_BIPRED   (1ULL << 9)
// #define V4L2_HEVC_PPS_FLAG_TRANSQUANT_BYPASS_ENABLED  (1ULL << 10)
// #define V4L2_HEVC_PPS_FLAG_TILES_ENABLED   (1ULL << 11)
// #define V4L2_HEVC_PPS_FLAG_ENTROPY_CODING_SYNC_ENABLED  (1ULL << 12)
// #define V4L2_HEVC_PPS_FLAG_LOOP_FILTER_ACROSS_TILES_ENABLED (1ULL << 13)
// #define V4L2_HEVC_PPS_FLAG_PPS_LOOP_FILTER_ACROSS_SLICES_ENABLED (1ULL << 14)
// #define V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_OVERRIDE_ENABLED (1ULL << 15)
// #define V4L2_HEVC_PPS_FLAG_PPS_DISABLE_DEBLOCKING_FILTER (1ULL << 16)
// #define V4L2_HEVC_PPS_FLAG_LISTS_MODIFICATION_PRESENT  (1ULL << 17)
// #define V4L2_HEVC_PPS_FLAG_SLICE_SEGMENT_HEADER_EXTENSION_PRESENT (1ULL << 18)
// #define V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT (1ULL << 19)
// #define V4L2_HEVC_PPS_FLAG_UNIFORM_SPACING   (1ULL << 20)
// #define V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE 0x01
// #define V4L2_HEVC_SEI_PIC_STRUCT_FRAME    0
// #define V4L2_HEVC_SEI_PIC_STRUCT_TOP_FIELD   1
// #define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_FIELD   2
// #define V4L2_HEVC_SEI_PIC_STRUCT_TOP_BOTTOM   3
// #define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_TOP   4
// #define V4L2_HEVC_SEI_PIC_STRUCT_TOP_BOTTOM_TOP   5
// #define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_TOP_BOTTOM  6
// #define V4L2_HEVC_SEI_PIC_STRUCT_FRAME_DOUBLING   7
// #define V4L2_HEVC_SEI_PIC_STRUCT_FRAME_TRIPLING   8
// #define V4L2_HEVC_SEI_PIC_STRUCT_TOP_PAIRED_PREVIOUS_BOTTOM 9
// #define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_PAIRED_PREVIOUS_TOP 10
// #define V4L2_HEVC_SEI_PIC_STRUCT_TOP_PAIRED_NEXT_BOTTOM  11
// #define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_PAIRED_NEXT_TOP  12
// #define V4L2_HEVC_DPB_ENTRIES_NUM_MAX  16
// #define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_SAO_LUMA  (1ULL << 0)
// #define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_SAO_CHROMA  (1ULL << 1)
// #define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_TEMPORAL_MVP_ENABLED (1ULL << 2)
// #define V4L2_HEVC_SLICE_PARAMS_FLAG_MVD_L1_ZERO   (1ULL << 3)
// #define V4L2_HEVC_SLICE_PARAMS_FLAG_CABAC_INIT   (1ULL << 4)
// #define V4L2_HEVC_SLICE_PARAMS_FLAG_COLLOCATED_FROM_L0  (1ULL << 5)
// #define V4L2_HEVC_SLICE_PARAMS_FLAG_USE_INTEGER_MV  (1ULL << 6)
// #define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_DEBLOCKING_FILTER_DISABLED (1ULL << 7)
// #define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_LOOP_FILTER_ACROSS_SLICES_ENABLED (1ULL << 8)
// #define V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT (1ULL << 9)
// #define V4L2_HEVC_DECODE_PARAM_FLAG_IRAP_PIC  0x1
// #define V4L2_HEVC_DECODE_PARAM_FLAG_IDR_PIC  0x2
// #define V4L2_HEVC_DECODE_PARAM_FLAG_NO_OUTPUT_OF_PRIOR  0x4
pub const V4L2_CID_COLORIMETRY_CLASS_BASE = struct {
    pub const id: u32 = c.V4L2_CID_COLORIMETRY_CLASS_BASE;
};
pub const V4L2_CID_COLORIMETRY_CLASS = struct {
    pub const id: u32 = c.V4L2_CID_COLORIMETRY_CLASS;
};
pub const V4L2_CID_COLORIMETRY_HDR10_CLL_INFO = struct {
    pub const id: u32 = c.V4L2_CID_COLORIMETRY_HDR10_CLL_INFO;
};
pub const V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY = struct {
    pub const id: u32 = c.V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY;
};
// #define V4L2_HDR10_MASTERING_PRIMARIES_X_LOW 5
// #define V4L2_HDR10_MASTERING_PRIMARIES_X_HIGH 37000
// #define V4L2_HDR10_MASTERING_PRIMARIES_Y_LOW 5
// #define V4L2_HDR10_MASTERING_PRIMARIES_Y_HIGH 42000
// #define V4L2_HDR10_MASTERING_WHITE_POINT_X_LOW 5
// #define V4L2_HDR10_MASTERING_WHITE_POINT_X_HIGH 37000
// #define V4L2_HDR10_MASTERING_WHITE_POINT_Y_LOW 5
// #define V4L2_HDR10_MASTERING_WHITE_POINT_Y_HIGH 42000
// #define V4L2_HDR10_MASTERING_MAX_LUMA_LOW 50000
// #define V4L2_HDR10_MASTERING_MAX_LUMA_HIGH 100000000
// #define V4L2_HDR10_MASTERING_MIN_LUMA_LOW 1
// #define V4L2_HDR10_MASTERING_MIN_LUMA_HIGH 50000
// #define V4L2_VP9_LOOP_FILTER_FLAG_DELTA_ENABLED 0x1
// #define V4L2_VP9_LOOP_FILTER_FLAG_DELTA_UPDATE 0x2
// #define V4L2_VP9_SEGMENTATION_FLAG_ENABLED  0x01
// #define V4L2_VP9_SEGMENTATION_FLAG_UPDATE_MAP  0x02
// #define V4L2_VP9_SEGMENTATION_FLAG_TEMPORAL_UPDATE 0x04
// #define V4L2_VP9_SEGMENTATION_FLAG_UPDATE_DATA  0x08
// #define V4L2_VP9_SEGMENTATION_FLAG_ABS_OR_DELTA_UPDATE 0x10
// #define V4L2_VP9_SEG_LVL_ALT_Q    0
// #define V4L2_VP9_SEG_LVL_ALT_L    1
// #define V4L2_VP9_SEG_LVL_REF_FRAME   2
// #define V4L2_VP9_SEG_LVL_SKIP    3
// #define V4L2_VP9_SEG_LVL_MAX    4
// #define V4L2_VP9_SEGMENT_FEATURE_ENABLED(id) (1 << (id))
// #define V4L2_VP9_SEGMENT_FEATURE_ENABLED_MASK 0xf
// #define V4L2_VP9_FRAME_FLAG_KEY_FRAME   0x001
// #define V4L2_VP9_FRAME_FLAG_SHOW_FRAME   0x002
// #define V4L2_VP9_FRAME_FLAG_ERROR_RESILIENT  0x004
// #define V4L2_VP9_FRAME_FLAG_INTRA_ONLY   0x008
// #define V4L2_VP9_FRAME_FLAG_ALLOW_HIGH_PREC_MV  0x010
// #define V4L2_VP9_FRAME_FLAG_REFRESH_FRAME_CTX  0x020
// #define V4L2_VP9_FRAME_FLAG_PARALLEL_DEC_MODE  0x040
// #define V4L2_VP9_FRAME_FLAG_X_SUBSAMPLING  0x080
// #define V4L2_VP9_FRAME_FLAG_Y_SUBSAMPLING  0x100
// #define V4L2_VP9_FRAME_FLAG_COLOR_RANGE_FULL_SWING 0x200
// #define V4L2_VP9_SIGN_BIAS_LAST    0x1
// #define V4L2_VP9_SIGN_BIAS_GOLDEN   0x2
// #define V4L2_VP9_SIGN_BIAS_ALT    0x4
// #define V4L2_VP9_RESET_FRAME_CTX_NONE   0
// #define V4L2_VP9_RESET_FRAME_CTX_SPEC   1
// #define V4L2_VP9_RESET_FRAME_CTX_ALL   2
// #define V4L2_VP9_INTERP_FILTER_EIGHTTAP   0
// #define V4L2_VP9_INTERP_FILTER_EIGHTTAP_SMOOTH  1
// #define V4L2_VP9_INTERP_FILTER_EIGHTTAP_SHARP  2
// #define V4L2_VP9_INTERP_FILTER_BILINEAR   3
// #define V4L2_VP9_INTERP_FILTER_SWITCHABLE  4
// #define V4L2_VP9_REFERENCE_MODE_SINGLE_REFERENCE 0
// #define V4L2_VP9_REFERENCE_MODE_COMPOUND_REFERENCE 1
// #define V4L2_VP9_REFERENCE_MODE_SELECT   2
// #define V4L2_VP9_PROFILE_MAX    3
pub const V4L2_CID_STATELESS_VP9_FRAME = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_VP9_FRAME;
};
// #define V4L2_VP9_NUM_FRAME_CTX 4
pub const V4L2_CID_STATELESS_VP9_COMPRESSED_HDR = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_VP9_COMPRESSED_HDR;
};
// #define V4L2_VP9_TX_MODE_ONLY_4X4   0
// #define V4L2_VP9_TX_MODE_ALLOW_8X8   1
// #define V4L2_VP9_TX_MODE_ALLOW_16X16   2
// #define V4L2_VP9_TX_MODE_ALLOW_32X32   3
// #define V4L2_VP9_TX_MODE_SELECT    4
// #define V4L2_AV1_TOTAL_REFS_PER_FRAME 8
// #define V4L2_AV1_CDEF_MAX  8
// #define V4L2_AV1_NUM_PLANES_MAX  3 /* 1 if monochrome, 3 otherwise */
// #define V4L2_AV1_MAX_SEGMENTS  8
// #define V4L2_AV1_MAX_OPERATING_POINTS (1 << 5) /* 5 bits to encode */
// #define V4L2_AV1_REFS_PER_FRAME  7
// #define V4L2_AV1_MAX_NUM_Y_POINTS (1 << 4) /* 4 bits to encode */
// #define V4L2_AV1_MAX_NUM_CB_POINTS (1 << 4) /* 4 bits to encode */
// #define V4L2_AV1_MAX_NUM_CR_POINTS (1 << 4) /* 4 bits to encode */
// #define V4L2_AV1_AR_COEFFS_SIZE  25 /* (2 * 3 * (3 + 1)) + 1 */
// #define V4L2_AV1_MAX_NUM_PLANES  3
// #define V4L2_AV1_MAX_TILE_COLS  64
// #define V4L2_AV1_MAX_TILE_ROWS  64
// #define V4L2_AV1_MAX_TILE_COUNT  512
// #define V4L2_AV1_SEQUENCE_FLAG_STILL_PICTURE    0x00000001
// #define V4L2_AV1_SEQUENCE_FLAG_USE_128X128_SUPERBLOCK   0x00000002
// #define V4L2_AV1_SEQUENCE_FLAG_ENABLE_FILTER_INTRA   0x00000004
// #define V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTRA_EDGE_FILTER   0x00000008
// #define V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTERINTRA_COMPOUND 0x00000010
// #define V4L2_AV1_SEQUENCE_FLAG_ENABLE_MASKED_COMPOUND   0x00000020
// #define V4L2_AV1_SEQUENCE_FLAG_ENABLE_WARPED_MOTION   0x00000040
// #define V4L2_AV1_SEQUENCE_FLAG_ENABLE_DUAL_FILTER   0x00000080
// #define V4L2_AV1_SEQUENCE_FLAG_ENABLE_ORDER_HINT   0x00000100
// #define V4L2_AV1_SEQUENCE_FLAG_ENABLE_JNT_COMP    0x00000200
// #define V4L2_AV1_SEQUENCE_FLAG_ENABLE_REF_FRAME_MVS   0x00000400
// #define V4L2_AV1_SEQUENCE_FLAG_ENABLE_SUPERRES    0x00000800
// #define V4L2_AV1_SEQUENCE_FLAG_ENABLE_CDEF    0x00001000
// #define V4L2_AV1_SEQUENCE_FLAG_ENABLE_RESTORATION   0x00002000
// #define V4L2_AV1_SEQUENCE_FLAG_MONO_CHROME    0x00004000
// #define V4L2_AV1_SEQUENCE_FLAG_COLOR_RANGE    0x00008000
// #define V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_X    0x00010000
// #define V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_Y    0x00020000
// #define V4L2_AV1_SEQUENCE_FLAG_FILM_GRAIN_PARAMS_PRESENT  0x00040000
// #define V4L2_AV1_SEQUENCE_FLAG_SEPARATE_UV_DELTA_Q   0x00080000
pub const V4L2_CID_STATELESS_AV1_SEQUENCE = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_AV1_SEQUENCE;
};
pub const V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY;
};
// #define V4L2_AV1_GLOBAL_MOTION_IS_INVALID(ref) (1 << (ref))
// #define V4L2_AV1_GLOBAL_MOTION_FLAG_IS_GLOBAL    0x1
// #define V4L2_AV1_GLOBAL_MOTION_FLAG_IS_ROT_ZOOM    0x2
// #define V4L2_AV1_GLOBAL_MOTION_FLAG_IS_TRANSLATION 0x4
// #define V4L2_AV1_LOOP_RESTORATION_FLAG_USES_LR  0x1
// #define V4L2_AV1_LOOP_RESTORATION_FLAG_USES_CHROMA_LR 0x2
// #define V4L2_AV1_SEGMENTATION_FLAG_ENABLED    0x1
// #define V4L2_AV1_SEGMENTATION_FLAG_UPDATE_MAP    0x2
// #define V4L2_AV1_SEGMENTATION_FLAG_TEMPORAL_UPDATE 0x4
// #define V4L2_AV1_SEGMENTATION_FLAG_UPDATE_DATA    0x8
// #define V4L2_AV1_SEGMENTATION_FLAG_SEG_ID_PRE_SKIP 0x10
// #define V4L2_AV1_SEGMENT_FEATURE_ENABLED(id) (1 << (id))
// #define V4L2_AV1_LOOP_FILTER_FLAG_DELTA_ENABLED    0x1
// #define V4L2_AV1_LOOP_FILTER_FLAG_DELTA_UPDATE     0x2
// #define V4L2_AV1_LOOP_FILTER_FLAG_DELTA_LF_PRESENT 0x4
// #define V4L2_AV1_LOOP_FILTER_FLAG_DELTA_LF_MULTI   0x8
// #define V4L2_AV1_QUANTIZATION_FLAG_DIFF_UV_DELTA   0x1
// #define V4L2_AV1_QUANTIZATION_FLAG_USING_QMATRIX   0x2
// #define V4L2_AV1_QUANTIZATION_FLAG_DELTA_Q_PRESENT 0x4
// #define V4L2_AV1_TILE_INFO_FLAG_UNIFORM_TILE_SPACING 0x1
// #define V4L2_AV1_FRAME_FLAG_SHOW_FRAME    0x00000001
// #define V4L2_AV1_FRAME_FLAG_SHOWABLE_FRAME   0x00000002
// #define V4L2_AV1_FRAME_FLAG_ERROR_RESILIENT_MODE  0x00000004
// #define V4L2_AV1_FRAME_FLAG_DISABLE_CDF_UPDATE   0x00000008
// #define V4L2_AV1_FRAME_FLAG_ALLOW_SCREEN_CONTENT_TOOLS  0x00000010
// #define V4L2_AV1_FRAME_FLAG_FORCE_INTEGER_MV   0x00000020
// #define V4L2_AV1_FRAME_FLAG_ALLOW_INTRABC   0x00000040
// #define V4L2_AV1_FRAME_FLAG_USE_SUPERRES   0x00000080
// #define V4L2_AV1_FRAME_FLAG_ALLOW_HIGH_PRECISION_MV  0x00000100
// #define V4L2_AV1_FRAME_FLAG_IS_MOTION_MODE_SWITCHABLE  0x00000200
// #define V4L2_AV1_FRAME_FLAG_USE_REF_FRAME_MVS   0x00000400
// #define V4L2_AV1_FRAME_FLAG_DISABLE_FRAME_END_UPDATE_CDF 0x00000800
// #define V4L2_AV1_FRAME_FLAG_ALLOW_WARPED_MOTION   0x00001000
// #define V4L2_AV1_FRAME_FLAG_REFERENCE_SELECT   0x00002000
// #define V4L2_AV1_FRAME_FLAG_REDUCED_TX_SET   0x00004000
// #define V4L2_AV1_FRAME_FLAG_SKIP_MODE_ALLOWED   0x00008000
// #define V4L2_AV1_FRAME_FLAG_SKIP_MODE_PRESENT   0x00010000
// #define V4L2_AV1_FRAME_FLAG_FRAME_SIZE_OVERRIDE   0x00020000
// #define V4L2_AV1_FRAME_FLAG_BUFFER_REMOVAL_TIME_PRESENT  0x00040000
// #define V4L2_AV1_FRAME_FLAG_FRAME_REFS_SHORT_SIGNALING  0x00080000
pub const V4L2_CID_STATELESS_AV1_FRAME = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_AV1_FRAME;
};
// #define V4L2_AV1_FILM_GRAIN_FLAG_APPLY_GRAIN 0x1
// #define V4L2_AV1_FILM_GRAIN_FLAG_UPDATE_GRAIN 0x2
// #define V4L2_AV1_FILM_GRAIN_FLAG_CHROMA_SCALING_FROM_LUMA 0x4
// #define V4L2_AV1_FILM_GRAIN_FLAG_OVERLAP 0x8
// #define V4L2_AV1_FILM_GRAIN_FLAG_CLIP_TO_RESTRICTED_RANGE 0x10
pub const V4L2_CID_STATELESS_AV1_FILM_GRAIN = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_AV1_FILM_GRAIN;
};
// #define V4L2_CTRL_CLASS_MPEG            (V4L2_CTRL_CLASS_CODEC)
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
