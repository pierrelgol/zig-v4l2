const bindings = @import("bindings");
const std = @import("std");
const geometry = @import("geometry.zig");
const Area = geometry.Area;
const Rectangle = geometry.Rectangle;

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
        integer = @intCast(bindings.V4L2_CTRL_TYPE_INTEGER),
        boolean = @intCast(bindings.V4L2_CTRL_TYPE_BOOLEAN),
        menu = @intCast(bindings.V4L2_CTRL_TYPE_MENU),
        button = @intCast(bindings.V4L2_CTRL_TYPE_BUTTON),
        integer64 = @intCast(bindings.V4L2_CTRL_TYPE_INTEGER64),
        class = @intCast(bindings.V4L2_CTRL_TYPE_CTRL_CLASS),
        string = @intCast(bindings.V4L2_CTRL_TYPE_STRING),
        bitmask = @intCast(bindings.V4L2_CTRL_TYPE_BITMASK),
        integer_menu = @intCast(bindings.V4L2_CTRL_TYPE_INTEGER_MENU),
        u8 = @intCast(bindings.V4L2_CTRL_TYPE_U8),
        u16 = @intCast(bindings.V4L2_CTRL_TYPE_U16),
        u32 = @intCast(bindings.V4L2_CTRL_TYPE_U32),
        area = @intCast(bindings.V4L2_CTRL_TYPE_AREA),
        rect = @intCast(bindings.V4L2_CTRL_TYPE_RECT),
        hdr10_cll_info = @intCast(bindings.V4L2_CTRL_TYPE_HDR10_CLL_INFO),
        hdr10_mastering_display = @intCast(bindings.V4L2_CTRL_TYPE_HDR10_MASTERING_DISPLAY),
        h264_sps = @intCast(bindings.V4L2_CTRL_TYPE_H264_SPS),
        h264_pps = @intCast(bindings.V4L2_CTRL_TYPE_H264_PPS),
        h264_scaling_matrix = @intCast(bindings.V4L2_CTRL_TYPE_H264_SCALING_MATRIX),
        h264_slice_params = @intCast(bindings.V4L2_CTRL_TYPE_H264_SLICE_PARAMS),
        h264_decode_params = @intCast(bindings.V4L2_CTRL_TYPE_H264_DECODE_PARAMS),
        h264_pred_weights = @intCast(bindings.V4L2_CTRL_TYPE_H264_PRED_WEIGHTS),
        fwht_params = @intCast(bindings.V4L2_CTRL_TYPE_FWHT_PARAMS),
        vp8_frame = @intCast(bindings.V4L2_CTRL_TYPE_VP8_FRAME),
        mpeg2_quantisation = @intCast(bindings.V4L2_CTRL_TYPE_MPEG2_QUANTISATION),
        mpeg2_sequence = @intCast(bindings.V4L2_CTRL_TYPE_MPEG2_SEQUENCE),
        mpeg2_picture = @intCast(bindings.V4L2_CTRL_TYPE_MPEG2_PICTURE),
        vp9_compressed_hdr = @intCast(bindings.V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR),
        vp9_frame = @intCast(bindings.V4L2_CTRL_TYPE_VP9_FRAME),
        hevc_sps = @intCast(bindings.V4L2_CTRL_TYPE_HEVC_SPS),
        hevc_pps = @intCast(bindings.V4L2_CTRL_TYPE_HEVC_PPS),
        hevc_slice_params = @intCast(bindings.V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS),
        hevc_scaling_matrix = @intCast(bindings.V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX),
        hevc_decode_params = @intCast(bindings.V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS),
        av1_sequence = @intCast(bindings.V4L2_CTRL_TYPE_AV1_SEQUENCE),
        av1_tile_group_entry = @intCast(bindings.V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY),
        av1_frame = @intCast(bindings.V4L2_CTRL_TYPE_AV1_FRAME),
        av1_film_grain = @intCast(bindings.V4L2_CTRL_TYPE_AV1_FILM_GRAIN),

        pub const compound_types: u32 = 0x0100;
    };

    pub const Flag = enum(u32) {
        disabled = @intCast(bindings.V4L2_CTRL_FLAG_DISABLED),
        grabbed = @intCast(bindings.V4L2_CTRL_FLAG_GRABBED),
        read_only = @intCast(bindings.V4L2_CTRL_FLAG_READ_ONLY),
        update = @intCast(bindings.V4L2_CTRL_FLAG_UPDATE),
        inactive = @intCast(bindings.V4L2_CTRL_FLAG_INACTIVE),
        slider = @intCast(bindings.V4L2_CTRL_FLAG_SLIDER),
        write_only = @intCast(bindings.V4L2_CTRL_FLAG_WRITE_ONLY),
        @"volatile" = @intCast(bindings.V4L2_CTRL_FLAG_VOLATILE),
        has_payload = @intCast(bindings.V4L2_CTRL_FLAG_HAS_PAYLOAD),
        execute_on_write = @intCast(bindings.V4L2_CTRL_FLAG_EXECUTE_ON_WRITE),
        modify_layout = @intCast(bindings.V4L2_CTRL_FLAG_MODIFY_LAYOUT),
        dynamic_array = @intCast(bindings.V4L2_CTRL_FLAG_DYNAMIC_ARRAY),
        has_which_min_max = @intCast(bindings.V4L2_CTRL_FLAG_HAS_WHICH_MIN_MAX),
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
    user = bindings.V4L2_CTRL_CLASS_USER,
    codec = bindings.V4L2_CTRL_CLASS_CODEC,
    camera = bindings.V4L2_CTRL_CLASS_CAMERA,
    fm_tx = bindings.V4L2_CTRL_CLASS_FM_TX,
    flash = bindings.V4L2_CTRL_CLASS_FLASH,
    jpeg = bindings.V4L2_CTRL_CLASS_JPEG,
    image_source = bindings.V4L2_CTRL_CLASS_IMAGE_SOURCE,
    image_proc = bindings.V4L2_CTRL_CLASS_IMAGE_PROC,
    dv = bindings.V4L2_CTRL_CLASS_DV,
    fm_rx = bindings.V4L2_CTRL_CLASS_FM_RX,
    rf_tuner = bindings.V4L2_CTRL_CLASS_RF_TUNER,
    detect = bindings.V4L2_CTRL_CLASS_DETECT,
    codec_stateless = bindings.V4L2_CTRL_CLASS_CODEC_STATELESS,
    colorimetry = bindings.V4L2_CTRL_CLASS_COLORIMETRY,
};

pub const base: u32 = bindings.V4L2_CID_BASE;
pub const user_base: u32 = bindings.V4L2_CID_USER_BASE;
pub const user_class: u32 = bindings.V4L2_CID_USER_CLASS;
pub const lastp1: u32 = bindings.V4L2_CID_LASTP1;

pub const brightness = struct {
    pub const id: u32 = bindings.V4L2_CID_BRIGHTNESS;
};

pub const contrast = struct {
    pub const id: u32 = bindings.V4L2_CID_CONTRAST;
};

pub const saturation = struct {
    pub const id: u32 = bindings.V4L2_CID_SATURATION;
};

pub const hue = struct {
    pub const id: u32 = bindings.V4L2_CID_HUE;
};

pub const audio_volume = struct {
    pub const id: u32 = bindings.V4L2_CID_AUDIO_VOLUME;
};

pub const audio_balance = struct {
    pub const id: u32 = bindings.V4L2_CID_AUDIO_BALANCE;
};

pub const audio_bass = struct {
    pub const id: u32 = bindings.V4L2_CID_AUDIO_BASS;
};

pub const audio_treble = struct {
    pub const id: u32 = bindings.V4L2_CID_AUDIO_TREBLE;
};

pub const audio_mute = struct {
    pub const id: u32 = bindings.V4L2_CID_AUDIO_MUTE;
};

pub const audio_loudness = struct {
    pub const id: u32 = bindings.V4L2_CID_AUDIO_LOUDNESS;
};

pub const black_level = struct {
    pub const id: u32 = bindings.V4L2_CID_BLACK_LEVEL;
};

pub const auto_white_balance = struct {
    pub const id: u32 = bindings.V4L2_CID_AUTO_WHITE_BALANCE;
};

pub const do_white_balance = struct {
    pub const id: u32 = bindings.V4L2_CID_DO_WHITE_BALANCE;
};

pub const red_balance = struct {
    pub const id: u32 = bindings.V4L2_CID_RED_BALANCE;
};

pub const blue_balance = struct {
    pub const id: u32 = bindings.V4L2_CID_BLUE_BALANCE;
};

pub const gamma = struct {
    pub const id: u32 = bindings.V4L2_CID_GAMMA;
};

pub const whiteness = struct {
    pub const id: u32 = bindings.V4L2_CID_WHITENESS;
};

pub const exposure = struct {
    pub const id: u32 = bindings.V4L2_CID_EXPOSURE;
};

pub const autogain = struct {
    pub const id: u32 = bindings.V4L2_CID_AUTOGAIN;
};

pub const gain = struct {
    pub const id: u32 = bindings.V4L2_CID_GAIN;
};

pub const h_flip = struct {
    pub const id: u32 = bindings.V4L2_CID_HFLIP;
};

pub const v_flip = struct {
    pub const id: u32 = bindings.V4L2_CID_VFLIP;
};

pub const power_line_frequency = enum(i32) {
    pub const id: u32 = bindings.V4L2_CID_POWER_LINE_FREQUENCY;

    disabled = bindings.V4L2_CID_POWER_LINE_FREQUENCY_DISABLED,
    hz_50 = bindings.V4L2_CID_POWER_LINE_FREQUENCY_50HZ,
    hz_60 = bindings.V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
    auto = bindings.V4L2_CID_POWER_LINE_FREQUENCY_AUTO,
};

pub const auto_brightness = struct {
    pub const id: u32 = bindings.V4L2_CID_AUTOBRIGHTNESS;
};

pub const band_stop_filter = struct {
    pub const id: u32 = bindings.V4L2_CID_BAND_STOP_FILTER;
};

pub const rotate = struct {
    pub const id: u32 = bindings.V4L2_CID_ROTATE;
};

pub const bg_color = struct {
    pub const id: u32 = bindings.V4L2_CID_BG_COLOR;
};

pub const chroma_gain = struct {
    pub const id: u32 = bindings.V4L2_CID_CHROMA_GAIN;
};

pub const illuminators1 = struct {
    pub const id: u32 = bindings.V4L2_CID_ILLUMINATORS_1;
};

pub const illuminators2 = struct {
    pub const id: u32 = bindings.V4L2_CID_ILLUMINATORS_2;
};

pub const min_buffers_for_capture = struct {
    pub const id: u32 = bindings.V4L2_CID_MIN_BUFFERS_FOR_CAPTURE;
};

pub const min_buffers_for_output = struct {
    pub const id: u32 = bindings.V4L2_CID_MIN_BUFFERS_FOR_OUTPUT;
};

pub const alpha_component = struct {
    pub const id: u32 = bindings.V4L2_CID_ALPHA_COMPONENT;
};

pub const color_fx = enum(i32) {
    pub const id: u32 = bindings.V4L2_CID_COLORFX;
    pub const cbcr_id: u32 = bindings.V4L2_CID_COLORFX_CBCR;
    pub const rgb_id: u32 = bindings.V4L2_CID_COLORFX_RGB;

    none = bindings.V4L2_COLORFX_NONE,
    bw = bindings.V4L2_COLORFX_BW,
    sepia = bindings.V4L2_COLORFX_SEPIA,
    negative = bindings.V4L2_COLORFX_NEGATIVE,
    emboss = bindings.V4L2_COLORFX_EMBOSS,
    sketch = bindings.V4L2_COLORFX_SKETCH,
    sky_blue = bindings.V4L2_COLORFX_SKY_BLUE,
    grass_green = bindings.V4L2_COLORFX_GRASS_GREEN,
    skin_whiten = bindings.V4L2_COLORFX_SKIN_WHITEN,
    vivid = bindings.V4L2_COLORFX_VIVID,
    aqua = bindings.V4L2_COLORFX_AQUA,
    art_freeze = bindings.V4L2_COLORFX_ART_FREEZE,
    silhouette = bindings.V4L2_COLORFX_SILHOUETTE,
    solarization = bindings.V4L2_COLORFX_SOLARIZATION,
    antique = bindings.V4L2_COLORFX_ANTIQUE,
    set_cbcr = bindings.V4L2_COLORFX_SET_CBCR,
    set_rgb = bindings.V4L2_COLORFX_SET_RGB,
};

pub const user = struct {
    pub const meye_base: u32 = bindings.V4L2_CID_USER_MEYE_BASE;
    pub const bttv_base: u32 = bindings.V4L2_CID_USER_BTTV_BASE;
    pub const s2255_base: u32 = bindings.V4L2_CID_USER_S2255_BASE;
    pub const si476x_base: u32 = bindings.V4L2_CID_USER_SI476X_BASE;
    pub const ti_vpe_base: u32 = bindings.V4L2_CID_USER_TI_VPE_BASE;
    pub const saa7134_base: u32 = bindings.V4L2_CID_USER_SAA7134_BASE;
    pub const adv7180_base: u32 = bindings.V4L2_CID_USER_ADV7180_BASE;
    pub const tc358743_base: u32 = bindings.V4L2_CID_USER_TC358743_BASE;
    pub const max217x_base: u32 = bindings.V4L2_CID_USER_MAX217X_BASE;
    pub const imx_base: u32 = bindings.V4L2_CID_USER_IMX_BASE;
    pub const atmel_isc_base: u32 = bindings.V4L2_CID_USER_ATMEL_ISC_BASE;
    pub const coda_base: u32 = bindings.V4L2_CID_USER_CODA_BASE;
    pub const ccs_base: u32 = bindings.V4L2_CID_USER_CCS_BASE;
    pub const allegro_base: u32 = bindings.V4L2_CID_USER_ALLEGRO_BASE;
    pub const isl7998x_base: u32 = bindings.V4L2_CID_USER_ISL7998X_BASE;
    pub const dw100_base: u32 = bindings.V4L2_CID_USER_DW100_BASE;
    pub const aspeed_base: u32 = bindings.V4L2_CID_USER_ASPEED_BASE;
    pub const npcm_base: u32 = bindings.V4L2_CID_USER_NPCM_BASE;
    pub const thp7312_base: u32 = bindings.V4L2_CID_USER_THP7312_BASE;
    pub const uvc_base: u32 = bindings.V4L2_CID_USER_UVC_BASE;
    pub const rkisp1_base: u32 = bindings.V4L2_CID_USER_RKISP1_BASE;
};

pub const codec = struct {
    pub const base: u32 = bindings.V4L2_CID_CODEC_BASE;
    pub const class: u32 = bindings.V4L2_CID_CODEC_CLASS;
};

pub const mpeg = struct {
    pub const stream = struct {
        pub const Type = enum(i32) {
            pub const id: u32 = bindings.V4L2_CID_MPEG_STREAM_TYPE;

            mpeg2_ps = bindings.V4L2_MPEG_STREAM_TYPE_MPEG2_PS,
            mpeg2_ts = bindings.V4L2_MPEG_STREAM_TYPE_MPEG2_TS,
            mpeg1_ss = bindings.V4L2_MPEG_STREAM_TYPE_MPEG1_SS,
            mpeg2_dvd = bindings.V4L2_MPEG_STREAM_TYPE_MPEG2_DVD,
            mpeg1_vcd = bindings.V4L2_MPEG_STREAM_TYPE_MPEG1_VCD,
            mpeg2_svcd = bindings.V4L2_MPEG_STREAM_TYPE_MPEG2_SVCD,
        };

        pub const pid_pmt = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_STREAM_PID_PMT;
        };
        pub const pid_audio = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_STREAM_PID_AUDIO;
        };
        pub const pid_video = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_STREAM_PID_VIDEO;
        };
        pub const pid_pcr = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_STREAM_PID_PCR;
        };
        pub const pes_id_audio = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_STREAM_PES_ID_AUDIO;
        };
        pub const pes_id_video = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_STREAM_PES_ID_VIDEO;
        };

        pub const vbi_fmt = enum(i32) {
            pub const id: u32 = bindings.V4L2_CID_MPEG_STREAM_VBI_FMT;

            none = bindings.V4L2_MPEG_STREAM_VBI_FMT_NONE,
            ivtv = bindings.V4L2_MPEG_STREAM_VBI_FMT_IVTV,
        };
    };

    pub const audio = struct {
        pub const sampling = enum(i32) {
            pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_SAMPLING_FREQ;

            freq_44100 = bindings.V4L2_MPEG_AUDIO_SAMPLING_FREQ_44100,
            freq_48000 = bindings.V4L2_MPEG_AUDIO_SAMPLING_FREQ_48000,
            freq_32000 = bindings.V4L2_MPEG_AUDIO_SAMPLING_FREQ_32000,
        };

        pub const encoding = enum(i32) {
            pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_ENCODING;

            layer_1 = bindings.V4L2_MPEG_AUDIO_ENCODING_LAYER_1,
            layer_2 = bindings.V4L2_MPEG_AUDIO_ENCODING_LAYER_2,
            layer_3 = bindings.V4L2_MPEG_AUDIO_ENCODING_LAYER_3,
            aac = bindings.V4L2_MPEG_AUDIO_ENCODING_AAC,
            ac3 = bindings.V4L2_MPEG_AUDIO_ENCODING_AC3,
        };

        pub const l1 = enum(i32) {
            pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_L1_BITRATE;

            bitrate_32k = bindings.V4L2_MPEG_AUDIO_L1_BITRATE_32K,
            bitrate_64k = bindings.V4L2_MPEG_AUDIO_L1_BITRATE_64K,
            bitrate_96k = bindings.V4L2_MPEG_AUDIO_L1_BITRATE_96K,
            bitrate_128k = bindings.V4L2_MPEG_AUDIO_L1_BITRATE_128K,
            bitrate_160k = bindings.V4L2_MPEG_AUDIO_L1_BITRATE_160K,
            bitrate_192k = bindings.V4L2_MPEG_AUDIO_L1_BITRATE_192K,
            bitrate_224k = bindings.V4L2_MPEG_AUDIO_L1_BITRATE_224K,
            bitrate_256k = bindings.V4L2_MPEG_AUDIO_L1_BITRATE_256K,
            bitrate_288k = bindings.V4L2_MPEG_AUDIO_L1_BITRATE_288K,
            bitrate_320k = bindings.V4L2_MPEG_AUDIO_L1_BITRATE_320K,
            bitrate_352k = bindings.V4L2_MPEG_AUDIO_L1_BITRATE_352K,
            bitrate_384k = bindings.V4L2_MPEG_AUDIO_L1_BITRATE_384K,
            bitrate_416k = bindings.V4L2_MPEG_AUDIO_L1_BITRATE_416K,
            bitrate_448k = bindings.V4L2_MPEG_AUDIO_L1_BITRATE_448K,
        };

        pub const l2 = enum(i32) {
            pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_L2_BITRATE;

            bitrate_32k = bindings.V4L2_MPEG_AUDIO_L2_BITRATE_32K,
            bitrate_48k = bindings.V4L2_MPEG_AUDIO_L2_BITRATE_48K,
            bitrate_56k = bindings.V4L2_MPEG_AUDIO_L2_BITRATE_56K,
            bitrate_64k = bindings.V4L2_MPEG_AUDIO_L2_BITRATE_64K,
            bitrate_80k = bindings.V4L2_MPEG_AUDIO_L2_BITRATE_80K,
            bitrate_96k = bindings.V4L2_MPEG_AUDIO_L2_BITRATE_96K,
            bitrate_112k = bindings.V4L2_MPEG_AUDIO_L2_BITRATE_112K,
            bitrate_128k = bindings.V4L2_MPEG_AUDIO_L2_BITRATE_128K,
            bitrate_160k = bindings.V4L2_MPEG_AUDIO_L2_BITRATE_160K,
            bitrate_192k = bindings.V4L2_MPEG_AUDIO_L2_BITRATE_192K,
            bitrate_224k = bindings.V4L2_MPEG_AUDIO_L2_BITRATE_224K,
            bitrate_256k = bindings.V4L2_MPEG_AUDIO_L2_BITRATE_256K,
            bitrate_320k = bindings.V4L2_MPEG_AUDIO_L2_BITRATE_320K,
            bitrate_384k = bindings.V4L2_MPEG_AUDIO_L2_BITRATE_384K,
        };

        pub const l3 = enum(i32) {
            pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_L3_BITRATE;

            bitrate_32k = bindings.V4L2_MPEG_AUDIO_L3_BITRATE_32K,
            bitrate_40k = bindings.V4L2_MPEG_AUDIO_L3_BITRATE_40K,
            bitrate_48k = bindings.V4L2_MPEG_AUDIO_L3_BITRATE_48K,
            bitrate_56k = bindings.V4L2_MPEG_AUDIO_L3_BITRATE_56K,
            bitrate_64k = bindings.V4L2_MPEG_AUDIO_L3_BITRATE_64K,
            bitrate_80k = bindings.V4L2_MPEG_AUDIO_L3_BITRATE_80K,
            bitrate_96k = bindings.V4L2_MPEG_AUDIO_L3_BITRATE_96K,
            bitrate_112k = bindings.V4L2_MPEG_AUDIO_L3_BITRATE_112K,
            bitrate_128k = bindings.V4L2_MPEG_AUDIO_L3_BITRATE_128K,
            bitrate_160k = bindings.V4L2_MPEG_AUDIO_L3_BITRATE_160K,
            bitrate_192k = bindings.V4L2_MPEG_AUDIO_L3_BITRATE_192K,
            bitrate_224k = bindings.V4L2_MPEG_AUDIO_L3_BITRATE_224K,
            bitrate_256k = bindings.V4L2_MPEG_AUDIO_L3_BITRATE_256K,
            bitrate_320k = bindings.V4L2_MPEG_AUDIO_L3_BITRATE_320K,
        };

        pub const Mode = enum(i32) {
            pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_MODE;

            stereo = bindings.V4L2_MPEG_AUDIO_MODE_STEREO,
            joint_stereo = bindings.V4L2_MPEG_AUDIO_MODE_JOINT_STEREO,
            dual = bindings.V4L2_MPEG_AUDIO_MODE_DUAL,
            mono = bindings.V4L2_MPEG_AUDIO_MODE_MONO,

            pub const Extension = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_MODE_EXTENSION;

                bound_4 = bindings.V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_4,
                bound_8 = bindings.V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_8,
                bound_12 = bindings.V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_12,
                bound_16 = bindings.V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_16,
            };
        };

        pub const emphasis = enum(i32) {
            pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_EMPHASIS;

            emphasis_none = bindings.V4L2_MPEG_AUDIO_EMPHASIS_NONE,
            emphasis_50_div_15_Us = bindings.V4L2_MPEG_AUDIO_EMPHASIS_50_DIV_15_uS,
            emphasis_ccitt_j17 = bindings.V4L2_MPEG_AUDIO_EMPHASIS_CCITT_J17,
        };

        pub const cRC = enum(i32) {
            pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_CRC;

            none = bindings.V4L2_MPEG_AUDIO_CRC_NONE,
            crc16 = bindings.V4L2_MPEG_AUDIO_CRC_CRC16,
        };

        pub const mute = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_MUTE;
        };

        pub const aac = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_AAC_BITRATE;
        };

        pub const ac3 = enum(i32) {
            pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_AC3_BITRATE;

            bitrate_32k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_32K,
            bitrate_40k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_40K,
            bitrate_48k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_48K,
            bitrate_56k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_56K,
            bitrate_64k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_64K,
            bitrate_80k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_80K,
            bitrate_96k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_96K,
            bitrate_112k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_112K,
            bitrate_128k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_128K,
            bitrate_160k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_160K,
            bitrate_192k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_192K,
            bitrate_224k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_224K,
            bitrate_256k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_256K,
            bitrate_320k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_320K,
            bitrate_384k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_384K,
            bitrate_448k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_448K,
            bitrate_512k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_512K,
            bitrate_576k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_576K,
            bitrate_640k = bindings.V4L2_MPEG_AUDIO_AC3_BITRATE_640K,
        };

        pub const dec = enum(i32) {
            pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_DEC_PLAYBACK;

            playback_auto = bindings.V4L2_MPEG_AUDIO_DEC_PLAYBACK_AUTO,
            playback_stereo = bindings.V4L2_MPEG_AUDIO_DEC_PLAYBACK_STEREO,
            playback_left = bindings.V4L2_MPEG_AUDIO_DEC_PLAYBACK_LEFT,
            playback_right = bindings.V4L2_MPEG_AUDIO_DEC_PLAYBACK_RIGHT,
            playback_mono = bindings.V4L2_MPEG_AUDIO_DEC_PLAYBACK_MONO,
            playback_swapped_stereo = bindings.V4L2_MPEG_AUDIO_DEC_PLAYBACK_SWAPPED_STEREO,

            pub const multilingual = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_DEC_MULTILINGUAL_PLAYBACK;
            };
        };
    };

    pub const video = struct {
        pub const Encoding = enum(i32) {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_ENCODING;

            mpeg_1 = bindings.V4L2_MPEG_VIDEO_ENCODING_MPEG_1,
            mpeg_2 = bindings.V4L2_MPEG_VIDEO_ENCODING_MPEG_2,
            mpeg_4_avc = bindings.V4L2_MPEG_VIDEO_ENCODING_MPEG_4_AVC,
        };

        pub const Aspect = enum(i32) {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_ASPECT;
            aspect_1x1 = bindings.V4L2_MPEG_VIDEO_ASPECT_1x1,
            aspect_4x3 = bindings.V4L2_MPEG_VIDEO_ASPECT_4x3,
            aspect_16x9 = bindings.V4L2_MPEG_VIDEO_ASPECT_16x9,
            aspect_221x100 = bindings.V4L2_MPEG_VIDEO_ASPECT_221x100,
        };

        pub const b_frames = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_B_FRAMES;
        };

        pub const gop_size = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_GOP_SIZE;
        };

        pub const gop_closure = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_GOP_CLOSURE;
        };

        pub const pull_down = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_PULLDOWN;
        };

        pub const bitrate = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_BITRATE;

            pub const Mode = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_BITRATE_MODE;

                vbr = bindings.V4L2_MPEG_VIDEO_BITRATE_MODE_VBR,
                cbr = bindings.V4L2_MPEG_VIDEO_BITRATE_MODE_CBR,
                cq = bindings.V4L2_MPEG_VIDEO_BITRATE_MODE_CQ,
            };

            pub const peak = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_BITRATE_PEAK;
            };
        };

        pub const temporal_decimation = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_TEMPORAL_DECIMATION;
        };

        pub const mute = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MUTE;

            pub const yuv = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MUTE_YUV;
            };
        };

        pub const decoder = struct {
            pub const slice_interface = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_DECODER_SLICE_INTERFACE;
            };

            pub const mpeg4_deblock_filter = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER;
            };
        };

        pub const cyclic_intra_refresh_mb = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_CYCLIC_INTRA_REFRESH_MB;
        };

        pub const frame_rc_enable = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE;
        };

        pub const HeaderMode = enum(i32) {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEADER_MODE;

            separate = bindings.V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE,
            joined_with_1st_frame = bindings.V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME,
        };

        pub const max_ref_pic = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MAX_REF_PIC;
        };

        pub const mb_rc_enable = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE;
        };

        pub const multi_slice = struct {
            pub const Mode = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MODE;

                pub const Enum = enum(i32) {
                    single = bindings.V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE,
                    max_mb = bindings.V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_MB,
                    max_bytes = bindings.V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_BYTES,
                };
            };

            pub const max_bytes = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MAX_BYTES;
            };

            pub const max_mb = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MAX_MB;
            };
        };

        pub const vbv_size = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_VBV_SIZE;
        };

        pub const dec_pts = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_DEC_PTS;
        };

        pub const dec_frame = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_DEC_FRAME;
        };

        pub const vbv_delay = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_VBV_DELAY;
        };

        pub const repeat_seq_header = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_REPEAT_SEQ_HEADER;
        };

        pub const mv_h_search_range = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MV_H_SEARCH_RANGE;
        };

        pub const mv_v_search_range = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MV_V_SEARCH_RANGE;
        };

        pub const force_key_frame = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME;
        };

        pub const base_layer_priority = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_BASELAYER_PRIORITY_ID;
        };

        pub const au_delimiter = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_AU_DELIMITER;
        };

        pub const ltr_count = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_LTR_COUNT;
        };

        pub const ltr_index = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_FRAME_LTR_INDEX;
        };

        pub const ltr_frames = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES;
        };

        pub const conceal_color = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_DEC_CONCEAL_COLOR;
        };

        pub const intra_refresh_period = struct {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD;
        };

        pub const intra_refresh_period_type = enum(i32) {
            pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE;

            random = 0,
            cyclic = 1,
        };

        pub const mpeg2 = struct {
            pub const Level = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL;

                low = bindings.V4L2_MPEG_VIDEO_MPEG2_LEVEL_LOW,
                main = bindings.V4L2_MPEG_VIDEO_MPEG2_LEVEL_MAIN,
                high_1440 = bindings.V4L2_MPEG_VIDEO_MPEG2_LEVEL_HIGH_1440,
                high = bindings.V4L2_MPEG_VIDEO_MPEG2_LEVEL_HIGH,
            };

            pub const Profile = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE;

                simple = bindings.V4L2_MPEG_VIDEO_MPEG2_PROFILE_SIMPLE,
                main = bindings.V4L2_MPEG_VIDEO_MPEG2_PROFILE_MAIN,
                snr_scalable = bindings.V4L2_MPEG_VIDEO_MPEG2_PROFILE_SNR_SCALABLE,
                spatially_scalable = bindings.V4L2_MPEG_VIDEO_MPEG2_PROFILE_SPATIALLY_SCALABLE,
                high = bindings.V4L2_MPEG_VIDEO_MPEG2_PROFILE_HIGH,
                multiview = bindings.V4L2_MPEG_VIDEO_MPEG2_PROFILE_MULTIVIEW,
            };
        };

        pub const h263 = struct {
            pub const i_frame_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H263_I_FRAME_QP;
            };

            pub const p_frame_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H263_P_FRAME_QP;
            };

            pub const b_frame_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H263_B_FRAME_QP;
            };

            pub const min_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H263_MIN_QP;
            };

            pub const max_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H263_MAX_QP;
            };
        };

        pub const h264 = struct {
            pub const i_frame_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_I_FRAME_QP;
            };

            pub const p_frame_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_P_FRAME_QP;
            };

            pub const b_frame_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_B_FRAME_QP;
            };

            pub const min_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_MIN_QP;
            };

            pub const max_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_MAX_QP;
            };

            pub const transform_8_x_8 = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_8X8_TRANSFORM;
            };

            pub const cpb_size = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_CPB_SIZE;
            };

            pub const EntropyMode = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_ENTROPY_MODE;

                cavlc = bindings.V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CAVLC,
                cabac = bindings.V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC,
            };

            pub const i_period = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_I_PERIOD;
            };

            pub const Level = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_LEVEL;

                lvl_1_0 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_1_0,
                lvl_1b = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_1B,
                lvl_1_1 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_1_1,
                lvl_1_2 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_1_2,
                lvl_1_3 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_1_3,
                lvl_2_0 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_2_0,
                lvl_2_1 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_2_1,
                lvl_2_2 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_2_2,
                lvl_3_0 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_3_0,
                lvl_3_1 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_3_1,
                lvl_3_2 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_3_2,
                lvl_4_0 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_4_0,
                lvl_4_1 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_4_1,
                lvl_4_2 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_4_2,
                lvl_5_0 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_5_0,
                lvl_5_1 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_5_1,
                lvl_5_2 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_5_2,
                lvl_6_0 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_6_0,
                lvl_6_1 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_6_1,
                lvl_6_2 = bindings.V4L2_MPEG_VIDEO_H264_LEVEL_6_2,
            };

            pub const loop_filter = struct {
                pub const alpha = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_ALPHA;
                };

                pub const beta = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_BETA;
                };

                pub const Mode = enum(i32) {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_MODE;

                    enabled = bindings.V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_ENABLED,
                    disabled = bindings.V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_DISABLED,
                    disabled_at_slice_boundary = bindings.V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_DISABLED_AT_SLICE_BOUNDARY,
                };
            };

            pub const Profile = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_PROFILE;

                baseline = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
                constrained_baseline = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE,
                main = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_MAIN,
                extended = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED,
                high = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
                high_10 = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10,
                high_422 = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422,
                high_444_predictive = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_444_PREDICTIVE,
                high_10_intra = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10_INTRA,
                high_422_intra = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422_INTRA,
                high_444_intra = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_444_INTRA,
                cavlc_444_intra = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_CAVLC_444_INTRA,
                scalable_baseline = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_SCALABLE_BASELINE,
                scalable_high = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_SCALABLE_HIGH,
                scalable_high_intra = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_SCALABLE_HIGH_INTRA,
                stereo_high = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_STEREO_HIGH,
                multiview_high = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_MULTIVIEW_HIGH,
                constrained_high = bindings.V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH,
            };

            pub const vui_sar = struct {
                pub const height = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_VUI_EXT_SAR_HEIGHT;
                };

                pub const width = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_VUI_EXT_SAR_WIDTH;
                };

                pub const enable = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_ENABLE;
                };

                pub const Idc = enum(i32) {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_IDC;

                    idc_unspecified = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_UNSPECIFIED,
                    idc_1X1 = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_1x1,
                    idc_12X11 = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_12x11,
                    idc_10X11 = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_10x11,
                    idc_16X11 = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_16x11,
                    idc_40X33 = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_40x33,
                    idc_24X11 = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_24x11,
                    idc_20X11 = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_20x11,
                    idc_32X11 = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_32x11,
                    idc_80X33 = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_80x33,
                    idc_18X11 = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_18x11,
                    idc_15X11 = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_15x11,
                    idc_64X33 = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_64x33,
                    idc_160X99 = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_160x99,
                    idc_4X3 = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_4x3,
                    idc_3X2 = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_3x2,
                    idc_2X1 = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_2x1,
                    idc_extended = bindings.V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_EXTENDED,
                };
            };

            pub const sei_frame_packing = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_SEI_FRAME_PACKING;

                pub const current_frame = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_SEI_FP_CURRENT_FRAME_0;
                };

                pub const ArrangementType = enum(i32) {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE;

                    checkerboard = bindings.V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_CHECKERBOARD,
                    column = bindings.V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_COLUMN,
                    row = bindings.V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_ROW,
                    side_by_side = bindings.V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_SIDE_BY_SIDE,
                    top_bottom = bindings.V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_TOP_BOTTOM,
                    temporal = bindings.V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_TEMPORAL,
                };
            };

            pub const fmo = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_FMO;

                pub const Type = enum(i32) {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_FMO_MAP_TYPE;

                    interleaved_slices = bindings.V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_INTERLEAVED_SLICES,
                    scattered_slices = bindings.V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_SCATTERED_SLICES,
                    foreground_with_left_over = bindings.V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_FOREGROUND_WITH_LEFT_OVER,
                    box_out = bindings.V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_BOX_OUT,
                    raster_scan = bindings.V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_RASTER_SCAN,
                    wipe_scan = bindings.V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_WIPE_SCAN,
                    explicit = bindings.V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_EXPLICIT,
                };

                pub const slice_group = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_FMO_SLICE_GROUP;
                };

                pub const ChangeDirection = enum(i32) {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_FMO_CHANGE_DIRECTION;

                    right = bindings.V4L2_MPEG_VIDEO_H264_FMO_CHANGE_DIR_RIGHT,
                    left = bindings.V4L2_MPEG_VIDEO_H264_FMO_CHANGE_DIR_LEFT,
                };

                pub const change_rate = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_FMO_CHANGE_RATE;
                };

                pub const run_length = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_FMO_RUN_LENGTH;
                };
            };

            pub const aso = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_ASO;

                pub const slice_order = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_ASO_SLICE_ORDER;
                };
            };

            pub const hierarchical_coding = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING;

                pub const Type = enum(i32) {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_TYPE;

                    V4L2_MPEG_VIDEO_H264_HIERARCHICAL_CODING_B = 0,
                    V4L2_MPEG_VIDEO_H264_HIERARCHICAL_CODING_P = 1,
                };

                pub const layer = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER;
                };
                pub const layer_qp = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER_QP;
                };
            };

            pub const constrained_intra_prediction = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_CONSTRAINED_INTRA_PREDICTION;
            };

            pub const chroma_qp_index_offset = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_CHROMA_QP_INDEX_OFFSET;
            };

            pub const i_frame_min_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP;
            };

            pub const i_frame_max_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP;
            };

            pub const p_frame_min_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP;
            };

            pub const p_frame_max_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP;
            };

            pub const b_frame_min_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_B_FRAME_MIN_QP;
            };

            pub const b_frame_max_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_B_FRAME_MAX_QP;
            };

            pub const hier_coding = struct {
                pub const l0_br: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L0_BR;
                pub const l1_br: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L1_BR;
                pub const l2_br: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L2_BR;
                pub const l3_br: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L3_BR;
                pub const l4_br: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L4_BR;
                pub const l5_br: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L5_BR;
                pub const l6_br: u32 = bindings.V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L6_BR;
            };
        };

        pub const mpeg4 = struct {
            pub const i_frame_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP;
            };

            pub const p_frame_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP;
            };

            pub const b_frame_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP;
            };

            pub const min_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MPEG4_MIN_QP;
            };

            pub const max_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MPEG4_MAX_QP;
            };

            pub const Level = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MPEG4_LEVEL;

                lvl_0 = bindings.V4L2_MPEG_VIDEO_MPEG4_LEVEL_0,
                lvl_0B = bindings.V4L2_MPEG_VIDEO_MPEG4_LEVEL_0B,
                lvl_1 = bindings.V4L2_MPEG_VIDEO_MPEG4_LEVEL_1,
                lvl_2 = bindings.V4L2_MPEG_VIDEO_MPEG4_LEVEL_2,
                lvl_3 = bindings.V4L2_MPEG_VIDEO_MPEG4_LEVEL_3,
                lvl_3B = bindings.V4L2_MPEG_VIDEO_MPEG4_LEVEL_3B,
                lvl_4 = bindings.V4L2_MPEG_VIDEO_MPEG4_LEVEL_4,
                lvl_5 = bindings.V4L2_MPEG_VIDEO_MPEG4_LEVEL_5,
            };

            pub const Profile = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MPEG4_PROFILE;

                simple = bindings.V4L2_MPEG_VIDEO_MPEG4_PROFILE_SIMPLE,
                advanced_simple = bindings.V4L2_MPEG_VIDEO_MPEG4_PROFILE_ADVANCED_SIMPLE,
                core = bindings.V4L2_MPEG_VIDEO_MPEG4_PROFILE_CORE,
                simple_scalable = bindings.V4L2_MPEG_VIDEO_MPEG4_PROFILE_SIMPLE_SCALABLE,
                advanced_coding_efficiency = bindings.V4L2_MPEG_VIDEO_MPEG4_PROFILE_ADVANCED_CODING_EFFICIENCY,
            };

            pub const qpel = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_MPEG4_QPEL;
            };
        };

        pub const vp8 = struct {
            pub const NumPartions = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_VPX_NUM_PARTITIONS;

                p1 = bindings.V4L2_CID_MPEG_VIDEO_VPX_1_PARTITION,
                p2 = bindings.V4L2_CID_MPEG_VIDEO_VPX_2_PARTITIONS,
                p4 = bindings.V4L2_CID_MPEG_VIDEO_VPX_4_PARTITIONS,
                p8 = bindings.V4L2_CID_MPEG_VIDEO_VPX_8_PARTITIONS,
            };

            pub const imd_disable_4x4 = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_VPX_IMD_DISABLE_4X4;
            };

            pub const NumRefFrame = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_VPX_NUM_REF_FRAMES;

                ref_1 = bindings.V4L2_CID_MPEG_VIDEO_VPX_1_REF_FRAME,
                ref_2 = bindings.V4L2_CID_MPEG_VIDEO_VPX_2_REF_FRAME,
                ref_3 = bindings.V4L2_CID_MPEG_VIDEO_VPX_3_REF_FRAME,
            };

            pub const filter_level = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_VPX_FILTER_LEVEL;
            };

            pub const filter_sharpness = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_VPX_FILTER_SHARPNESS;
            };

            pub const golden_frame = struct {
                pub const period = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_REF_PERIOD;
                };

                pub const FrameSel = enum(i32) {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_SEL;

                    use_prev = bindings.V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_USE_PREV,
                    use_ref_period = bindings.V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_USE_REF_PERIOD,
                };
            };

            pub const min_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_VPX_MIN_QP;
            };

            pub const max_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_VPX_MAX_QP;
            };
            pub const i_frame_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_VPX_I_FRAME_QP;
            };

            pub const p_frame_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_VPX_P_FRAME_QP;
            };

            pub const Profile = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_VP8_PROFILE;

                p0 = bindings.V4L2_MPEG_VIDEO_VP8_PROFILE_0,
                p1 = bindings.V4L2_MPEG_VIDEO_VP8_PROFILE_1,
                p2 = bindings.V4L2_MPEG_VIDEO_VP8_PROFILE_2,
                p3 = bindings.V4L2_MPEG_VIDEO_VP8_PROFILE_3,
            };
        };

        pub const vp9 = struct {
            pub const Profile = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_VP9_PROFILE;

                p0 = bindings.V4L2_MPEG_VIDEO_VP9_PROFILE_0,
                p1 = bindings.V4L2_MPEG_VIDEO_VP9_PROFILE_1,
                p2 = bindings.V4L2_MPEG_VIDEO_VP9_PROFILE_2,
                p3 = bindings.V4L2_MPEG_VIDEO_VP9_PROFILE_3,
            };
            pub const Level = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_VP9_LEVEL;

                lvl_1_0 = bindings.V4L2_MPEG_VIDEO_VP9_LEVEL_1_0,
                lvl_1_1 = bindings.V4L2_MPEG_VIDEO_VP9_LEVEL_1_1,
                lvl_2_0 = bindings.V4L2_MPEG_VIDEO_VP9_LEVEL_2_0,
                lvl_2_1 = bindings.V4L2_MPEG_VIDEO_VP9_LEVEL_2_1,
                lvl_3_0 = bindings.V4L2_MPEG_VIDEO_VP9_LEVEL_3_0,
                lvl_3_1 = bindings.V4L2_MPEG_VIDEO_VP9_LEVEL_3_1,
                lvl_4_0 = bindings.V4L2_MPEG_VIDEO_VP9_LEVEL_4_0,
                lvl_4_1 = bindings.V4L2_MPEG_VIDEO_VP9_LEVEL_4_1,
                lvl_5_0 = bindings.V4L2_MPEG_VIDEO_VP9_LEVEL_5_0,
                lvl_5_1 = bindings.V4L2_MPEG_VIDEO_VP9_LEVEL_5_1,
                lvl_5_2 = bindings.V4L2_MPEG_VIDEO_VP9_LEVEL_5_2,
                lvl_6_0 = bindings.V4L2_MPEG_VIDEO_VP9_LEVEL_6_0,
                lvl_6_1 = bindings.V4L2_MPEG_VIDEO_VP9_LEVEL_6_1,
                lvl_6_2 = bindings.V4L2_MPEG_VIDEO_VP9_LEVEL_6_2,
            };
        };

        pub const hvec = struct {
            pub const min_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_MIN_QP;
            };

            pub const max_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_MAX_QP;
            };

            pub const i_frame_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_QP;
            };

            pub const p_frame_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_P_FRAME_QP;
            };

            pub const b_frame_qp = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_B_FRAME_QP;
            };

            pub const hier = struct {
                pub const qp = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_HIER_QP;
                };

                pub const coding = enum(i32) {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_TYPE;

                    b = bindings.V4L2_MPEG_VIDEO_HEVC_HIERARCHICAL_CODING_B,
                    p = bindings.V4L2_MPEG_VIDEO_HEVC_HIERARCHICAL_CODING_P,
                };

                pub const layer = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_LAYER;
                    pub const l0: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L0_QP;
                    pub const l1: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L1_QP;
                    pub const l2: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L2_QP;
                    pub const l3: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L3_QP;
                    pub const l4: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L4_QP;
                    pub const l5: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L5_QP;
                    pub const l6: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L6_QP;
                };

                pub const l0_br: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L0_BR;
                pub const l1_br: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L1_BR;
                pub const l2_br: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L2_BR;
                pub const l3_br: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L3_BR;
                pub const l4_br: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L4_BR;
                pub const l5_br: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L5_BR;
                pub const l6_br: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L6_BR;
            };

            pub const Profile = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_PROFILE;

                main = bindings.V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
                main_still_picture = bindings.V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE,
                main_10 = bindings.V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10,
            };

            pub const Level = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_LEVEL;

                lvl_1 = bindings.V4L2_MPEG_VIDEO_HEVC_LEVEL_1,
                lvl_2 = bindings.V4L2_MPEG_VIDEO_HEVC_LEVEL_2,
                lvl_2_1 = bindings.V4L2_MPEG_VIDEO_HEVC_LEVEL_2_1,
                lvl_3 = bindings.V4L2_MPEG_VIDEO_HEVC_LEVEL_3,
                lvl_3_1 = bindings.V4L2_MPEG_VIDEO_HEVC_LEVEL_3_1,
                lvl_4 = bindings.V4L2_MPEG_VIDEO_HEVC_LEVEL_4,
                lvl_4_1 = bindings.V4L2_MPEG_VIDEO_HEVC_LEVEL_4_1,
                lvl_5 = bindings.V4L2_MPEG_VIDEO_HEVC_LEVEL_5,
                lvl_5_1 = bindings.V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1,
                lvl_5_2 = bindings.V4L2_MPEG_VIDEO_HEVC_LEVEL_5_2,
                lvl_6 = bindings.V4L2_MPEG_VIDEO_HEVC_LEVEL_6,
                lvl_6_1 = bindings.V4L2_MPEG_VIDEO_HEVC_LEVEL_6_1,
                lvl_6_2 = bindings.V4L2_MPEG_VIDEO_HEVC_LEVEL_6_2,
            };

            pub const frame_rate_resolution = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_FRAME_RATE_RESOLUTION;
            };

            pub const Tier = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_TIER;

                main = bindings.V4L2_MPEG_VIDEO_HEVC_TIER_MAIN,
                high = bindings.V4L2_MPEG_VIDEO_HEVC_TIER_HIGH,
            };

            pub const partion_depth = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_MAX_PARTITION_DEPTH;
            };

            pub const loop_filter = struct {
                pub const Mode = enum(i32) {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE;

                    disabled = bindings.V4L2_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE_DISABLED,
                    enabled = bindings.V4L2_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE_ENABLED,
                    disabled_at_slice_boundary = bindings.V4L2_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE_DISABLED_AT_SLICE_BOUNDARY,
                };

                pub const beta = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_LF_BETA_OFFSET_DIV2;
                };

                pub const tc = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_LF_TC_OFFSET_DIV2;
                };
            };

            pub const refresh = struct {
                pub const Type = enum(i32) {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_REFRESH_TYPE;

                    none = bindings.V4L2_MPEG_VIDEO_HEVC_REFRESH_NONE,
                    cra = bindings.V4L2_MPEG_VIDEO_HEVC_REFRESH_CRA,
                    idr = bindings.V4L2_MPEG_VIDEO_HEVC_REFRESH_IDR,
                };

                pub const period = struct {
                    pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_REFRESH_PERIOD;
                };
            };

            pub const lossless_cu = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_LOSSLESS_CU;
            };

            pub const intra_pred = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_CONST_INTRA_PRED;
            };

            pub const wavefront = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_WAVEFRONT;
            };

            pub const general_pb = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_GENERAL_PB;
            };

            pub const temporal_id = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_TEMPORAL_ID;
            };

            pub const strong_smoothing = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_STRONG_SMOOTHING;
            };

            pub const max_num_merge_mv_minus1 = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_MAX_NUM_MERGE_MV_MINUS1;
            };

            pub const intra_pu_split = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_INTRA_PU_SPLIT;
            };

            pub const tmv_prediction = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_TMV_PREDICTION;
            };

            pub const without_startcode = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_WITHOUT_STARTCODE;
            };

            pub const LengthField = enum(i32) {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_HEVC_SIZE_OF_LENGTH_FIELD;

                size_0 = bindings.V4L2_MPEG_VIDEO_HEVC_SIZE_0,
                size_1 = bindings.V4L2_MPEG_VIDEO_HEVC_SIZE_1,
                size_2 = bindings.V4L2_MPEG_VIDEO_HEVC_SIZE_2,
                size_4 = bindings.V4L2_MPEG_VIDEO_HEVC_SIZE_4,
            };
        };
    };

    pub const fwht = struct {
        pub const i_frame_qp = struct {
            pub const id: u32 = bindings.V4L2_CID_FWHT_I_FRAME_QP;
        };

        pub const p_frame_qp = struct {
            pub const id: u32 = bindings.V4L2_CID_FWHT_P_FRAME_QP;
        };
    };
};

test "Control ABI matches struct_v4l2_control" {
    const C = bindings.struct_v4l2_control;
    const Z = Control;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "id"), @offsetOf(Z, "id"));
    try std.testing.expectEqual(@offsetOf(C, "value"), @offsetOf(Z, "value"));
}

test "Control.Ext ABI matches struct_v4l2_ext_control" {
    const C = bindings.struct_v4l2_ext_control;
    const Z = Control.Ext;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "id"), @offsetOf(Z, "id"));
    try std.testing.expectEqual(@offsetOf(C, "size"), @offsetOf(Z, "size"));
    try std.testing.expectEqual(@offsetOf(C, "reserved2"), @offsetOf(Z, "reserved2"));
}

test "Control.ExtSet ABI matches struct_v4l2_ext_controls" {
    const C = bindings.struct_v4l2_ext_controls;
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
    const C = bindings.struct_v4l2_queryctrl;
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
    const C = bindings.struct_v4l2_query_ext_ctrl;
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
    const C = bindings.struct_v4l2_querymenu;
    const Z = Control.MenuQuery;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "id"), @offsetOf(Z, "id"));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}
