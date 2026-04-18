const c = @import("bindings");
const std = @import("std");
const geometry = @import("geometry.zig");
const Area = geometry.Area;
const Rectangle = geometry.Rectangle;

comptime {
    std.testing.refAllDecls(@This());
}
const DONT_TOUCH = struct {
    fn genmask(comptime T: type, hi: u6, lo: u6) T {
        comptime {
            if (!@typeInfo(T).Int.is_signed)
                @compileError("T must be an unsigned integer type");
            if (hi < lo)
                @compileError("hi must be >= lo");
            if (hi >= @bitSizeOf(T))
                @compileError("hi out of range for type");
        }

        const all_ones: T = ~@as(T, 0);

        return (all_ones >> (@bitSizeOf(T) - 1 - hi)) &
            (all_ones << lo);
    }
};

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

    pub const strobe = struct {
        pub const id: u32 = c.V4L2_CID_FLASH_STROBE;

        pub const Source = enum(i32) {
            pub const id: u32 = c.V4L2_CID_FLASH_STROBE_SOURCE;
            software = c.V4L2_FLASH_STROBE_SOURCE_SOFTWARE,
            external = c.V4L2_FLASH_STROBE_SOURCE_EXTERNAL,
        };

        pub const stop = struct {
            pub const id: u32 = c.V4L2_CID_FLASH_STROBE_STOP;
        };

        pub const status = struct {
            pub const id: u32 = c.V4L2_CID_FLASH_STROBE_STATUS;
        };
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

pub const image = struct {
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

    // @TODO in v4l2-controls.h from line 1300 to 1700
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

        pub const sps = extern struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_H264_SPS;

            pub const Contraint = enum(i32) {
                set0_flag = c.V4L2_H264_SPS_CONSTRAINT_SET0_FLAG,
                set1_flag = c.V4L2_H264_SPS_CONSTRAINT_SET1_FLAG,
                set2_flag = c.V4L2_H264_SPS_CONSTRAINT_SET2_FLAG,
                set3_flag = c.V4L2_H264_SPS_CONSTRAINT_SET3_FLAG,
                set4_flag = c.V4L2_H264_SPS_CONSTRAINT_SET4_FLAG,
                set5_flag = c.V4L2_H264_SPS_CONSTRAINT_SET5_FLAG,
            };

            pub const Flag = enum(i32) {
                separate_colour_plane = c.V4L2_H264_SPS_FLAG_SEPARATE_COLOUR_PLANE,
                qpprime_y_zero_transform_bypass = c.V4L2_H264_SPS_FLAG_QPPRIME_Y_ZERO_TRANSFORM_BYPASS,
                delta_pic_order_always_zero = c.V4L2_H264_SPS_FLAG_DELTA_PIC_ORDER_ALWAYS_ZERO,
                gaps_in_frame_num_value_allowed = c.V4L2_H264_SPS_FLAG_GAPS_IN_FRAME_NUM_VALUE_ALLOWED,
                frame_mbs_only = c.V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY,
                mb_adaptive_frame_field = c.V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD,
                direct_8x8_inference = c.V4L2_H264_SPS_FLAG_DIRECT_8X8_INFERENCE,
            };

            pub const hasChromaFormat = c.V4L2_H264_SPS_HAS_CHROMA_FORMAT;

            profile_idc: u8,
            constraint_set_flags: u8,
            level_idc: u8,
            seq_parameter_set_id: u8,
            chroma_format_idc: u8,
            bit_depth_luma_minus8: u8,
            bit_depth_chroma_minus8: u8,
            log2_max_frame_num_minus4: u8,
            pic_order_cnt_type: u8,
            log2_max_pic_order_cnt_lsb_minus4: u8,
            max_num_ref_frames: u8,
            num_ref_frames_in_pic_order_cnt_cycle: u8,
            offset_for_ref_frame: [255]i32,
            offset_for_non_ref_pic: i32,
            offset_for_top_to_bottom_field: i32,
            pic_width_in_mbs_minus1: u16,
            pic_height_in_map_units_minus1: u16,
            flags: u32,
        };

        pub const pps = extern struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_H264_PPS;

            pub const Flag = enum(i32) {
                entropy_coding_mode = c.V4L2_H264_PPS_FLAG_ENTROPY_CODING_MODE,
                bottom_field_pic_order_in_frame_present = c.V4L2_H264_PPS_FLAG_BOTTOM_FIELD_PIC_ORDER_IN_FRAME_PRESENT,
                weighted_pred = c.V4L2_H264_PPS_FLAG_WEIGHTED_PRED,
                deblocking_filter_control_present = c.V4L2_H264_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT,
                constrained_intra_pred = c.V4L2_H264_PPS_FLAG_CONSTRAINED_INTRA_PRED,
                redundant_pic_cnt_present = c.V4L2_H264_PPS_FLAG_REDUNDANT_PIC_CNT_PRESENT,
                transform_8x8_mode = c.V4L2_H264_PPS_FLAG_TRANSFORM_8X8_MODE,
                scaling_matrix_present = c.V4L2_H264_PPS_FLAG_SCALING_MATRIX_PRESENT,
            };

            pic_parameter_set_id: u8,
            seq_parameter_set_id: u8,
            num_slice_groups_minus1: u8,
            num_ref_idx_l0_default_active_minus1: u8,
            num_ref_idx_l1_default_active_minus1: u8,
            weighted_bipred_idc: u8,
            pic_init_qp_minus26: i8,
            pic_init_qs_minus26: i8,
            chroma_qp_index_offset: i8,
            second_chroma_qp_index_offset: i8,
            flags: u16,
        };

        pub const ScalingMatrix = extern struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_H264_SCALING_MATRIX;

            scaling_list_4x4: [6][16]u8,
            scaling_list_8x8: [6][64]u8,
        };

        pub const WeightFactors = extern struct {
            luma_weight: [32]i16,
            luma_offset: [32]i16,
            chroma_weight: [32][2]i16,
            chroma_offset: [32][2]i16,
        };

        pub const pred_weights = extern struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_H264_PRED_WEIGHTS;
            pub const predWeightsRequired = c.V4L2_H264_CTRL_PRED_WEIGHTS_REQUIRED;

            luma_log2_weight_denom: u16,
            chroma_log2_weight_denom: u16,
            weight_factors: [2]WeightFactors,
        };

        pub const Slice = enum(i32) {
            p = c.V4L2_H264_SLICE_TYPE_P,
            b = c.V4L2_H264_SLICE_TYPE_B,
            i = c.V4L2_H264_SLICE_TYPE_I,
            sp = c.V4L2_H264_SLICE_TYPE_SP,
            si = c.V4L2_H264_SLICE_TYPE_SI,

            pub const Flag = enum(i32) {
                direct_spatial_mv_pred = c.V4L2_H264_SLICE_FLAG_DIRECT_SPATIAL_MV_PRED,
                sp_for_switch = c.V4L2_H264_SLICE_FLAG_SP_FOR_SWITCH,
            };
        };

        pub const Reference = extern struct {
            fields: u8,
            index: u8,

            pub const Field = enum(u8) {
                top_field = c.V4L2_H264_TOP_FIELD_REF,
                bottom_field = c.V4L2_H264_BOTTOM_FIELD_REF,
                frame = c.V4L2_H264_FRAME_REF,
            };
        };

        pub const slice_params = extern struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_H264_SLICE_PARAMS;

            header_bit_size: u32,
            first_mb_in_slice: u32,
            slice_type: u8,
            colour_plane_id: u8,
            redundant_pic_cnt: u8,
            cabac_init_idc: u8,
            slice_qp_delta: i8,
            slice_qs_delta: i8,
            disable_deblocking_filter_idc: u8,
            slice_alpha_c0_offset_div2: i8,
            slice_beta_offset_div2: i8,
            num_ref_idx_l0_active_minus1: u8,
            num_ref_idx_l1_active_minus1: u8,
            reserved: u8,
            ref_pic_list0: [c.V4L2_H264_REF_LIST_LEN]Reference,
            ref_pic_list1: [c.V4L2_H264_REF_LIST_LEN]Reference,
            flags: u32,
        };

        pub const dpb = struct {
            // @TODO ??
            // #define V4L2_H264_NUM_DPB_ENTRIES 16
            // #define V4L2_H264_REF_LIST_LEN (2 * V4L2_H264_NUM_DPB_ENTRIES)
            pub const Entry = extern struct {
                reference_ts: u64,
                pic_num: u32,
                frame_num: u16,
                fields: u8,
                reserved: [5]u8,
                top_field_order_cnt: i32,
                bottom_field_order_cnt: i32,
                flags: u32,
            };

            pub const Flag = enum(i32) {
                valid = c.V4L2_H264_DPB_ENTRY_FLAG_VALID,
                active = c.V4L2_H264_DPB_ENTRY_FLAG_ACTIVE,
                long_term = c.V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM,
                field = c.V4L2_H264_DPB_ENTRY_FLAG_FIELD,
            };
        };

        pub const DecodeParams = extern struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_H264_DECODE_PARAMS;

            pub const Flag = enum(i32) {
                idr_pic = c.V4L2_H264_DECODE_PARAM_FLAG_IDR_PIC,
                field_pic = c.V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC,
                bottom_field = c.V4L2_H264_DECODE_PARAM_FLAG_BOTTOM_FIELD,
                pframe = c.V4L2_H264_DECODE_PARAM_FLAG_PFRAME,
                bframe = c.V4L2_H264_DECODE_PARAM_FLAG_BFRAME,
            };
        };
    };

    pub const fwht = struct {
        pub const version: u32 = c.V4L2_FWHT_VERSION;

        pub const params = extern struct {
            // @TODO in v4l2-controls line 1765-1775
            //         /**
            //  * struct v4l2_ctrl_fwht_params - FWHT parameters
            //  *
            //  * @backward_ref_ts: timestamp of the V4L2 capture buffer to use as reference.
            //  * The timestamp refers to the timestamp field in struct v4l2_buffer.
            //  * Use v4l2_timeval_to_ns() to convert the struct timeval to a __u64.
            //  * @version: must be V4L2_FWHT_VERSION.
            //  * @width: width of frame.
            //  * @height: height of frame.
            //  * @flags: FWHT flags (see V4L2_FWHT_FL_*).
            //  * @colorspace: the colorspace (enum v4l2_colorspace).
            //  * @xfer_func: the transfer function (enum v4l2_xfer_func).
            //  * @ycbcr_enc: the Y'CbCr encoding (enum v4l2_ycbcr_encoding).
            //  * @quantization: the quantization (enum v4l2_quantization).
            //  */
            // struct v4l2_ctrl_fwht_params {
            //  __u64 backward_ref_ts;
            //  __u32 version;
            //  __u32 width;
            //  __u32 height;
            //  __u32 flags;
            //  __u32 colorspace;
            //  __u32 xfer_func;
            //  __u32 ycbcr_enc;
            //  __u32 quantization;
            // };

            pub const id: u32 = c.V4L2_CID_STATELESS_FWHT_PARAMS;
        };

        pub const isInterlaced = c.V4L2_FWHT_FL_IS_INTERLACED;
        pub const isBottomFirst = c.V4L2_FWHT_FL_IS_INTERLACED;
        pub const isAlternate = c.V4L2_FWHT_FL_IS_ALTERNATE;
        pub const isBottomField = c.V4L2_FWHT_FL_IS_BOTTOM_FIELD;
        pub const isLumaUncompressed = c.V4L2_FWHT_FL_LUMA_IS_UNCOMPRESSED;
        pub const isCbUncompressed = c.V4L2_FWHT_FL_CB_IS_UNCOMPRESSED;
        pub const isCrUncompressed = c.V4L2_FWHT_FL_CR_IS_UNCOMPRESSED;
        pub const isChromaFullHeight = c.V4L2_FWHT_FL_CHROMA_FULL_HEIGHT;
        pub const isChromaFullWidth = c.V4L2_FWHT_FL_CHROMA_FULL_WIDTH;
        pub const isAlphaUncompressed = c.V4L2_FWHT_FL_ALPHA_IS_UNCOMPRESSED;
        pub const isIFrame = c.V4L2_FWHT_FL_I_FRAME;
        pub const componentsNumberMask = DONT_TOUCH.genmask(c_long, 18, 16);
        pub const componentsNumberOffset = c.V4L2_FWHT_FL_COMPONENTS_NUM_OFFSET;
        pub const pixelEncodingMask = DONT_TOUCH.genmask(c_long, 20, 19);
        pub const pixelEncodingOffset = c.V4L2_FWHT_FL_PIXENC_OFFSET;
        pub const pixelEncodingYuv = c.V4L2_FWHT_FL_PIXENC_YUV;
        pub const pixelEncodingRgb = c.V4L2_FWHT_FL_PIXENC_RGB;
        pub const pixelEncodingHsv = c.V4L2_FWHT_FL_PIXENC_HSV;
    };

    pub const vp8 = struct {
        pub const Segment = extern struct {
            quant_update: [4]i8,
            lf_update: [4]i8,
            segment_probs: [3]u8,
            padding: u8,
            flags: u32,

            pub const Flag = enum(u8) {
                enabled = c.V4L2_VP8_SEGMENT_FLAG_ENABLED,
                update_map = c.V4L2_VP8_SEGMENT_FLAG_UPDATE_MAP,
                update_feature_data = c.V4L2_VP8_SEGMENT_FLAG_UPDATE_FEATURE_DATA,
                delta_value_mode = c.V4L2_VP8_SEGMENT_FLAG_DELTA_VALUE_MODE,
            };
        };

        pub const LoopFilter = extern struct {
            ref_frm_delta: [4]i8,
            mb_mode_delta: [4]i8,
            sharpness_level: u8,
            level: u8,
            padding: u16,
            flags: u32,

            pub const Flag = enum(u8) {
                V4L2_VP8_LF_ADJ_ENABLE = c.V4L2_VP8_LF_ADJ_ENABLE,
                V4L2_VP8_LF_DELTA_UPDATE = c.V4L2_VP8_LF_DELTA_UPDATE,
                V4L2_VP8_LF_FILTER_TYPE_SIMPLE = c.V4L2_VP8_LF_FILTER_TYPE_SIMPLE,
            };
        };

        pub const Quantization = extern struct {
            y_ac_qi: u8,
            y_dc_delta: i8,
            y2_dc_delta: i8,
            y2_ac_delta: i8,
            uv_dc_delta: i8,
            uv_ac_delta: i8,
            padding: u16,
        };

        pub const Entropy = extern struct {
            coeff_probs: [4][8][3][11]u8,
            y_mode_probs: [4]u8,
            uv_mode_probs: [3]u8,
            mv_probs: [2][19]u8,
            padding: [3]u8,

            pub const coeff_prob_cnt: u32 = c.V4L2_VP8_COEFF_PROB_CNT;
            pub const mv_prob_cnt: u32 = c.V4L2_VP8_MV_PROB_CNT;
        };

        pub const EntropyCoderState = extern struct {
            range: u8,
            value: u8,
            bit_count: u8,
            padding: u8,
        };

        pub const Frame = extern struct {
            segment: Segment,
            lf: LoopFilter,
            quant: Quantization,
            entropy: Entropy,
            coder_state: EntropyCoderState,
            width: u16,
            height: u16,
            horizontal_scale: u8,
            vertical_scale: u8,
            version: u8,
            prob_skip_false: u8,
            prob_intra: u8,
            prob_last: u8,
            prob_gf: u8,
            num_dct_parts: u8,
            first_part_size: u32,
            first_part_header_bits: u32,
            dct_part_sizes: [8]u32,
            last_frame_ts: u64,
            golden_frame_ts: u64,
            alt_frame_ts: u64,
            flags: u64,

            pub const Flag = enum(i32) {
                key_frame = c.V4L2_VP8_FRAME_FLAG_KEY_FRAME,
                experimental = c.V4L2_VP8_FRAME_FLAG_EXPERIMENTAL,
                show_frame = c.V4L2_VP8_FRAME_FLAG_SHOW_FRAME,
                mb_no_skip_coeff = c.V4L2_VP8_FRAME_FLAG_MB_NO_SKIP_COEFF,
                sign_bias_golden = c.V4L2_VP8_FRAME_FLAG_SIGN_BIAS_GOLDEN,
                sign_bias_alt = c.V4L2_VP8_FRAME_FLAG_SIGN_BIAS_ALT,
            };

            pub const isKeyFrame = &c.V4L2_VP8_FRAME_IS_KEY_FRAME;
        };
    };

    pub const mpeg2 = struct {
        pub const sequence = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_MPEG2_SEQUENCE;

            pub const Ctrl = extern struct {
                horizontal_size: u16,
                vertical_size: u16,
                vbv_buffer_size: u32,
                profile_and_level_indication: u16,
                chroma_format: u8,
                flags: u8,
            };
        };

        pub const picture = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_MPEG2_PICTURE;

            pub const CodingType = enum(i32) {
                i = c.V4L2_MPEG2_PIC_CODING_TYPE_I,
                p = c.V4L2_MPEG2_PIC_CODING_TYPE_P,
                b = c.V4L2_MPEG2_PIC_CODING_TYPE_B,
                d = c.V4L2_MPEG2_PIC_CODING_TYPE_D,
            };

            pub const Field = enum(i32) {
                top = c.V4L2_MPEG2_PIC_TOP_FIELD,
                bottom = c.V4L2_MPEG2_PIC_BOTTOM_FIELD,
                frame = c.V4L2_MPEG2_PIC_FRAME,
            };

            pub const Flag = enum(i32) {
                top_field_first = c.V4L2_MPEG2_PIC_FLAG_TOP_FIELD_FIRST,
                frame_pred_dct = c.V4L2_MPEG2_PIC_FLAG_FRAME_PRED_DCT,
                concealment_mv = c.V4L2_MPEG2_PIC_FLAG_CONCEALMENT_MV,
                q_scale_type = c.V4L2_MPEG2_PIC_FLAG_Q_SCALE_TYPE,
                intra_vlc = c.V4L2_MPEG2_PIC_FLAG_INTRA_VLC,
                alt_scan = c.V4L2_MPEG2_PIC_FLAG_ALT_SCAN,
                repeat_first = c.V4L2_MPEG2_PIC_FLAG_REPEAT_FIRST,
                progressive = c.V4L2_MPEG2_PIC_FLAG_PROGRESSIVE,
            };

            pub const Ctrl = extern struct {
                backward_ref_ts: u64,
                forward_ref_ts: u64,
                flags: u32,
                f_code: [2][2]u8,
                picture_coding_type: u8,
                picture_structure: u8,
                intra_dc_precision: u8,
                reserved: [5]u8,
            };
        };

        pub const quantisation = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_MPEG2_QUANTISATION;

            pub const Ctrl = extern struct {
                intra_quantiser_matrix: [64]u8,
                non_intra_quantiser_matrix: [64]u8,
                chroma_intra_quantiser_matrix: [64]u8,
                chroma_non_intra_quantiser_matrix: [64]u8,
            };
        };
    };

    pub const hevc = struct {
        pub const sps = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_SPS;

            pub const Flag = enum(c_long) {
                separate_colour_plane = c.V4L2_HEVC_SPS_FLAG_SEPARATE_COLOUR_PLANE,
                scaling_list_enabled = c.V4L2_HEVC_SPS_FLAG_SCALING_LIST_ENABLED,
                amp_enabled = c.V4L2_HEVC_SPS_FLAG_AMP_ENABLED,
                sample_adaptive_offset = c.V4L2_HEVC_SPS_FLAG_SAMPLE_ADAPTIVE_OFFSET,
                pcm_enabled = c.V4L2_HEVC_SPS_FLAG_PCM_ENABLED,
                pcm_loop_filter_disabled = c.V4L2_HEVC_SPS_FLAG_PCM_LOOP_FILTER_DISABLED,
                long_term_ref_pics_present = c.V4L2_HEVC_SPS_FLAG_LONG_TERM_REF_PICS_PRESENT,
                sps_temporal_mvp_enabled = c.V4L2_HEVC_SPS_FLAG_SPS_TEMPORAL_MVP_ENABLED,
                strong_intra_smoothing_enabled = c.V4L2_HEVC_SPS_FLAG_STRONG_INTRA_SMOOTHING_ENABLED,
            };

            pub const Ctrl = extern struct {
                video_parameter_set_id: u8,
                seq_parameter_set_id: u8,
                pic_width_in_luma_samples: u16,
                pic_height_in_luma_samples: u16,
                bit_depth_luma_minus8: u8,
                bit_depth_chroma_minus8: u8,
                log2_max_pic_order_cnt_lsb_minus4: u8,
                sps_max_dec_pic_buffering_minus1: u8,
                sps_max_num_reorder_pics: u8,
                sps_max_latency_increase_plus1: u8,
                log2_min_luma_coding_block_size_minus3: u8,
                log2_diff_max_min_luma_coding_block_size: u8,
                log2_min_luma_transform_block_size_minus2: u8,
                log2_diff_max_min_luma_transform_block_size: u8,
                max_transform_hierarchy_depth_inter: u8,
                max_transform_hierarchy_depth_intra: u8,
                pcm_sample_bit_depth_luma_minus1: u8,
                pcm_sample_bit_depth_chroma_minus1: u8,
                log2_min_pcm_luma_coding_block_size_minus3: u8,
                log2_diff_max_min_pcm_luma_coding_block_size: u8,
                num_short_term_ref_pic_sets: u8,
                num_long_term_ref_pics_sps: u8,
                chroma_format_idc: u8,
                sps_max_sub_layers_minus1: u8,
                reserved: [6]u8,
                flags: u64,
            };
        };

        pub const pps = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_PPS;

            pub const Flag = enum(c_long) {
                dependent_slice_segment_enabled = c.V4L2_HEVC_PPS_FLAG_DEPENDENT_SLICE_SEGMENT_ENABLED,
                output_flag_present = c.V4L2_HEVC_PPS_FLAG_OUTPUT_FLAG_PRESENT,
                sign_data_hiding_enabled = c.V4L2_HEVC_PPS_FLAG_SIGN_DATA_HIDING_ENABLED,
                cabac_init_present = c.V4L2_HEVC_PPS_FLAG_CABAC_INIT_PRESENT,
                constrained_intra_pred = c.V4L2_HEVC_PPS_FLAG_CONSTRAINED_INTRA_PRED,
                transform_skip_enabled = c.V4L2_HEVC_PPS_FLAG_TRANSFORM_SKIP_ENABLED,
                cu_qp_delta_enabled = c.V4L2_HEVC_PPS_FLAG_CU_QP_DELTA_ENABLED,
                pps_slice_chroma_qp_offsets_present = c.V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT,
                weighted_pred = c.V4L2_HEVC_PPS_FLAG_WEIGHTED_PRED,
                weighted_bipred = c.V4L2_HEVC_PPS_FLAG_WEIGHTED_BIPRED,
                transquant_bypass_enabled = c.V4L2_HEVC_PPS_FLAG_TRANSQUANT_BYPASS_ENABLED,
                tiles_enabled = c.V4L2_HEVC_PPS_FLAG_TILES_ENABLED,
                entropy_coding_sync_enabled = c.V4L2_HEVC_PPS_FLAG_ENTROPY_CODING_SYNC_ENABLED,
                loop_filter_across_tiles_enabled = c.V4L2_HEVC_PPS_FLAG_LOOP_FILTER_ACROSS_TILES_ENABLED,
                pps_loop_filter_across_slices_enabled = c.V4L2_HEVC_PPS_FLAG_PPS_LOOP_FILTER_ACROSS_SLICES_ENABLED,
                deblocking_filter_override_enabled = c.V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_OVERRIDE_ENABLED,
                pps_disable_deblocking_filter = c.V4L2_HEVC_PPS_FLAG_PPS_DISABLE_DEBLOCKING_FILTER,
                lists_modification_present = c.V4L2_HEVC_PPS_FLAG_LISTS_MODIFICATION_PRESENT,
                slice_segment_header_extension_present = c.V4L2_HEVC_PPS_FLAG_SLICE_SEGMENT_HEADER_EXTENSION_PRESENT,
                deblocking_filter_control_present = c.V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT,
                uniform_spacing = c.V4L2_HEVC_PPS_FLAG_UNIFORM_SPACING,
            };

            pub const Ctrl = extern struct {
                pic_parameter_set_id: u8,
                num_extra_slice_header_bits: u8,
                num_ref_idx_l0_default_active_minus1: u8,
                num_ref_idx_l1_default_active_minus1: u8,
                init_qp_minus26: i8,
                diff_cu_qp_delta_depth: u8,
                pps_cb_qp_offset: i8,
                pps_cr_qp_offset: i8,
                num_tile_columns_minus1: u8,
                num_tile_rows_minus1: u8,
                column_width_minus1: [20]u8,
                row_height_minus1: [22]u8,
                pps_beta_offset_div2: i8,
                pps_tc_offset_div2: i8,
                log2_parallel_merge_level_minus2: u8,
                reserved: u8,
                flags: u64,
            };
        };

        pub const slice = struct {
            pub const params = struct {
                pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_SLICE_PARAMS;

                pub const Flag = enum(c_long) {
                    slice_sao_luma = c.V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_SAO_LUMA,
                    slice_sao_chroma = c.V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_SAO_CHROMA,
                    slice_temporal_mvp_enabled = c.V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_TEMPORAL_MVP_ENABLED,
                    mvd_l1_zero = c.V4L2_HEVC_SLICE_PARAMS_FLAG_MVD_L1_ZERO,
                    cabac_init = c.V4L2_HEVC_SLICE_PARAMS_FLAG_CABAC_INIT,
                    collocated_from_l0 = c.V4L2_HEVC_SLICE_PARAMS_FLAG_COLLOCATED_FROM_L0,
                    use_integer_mv = c.V4L2_HEVC_SLICE_PARAMS_FLAG_USE_INTEGER_MV,
                    slice_deblocking_filter_disabled = c.V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_DEBLOCKING_FILTER_DISABLED,
                    slice_loop_filter_across_slices_enabled = c.V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_LOOP_FILTER_ACROSS_SLICES_ENABLED,
                    dependent_slice_segment = c.V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT,
                };

                pub const Ctrl = extern struct {
                    bit_size: u32,
                    data_byte_offset: u32,
                    num_entry_point_offsets: u32,
                    nal_unit_type: u8,
                    nuh_temporal_id_plus1: u8,
                    slice_type: u8,
                    colour_plane_id: u8,
                    slice_pic_order_cnt: i32,
                    num_ref_idx_l0_active_minus1: u8,
                    num_ref_idx_l1_active_minus1: u8,
                    collocated_ref_idx: u8,
                    five_minus_max_num_merge_cand: u8,
                    slice_qp_delta: i8,
                    slice_cb_qp_offset: i8,
                    slice_cr_qp_offset: i8,
                    slice_act_y_qp_offset: i8,
                    slice_act_cb_qp_offset: i8,
                    slice_act_cr_qp_offset: i8,
                    slice_beta_offset_div2: i8,
                    slice_tc_offset_div2: i8,
                    pic_struct: u8,
                    reserved0: [3]u8,
                    slice_segment_addr: u32,
                    ref_idx_l0: [16]u8,
                    ref_idx_l1: [16]u8,
                    short_term_ref_pic_set_size: u16,
                    long_term_ref_pic_set_size: u16,
                    pred_weight_table: PredWeightTable,
                    reserved1: [2]u8,
                    flags: u64,
                };
            };

            pub const Type = enum(i32) {
                b = c.V4L2_HEVC_SLICE_TYPE_B,
                p = c.V4L2_HEVC_SLICE_TYPE_P,
                i = c.V4L2_HEVC_SLICE_TYPE_I,
            };
        };

        pub const scaling_matrix = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_SCALING_MATRIX;

            pub const Ctrl = extern struct {
                scaling_list_4x4: [6][16]u8,
                scaling_list_8x8: [6][64]u8,
                scaling_list_16x16: [6][64]u8,
                scaling_list_32x32: [2][64]u8,
                scaling_list_dc_coef_16x16: [6]u8,
                scaling_list_dc_coef_32x32: [2]u8,
            };
        };

        pub const decode = struct {
            pub const params = struct {
                pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_DECODE_PARAMS;

                pub const Flag = enum(i32) {
                    irap_pic = c.V4L2_HEVC_DECODE_PARAM_FLAG_IRAP_PIC,
                    idr_pic = c.V4L2_HEVC_DECODE_PARAM_FLAG_IDR_PIC,
                    no_output_of_prior = c.V4L2_HEVC_DECODE_PARAM_FLAG_NO_OUTPUT_OF_PRIOR,
                };

                pub const Ctrl = extern struct {
                    pic_order_cnt_val: i32,
                    short_term_ref_pic_set_size: u16,
                    long_term_ref_pic_set_size: u16,
                    num_active_dpb_entries: u8,
                    num_poc_st_curr_before: u8,
                    num_poc_st_curr_after: u8,
                    num_poc_lt_curr: u8,
                    poc_st_curr_before: [16]u8,
                    poc_st_curr_after: [16]u8,
                    poc_lt_curr: [16]u8,
                    num_delta_pocs_of_ref_rps_idx: u8,
                    reserved: [3]u8,
                    dpb: [16]dpb.Entry,
                    flags: u64,
                };
            };
        };

        pub const decode_mode = enum(i32) {
            pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_DECODE_MODE;

            slice_based = c.V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
            frame_based = c.V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
        };

        pub const start_code = enum(i32) {
            pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_START_CODE;

            none = c.V4L2_STATELESS_HEVC_START_CODE_NONE,
            annex_b = c.V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
        };

        pub const entry_point_offsets = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS;
        };

        pub const dpb = struct {
            pub const Entry = extern struct {
                timestamp: u64,
                flags: u8,
                field_pic: u8,
                reserved: u16,
                pic_order_cnt_val: i32,
            };
        };

        pub const sei = struct {
            // @TODO
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

            // /**

        };

        pub const PredWeightTable = extern struct {
            delta_luma_weight_l0: [16]i8,
            luma_offset_l0: [16]i8,
            delta_chroma_weight_l0: [16][2]i8,
            chroma_offset_l0: [16][2]i8,
            delta_luma_weight_l1: [16]i8,
            luma_offset_l1: [16]i8,
            delta_chroma_weight_l1: [16][2]i8,
            chroma_offset_l1: [16][2]i8,
            luma_log2_weight_denom: u8,
            delta_chroma_log2_weight_denom: i8,
        };
    };

    pub const vp9 = struct {
        pub const LoopFilter = extern struct {
            ref_deltas: [4]i8,
            mode_deltas: [2]i8,
            level: u8,
            sharpness: u8,
            flags: u8,
            reserved: [7]u8,

            pub const Flag = enum(u32) {
                enabled = c.V4L2_VP9_LOOP_FILTER_FLAG_DELTA_ENABLED,
                update = c.V4L2_VP9_LOOP_FILTER_FLAG_DELTA_UPDATE,
            };
        };

        pub const Quantization = extern struct {
            base_q_idx: u8,
            delta_q_y_dc: i8,
            delta_q_uv_dc: i8,
            delta_q_uv_ac: i8,
            reserved: [4]u8,
        };

        pub const Segmentation = extern struct {
            feature_data: [8][4]i16,
            feature_enabled: [8]u8,
            tree_probs: [7]u8,
            pred_probs: [3]u8,
            flags: u8,
            reserved: [5]u8,

            pub const Flag = enum(i32) {
                enabled = c.V4L2_VP9_SEGMENTATION_FLAG_ENABLED,
                update_map = c.V4L2_VP9_SEGMENTATION_FLAG_UPDATE_MAP,
                temporal_update = c.V4L2_VP9_SEGMENTATION_FLAG_TEMPORAL_UPDATE,
                update_data = c.V4L2_VP9_SEGMENTATION_FLAG_UPDATE_DATA,
                abs_or_delta_update = c.V4L2_VP9_SEGMENTATION_FLAG_ABS_OR_DELTA_UPDATE,
            };

            pub const Level = enum(i32) {
                V4L2_VP9_SEG_LVL_ALT_Q = c.V4L2_VP9_SEG_LVL_ALT_Q,
                V4L2_VP9_SEG_LVL_ALT_L = c.V4L2_VP9_SEG_LVL_ALT_L,
                V4L2_VP9_SEG_LVL_REF_FRAME = c.V4L2_VP9_SEG_LVL_REF_FRAME,
                V4L2_VP9_SEG_LVL_SKIP = c.V4L2_VP9_SEG_LVL_SKIP,
                V4L2_VP9_SEG_LVL_MAX = c.V4L2_VP9_SEG_LVL_MAX,
            };

            pub const isFeatureEnabled = &c.V4L2_AV1_SEGMENT_FEATURE_ENABLED;
            pub const featureEnabledMask = c.V4L2_VP9_SEGMENT_FEATURE_ENABLED_MASK;
        };

        pub const frame = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_VP9_FRAME;

            pub const Flag = enum(i32) {
                key_frame = c.V4L2_VP9_FRAME_FLAG_KEY_FRAME,
                show_frame = c.V4L2_VP9_FRAME_FLAG_SHOW_FRAME,
                error_resilient = c.V4L2_VP9_FRAME_FLAG_ERROR_RESILIENT,
                intra_only = c.V4L2_VP9_FRAME_FLAG_INTRA_ONLY,
                allow_high_prec_mv = c.V4L2_VP9_FRAME_FLAG_ALLOW_HIGH_PREC_MV,
                refresh_frame_ctx = c.V4L2_VP9_FRAME_FLAG_REFRESH_FRAME_CTX,
                parallel_dec_mode = c.V4L2_VP9_FRAME_FLAG_PARALLEL_DEC_MODE,
                x_subsampling = c.V4L2_VP9_FRAME_FLAG_X_SUBSAMPLING,
                y_subsampling = c.V4L2_VP9_FRAME_FLAG_Y_SUBSAMPLING,
                color_range_full_swing = c.V4L2_VP9_FRAME_FLAG_COLOR_RANGE_FULL_SWING,
            };

            pub const Ctrl = extern struct {
                lf: LoopFilter,
                quant: Quantization,
                seg: Segmentation,
                flags: u32,
                compressed_header_size: u16,
                uncompressed_header_size: u16,
                frame_width_minus_1: u16,
                frame_height_minus_1: u16,
                render_width_minus_1: u16,
                render_height_minus_1: u16,
                last_frame_ts: u64,
                golden_frame_ts: u64,
                alt_frame_ts: u64,
                ref_frame_sign_bias: u8,
                reset_frame_context: u8,
                frame_context_idx: u8,
                profile: u8,
                bit_depth: u8,
                interpolation_filter: u8,
                tile_cols_log2: u8,
                tile_rows_log2: u8,
                reference_mode: u8,
                reserved: [7]u8,
            };
        };
        pub const compressed_hdr = struct {
            pub const id: u32 = c.V4L2_CID_STATELESS_VP9_COMPRESSED_HDR;

            pub const MvProbs = extern struct {
                joint: [3]u8,
                sign: [2]u8,
                classes: [2][10]u8,
                class0_bit: [2]u8,
                bits: [2][10]u8,
                class0_fr: [2][2][3]u8,
                fr: [2][3]u8,
                class0_hp: [2]u8,
                hp: [2]u8,
            };

            pub const Ctrl = extern struct {
                tx_mode: u8,
                tx8: [2][1]u8,
                tx16: [2][2]u8,
                tx32: [2][3]u8,
                coef: [4][2][2][6][6][3]u8,
                skip: [3]u8,
                inter_mode: [7][3]u8,
                interp_filter: [4][2]u8,
                is_inter: [4]u8,
                comp_mode: [5]u8,
                single_ref: [5][2]u8,
                comp_ref: [5]u8,
                y_mode: [4][9]u8,
                uv_mode: [10][9]u8,
                partition: [16][3]u8,
                mv: MvProbs,
            };
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

        pub const Primaries = enum(i32) {
            x_low = c.V4L2_HDR10_MASTERING_PRIMARIES_X_LOW,
            x_high = c.V4L2_HDR10_MASTERING_PRIMARIES_X_HIGH,
            y_low = c.V4L2_HDR10_MASTERING_PRIMARIES_Y_LOW,
            y_high = c.V4L2_HDR10_MASTERING_PRIMARIES_Y_HIGH,
        };

        pub const WhitePoint = enum(i32) {
            x_low = c.V4L2_HDR10_MASTERING_WHITE_POINT_X_LOW,
            x_high = c.V4L2_HDR10_MASTERING_WHITE_POINT_X_HIGH,
            y_low = c.V4L2_HDR10_MASTERING_WHITE_POINT_Y_LOW,
            y_high = c.V4L2_HDR10_MASTERING_WHITE_POINT_Y_HIGH,
        };

        pub const Luma = enum(i32) {
            max_luma_low = c.V4L2_HDR10_MASTERING_MAX_LUMA_LOW,
            max_luma_high = c.V4L2_HDR10_MASTERING_MAX_LUMA_HIGH,
            min_luma_low = c.V4L2_HDR10_MASTERING_MIN_LUMA_LOW,
            min_luma_high = c.V4L2_HDR10_MASTERING_MIN_LUMA_HIGH,
        };
    };
};

test "stateless.hevc.sps.Ctrl ABI matches struct_v4l2_ctrl_hevc_sps" {
    const C = c.struct_v4l2_ctrl_hevc_sps;
    const Z = stateless.hevc.sps.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "video_parameter_set_id"), @offsetOf(Z, "video_parameter_set_id"));
    try std.testing.expectEqual(@offsetOf(C, "seq_parameter_set_id"), @offsetOf(Z, "seq_parameter_set_id"));
    try std.testing.expectEqual(@offsetOf(C, "pic_width_in_luma_samples"), @offsetOf(Z, "pic_width_in_luma_samples"));
    try std.testing.expectEqual(@offsetOf(C, "pic_height_in_luma_samples"), @offsetOf(Z, "pic_height_in_luma_samples"));
    try std.testing.expectEqual(@offsetOf(C, "bit_depth_luma_minus8"), @offsetOf(Z, "bit_depth_luma_minus8"));
    try std.testing.expectEqual(@offsetOf(C, "bit_depth_chroma_minus8"), @offsetOf(Z, "bit_depth_chroma_minus8"));
    try std.testing.expectEqual(@offsetOf(C, "log2_max_pic_order_cnt_lsb_minus4"), @offsetOf(Z, "log2_max_pic_order_cnt_lsb_minus4"));
    try std.testing.expectEqual(@offsetOf(C, "sps_max_dec_pic_buffering_minus1"), @offsetOf(Z, "sps_max_dec_pic_buffering_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "sps_max_num_reorder_pics"), @offsetOf(Z, "sps_max_num_reorder_pics"));
    try std.testing.expectEqual(@offsetOf(C, "sps_max_latency_increase_plus1"), @offsetOf(Z, "sps_max_latency_increase_plus1"));
    try std.testing.expectEqual(@offsetOf(C, "log2_min_luma_coding_block_size_minus3"), @offsetOf(Z, "log2_min_luma_coding_block_size_minus3"));
    try std.testing.expectEqual(@offsetOf(C, "log2_diff_max_min_luma_coding_block_size"), @offsetOf(Z, "log2_diff_max_min_luma_coding_block_size"));
    try std.testing.expectEqual(@offsetOf(C, "log2_min_luma_transform_block_size_minus2"), @offsetOf(Z, "log2_min_luma_transform_block_size_minus2"));
    try std.testing.expectEqual(@offsetOf(C, "log2_diff_max_min_luma_transform_block_size"), @offsetOf(Z, "log2_diff_max_min_luma_transform_block_size"));
    try std.testing.expectEqual(@offsetOf(C, "max_transform_hierarchy_depth_inter"), @offsetOf(Z, "max_transform_hierarchy_depth_inter"));
    try std.testing.expectEqual(@offsetOf(C, "max_transform_hierarchy_depth_intra"), @offsetOf(Z, "max_transform_hierarchy_depth_intra"));
    try std.testing.expectEqual(@offsetOf(C, "pcm_sample_bit_depth_luma_minus1"), @offsetOf(Z, "pcm_sample_bit_depth_luma_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "pcm_sample_bit_depth_chroma_minus1"), @offsetOf(Z, "pcm_sample_bit_depth_chroma_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "log2_min_pcm_luma_coding_block_size_minus3"), @offsetOf(Z, "log2_min_pcm_luma_coding_block_size_minus3"));
    try std.testing.expectEqual(@offsetOf(C, "log2_diff_max_min_pcm_luma_coding_block_size"), @offsetOf(Z, "log2_diff_max_min_pcm_luma_coding_block_size"));
    try std.testing.expectEqual(@offsetOf(C, "num_short_term_ref_pic_sets"), @offsetOf(Z, "num_short_term_ref_pic_sets"));
    try std.testing.expectEqual(@offsetOf(C, "num_long_term_ref_pics_sps"), @offsetOf(Z, "num_long_term_ref_pics_sps"));
    try std.testing.expectEqual(@offsetOf(C, "chroma_format_idc"), @offsetOf(Z, "chroma_format_idc"));
    try std.testing.expectEqual(@offsetOf(C, "sps_max_sub_layers_minus1"), @offsetOf(Z, "sps_max_sub_layers_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
}

test "stateless.hevc.pps.Ctrl ABI matches struct_v4l2_ctrl_hevc_pps" {
    const C = c.struct_v4l2_ctrl_hevc_pps;
    const Z = stateless.hevc.pps.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "pic_parameter_set_id"), @offsetOf(Z, "pic_parameter_set_id"));
    try std.testing.expectEqual(@offsetOf(C, "num_extra_slice_header_bits"), @offsetOf(Z, "num_extra_slice_header_bits"));
    try std.testing.expectEqual(@offsetOf(C, "num_ref_idx_l0_default_active_minus1"), @offsetOf(Z, "num_ref_idx_l0_default_active_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "num_ref_idx_l1_default_active_minus1"), @offsetOf(Z, "num_ref_idx_l1_default_active_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "init_qp_minus26"), @offsetOf(Z, "init_qp_minus26"));
    try std.testing.expectEqual(@offsetOf(C, "diff_cu_qp_delta_depth"), @offsetOf(Z, "diff_cu_qp_delta_depth"));
    try std.testing.expectEqual(@offsetOf(C, "pps_cb_qp_offset"), @offsetOf(Z, "pps_cb_qp_offset"));
    try std.testing.expectEqual(@offsetOf(C, "pps_cr_qp_offset"), @offsetOf(Z, "pps_cr_qp_offset"));
    try std.testing.expectEqual(@offsetOf(C, "num_tile_columns_minus1"), @offsetOf(Z, "num_tile_columns_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "num_tile_rows_minus1"), @offsetOf(Z, "num_tile_rows_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "column_width_minus1"), @offsetOf(Z, "column_width_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "row_height_minus1"), @offsetOf(Z, "row_height_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "pps_beta_offset_div2"), @offsetOf(Z, "pps_beta_offset_div2"));
    try std.testing.expectEqual(@offsetOf(C, "pps_tc_offset_div2"), @offsetOf(Z, "pps_tc_offset_div2"));
    try std.testing.expectEqual(@offsetOf(C, "log2_parallel_merge_level_minus2"), @offsetOf(Z, "log2_parallel_merge_level_minus2"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
}

test "stateless.hevc.scaling_matrix.Ctrl ABI matches struct_v4l2_ctrl_hevc_scaling_matrix" {
    const C = c.struct_v4l2_ctrl_hevc_scaling_matrix;
    const Z = stateless.hevc.scaling_matrix.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "scaling_list_4x4"), @offsetOf(Z, "scaling_list_4x4"));
    try std.testing.expectEqual(@offsetOf(C, "scaling_list_8x8"), @offsetOf(Z, "scaling_list_8x8"));
    try std.testing.expectEqual(@offsetOf(C, "scaling_list_16x16"), @offsetOf(Z, "scaling_list_16x16"));
    try std.testing.expectEqual(@offsetOf(C, "scaling_list_32x32"), @offsetOf(Z, "scaling_list_32x32"));
    try std.testing.expectEqual(@offsetOf(C, "scaling_list_dc_coef_16x16"), @offsetOf(Z, "scaling_list_dc_coef_16x16"));
    try std.testing.expectEqual(@offsetOf(C, "scaling_list_dc_coef_32x32"), @offsetOf(Z, "scaling_list_dc_coef_32x32"));
}

test "stateless.hevc.dpb.Entry ABI matches struct_v4l2_hevc_dpb_entry" {
    const C = c.struct_v4l2_hevc_dpb_entry;
    const Z = stateless.hevc.dpb.Entry;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "timestamp"), @offsetOf(Z, "timestamp"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "field_pic"), @offsetOf(Z, "field_pic"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
    try std.testing.expectEqual(@offsetOf(C, "pic_order_cnt_val"), @offsetOf(Z, "pic_order_cnt_val"));
}

test "stateless.hevc.PredWeightTable ABI matches struct_v4l2_hevc_pred_weight_table" {
    const C = c.struct_v4l2_hevc_pred_weight_table;
    const Z = stateless.hevc.PredWeightTable;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "delta_luma_weight_l0"), @offsetOf(Z, "delta_luma_weight_l0"));
    try std.testing.expectEqual(@offsetOf(C, "luma_offset_l0"), @offsetOf(Z, "luma_offset_l0"));
    try std.testing.expectEqual(@offsetOf(C, "delta_chroma_weight_l0"), @offsetOf(Z, "delta_chroma_weight_l0"));
    try std.testing.expectEqual(@offsetOf(C, "chroma_offset_l0"), @offsetOf(Z, "chroma_offset_l0"));
    try std.testing.expectEqual(@offsetOf(C, "delta_luma_weight_l1"), @offsetOf(Z, "delta_luma_weight_l1"));
    try std.testing.expectEqual(@offsetOf(C, "luma_offset_l1"), @offsetOf(Z, "luma_offset_l1"));
    try std.testing.expectEqual(@offsetOf(C, "delta_chroma_weight_l1"), @offsetOf(Z, "delta_chroma_weight_l1"));
    try std.testing.expectEqual(@offsetOf(C, "chroma_offset_l1"), @offsetOf(Z, "chroma_offset_l1"));
    try std.testing.expectEqual(@offsetOf(C, "luma_log2_weight_denom"), @offsetOf(Z, "luma_log2_weight_denom"));
    try std.testing.expectEqual(@offsetOf(C, "delta_chroma_log2_weight_denom"), @offsetOf(Z, "delta_chroma_log2_weight_denom"));
}

test "stateless.hevc.slice.params.Ctrl ABI matches struct_v4l2_ctrl_hevc_slice_params" {
    const C = c.struct_v4l2_ctrl_hevc_slice_params;
    const Z = stateless.hevc.slice.params.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "bit_size"), @offsetOf(Z, "bit_size"));
    try std.testing.expectEqual(@offsetOf(C, "data_byte_offset"), @offsetOf(Z, "data_byte_offset"));
    try std.testing.expectEqual(@offsetOf(C, "num_entry_point_offsets"), @offsetOf(Z, "num_entry_point_offsets"));
    try std.testing.expectEqual(@offsetOf(C, "nal_unit_type"), @offsetOf(Z, "nal_unit_type"));
    try std.testing.expectEqual(@offsetOf(C, "nuh_temporal_id_plus1"), @offsetOf(Z, "nuh_temporal_id_plus1"));
    try std.testing.expectEqual(@offsetOf(C, "slice_type"), @offsetOf(Z, "slice_type"));
    try std.testing.expectEqual(@offsetOf(C, "colour_plane_id"), @offsetOf(Z, "colour_plane_id"));
    try std.testing.expectEqual(@offsetOf(C, "slice_pic_order_cnt"), @offsetOf(Z, "slice_pic_order_cnt"));
    try std.testing.expectEqual(@offsetOf(C, "num_ref_idx_l0_active_minus1"), @offsetOf(Z, "num_ref_idx_l0_active_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "num_ref_idx_l1_active_minus1"), @offsetOf(Z, "num_ref_idx_l1_active_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "collocated_ref_idx"), @offsetOf(Z, "collocated_ref_idx"));
    try std.testing.expectEqual(@offsetOf(C, "five_minus_max_num_merge_cand"), @offsetOf(Z, "five_minus_max_num_merge_cand"));
    try std.testing.expectEqual(@offsetOf(C, "slice_qp_delta"), @offsetOf(Z, "slice_qp_delta"));
    try std.testing.expectEqual(@offsetOf(C, "slice_cb_qp_offset"), @offsetOf(Z, "slice_cb_qp_offset"));
    try std.testing.expectEqual(@offsetOf(C, "slice_cr_qp_offset"), @offsetOf(Z, "slice_cr_qp_offset"));
    try std.testing.expectEqual(@offsetOf(C, "slice_act_y_qp_offset"), @offsetOf(Z, "slice_act_y_qp_offset"));
    try std.testing.expectEqual(@offsetOf(C, "slice_act_cb_qp_offset"), @offsetOf(Z, "slice_act_cb_qp_offset"));
    try std.testing.expectEqual(@offsetOf(C, "slice_act_cr_qp_offset"), @offsetOf(Z, "slice_act_cr_qp_offset"));
    try std.testing.expectEqual(@offsetOf(C, "slice_beta_offset_div2"), @offsetOf(Z, "slice_beta_offset_div2"));
    try std.testing.expectEqual(@offsetOf(C, "slice_tc_offset_div2"), @offsetOf(Z, "slice_tc_offset_div2"));
    try std.testing.expectEqual(@offsetOf(C, "pic_struct"), @offsetOf(Z, "pic_struct"));
    try std.testing.expectEqual(@offsetOf(C, "reserved0"), @offsetOf(Z, "reserved0"));
    try std.testing.expectEqual(@offsetOf(C, "slice_segment_addr"), @offsetOf(Z, "slice_segment_addr"));
    try std.testing.expectEqual(@offsetOf(C, "ref_idx_l0"), @offsetOf(Z, "ref_idx_l0"));
    try std.testing.expectEqual(@offsetOf(C, "ref_idx_l1"), @offsetOf(Z, "ref_idx_l1"));
    try std.testing.expectEqual(@offsetOf(C, "short_term_ref_pic_set_size"), @offsetOf(Z, "short_term_ref_pic_set_size"));
    try std.testing.expectEqual(@offsetOf(C, "long_term_ref_pic_set_size"), @offsetOf(Z, "long_term_ref_pic_set_size"));
    try std.testing.expectEqual(@offsetOf(C, "pred_weight_table"), @offsetOf(Z, "pred_weight_table"));
    try std.testing.expectEqual(@offsetOf(C, "reserved1"), @offsetOf(Z, "reserved1"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
}

test "stateless.hevc.decode.params.Ctrl ABI matches struct_v4l2_ctrl_hevc_decode_params" {
    const C = c.struct_v4l2_ctrl_hevc_decode_params;
    const Z = stateless.hevc.decode.params.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "pic_order_cnt_val"), @offsetOf(Z, "pic_order_cnt_val"));
    try std.testing.expectEqual(@offsetOf(C, "short_term_ref_pic_set_size"), @offsetOf(Z, "short_term_ref_pic_set_size"));
    try std.testing.expectEqual(@offsetOf(C, "long_term_ref_pic_set_size"), @offsetOf(Z, "long_term_ref_pic_set_size"));
    try std.testing.expectEqual(@offsetOf(C, "num_active_dpb_entries"), @offsetOf(Z, "num_active_dpb_entries"));
    try std.testing.expectEqual(@offsetOf(C, "num_poc_st_curr_before"), @offsetOf(Z, "num_poc_st_curr_before"));
    try std.testing.expectEqual(@offsetOf(C, "num_poc_st_curr_after"), @offsetOf(Z, "num_poc_st_curr_after"));
    try std.testing.expectEqual(@offsetOf(C, "num_poc_lt_curr"), @offsetOf(Z, "num_poc_lt_curr"));
    try std.testing.expectEqual(@offsetOf(C, "poc_st_curr_before"), @offsetOf(Z, "poc_st_curr_before"));
    try std.testing.expectEqual(@offsetOf(C, "poc_st_curr_after"), @offsetOf(Z, "poc_st_curr_after"));
    try std.testing.expectEqual(@offsetOf(C, "poc_lt_curr"), @offsetOf(Z, "poc_lt_curr"));
    try std.testing.expectEqual(@offsetOf(C, "num_delta_pocs_of_ref_rps_idx"), @offsetOf(Z, "num_delta_pocs_of_ref_rps_idx"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
    try std.testing.expectEqual(@offsetOf(C, "dpb"), @offsetOf(Z, "dpb"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
}

test "stateless.vp9.LoopFilter ABI matches struct_v4l2_vp9_loop_filter" {
    const C = c.struct_v4l2_vp9_loop_filter;
    const Z = stateless.vp9.LoopFilter;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "ref_deltas"), @offsetOf(Z, "ref_deltas"));
    try std.testing.expectEqual(@offsetOf(C, "mode_deltas"), @offsetOf(Z, "mode_deltas"));
    try std.testing.expectEqual(@offsetOf(C, "level"), @offsetOf(Z, "level"));
    try std.testing.expectEqual(@offsetOf(C, "sharpness"), @offsetOf(Z, "sharpness"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "stateless.vp9.Quantization ABI matches struct_v4l2_vp9_quantization" {
    const C = c.struct_v4l2_vp9_quantization;
    const Z = stateless.vp9.Quantization;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "base_q_idx"), @offsetOf(Z, "base_q_idx"));
    try std.testing.expectEqual(@offsetOf(C, "delta_q_y_dc"), @offsetOf(Z, "delta_q_y_dc"));
    try std.testing.expectEqual(@offsetOf(C, "delta_q_uv_dc"), @offsetOf(Z, "delta_q_uv_dc"));
    try std.testing.expectEqual(@offsetOf(C, "delta_q_uv_ac"), @offsetOf(Z, "delta_q_uv_ac"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "stateless.vp9.Segmentation ABI matches struct_v4l2_vp9_segmentation" {
    const C = c.struct_v4l2_vp9_segmentation;
    const Z = stateless.vp9.Segmentation;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "feature_data"), @offsetOf(Z, "feature_data"));
    try std.testing.expectEqual(@offsetOf(C, "feature_enabled"), @offsetOf(Z, "feature_enabled"));
    try std.testing.expectEqual(@offsetOf(C, "tree_probs"), @offsetOf(Z, "tree_probs"));
    try std.testing.expectEqual(@offsetOf(C, "pred_probs"), @offsetOf(Z, "pred_probs"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "stateless.vp9.frame.Ctrl ABI matches struct_v4l2_ctrl_vp9_frame" {
    const C = c.struct_v4l2_ctrl_vp9_frame;
    const Z = stateless.vp9.frame.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "lf"), @offsetOf(Z, "lf"));
    try std.testing.expectEqual(@offsetOf(C, "quant"), @offsetOf(Z, "quant"));
    try std.testing.expectEqual(@offsetOf(C, "seg"), @offsetOf(Z, "seg"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "compressed_header_size"), @offsetOf(Z, "compressed_header_size"));
    try std.testing.expectEqual(@offsetOf(C, "uncompressed_header_size"), @offsetOf(Z, "uncompressed_header_size"));
    try std.testing.expectEqual(@offsetOf(C, "frame_width_minus_1"), @offsetOf(Z, "frame_width_minus_1"));
    try std.testing.expectEqual(@offsetOf(C, "frame_height_minus_1"), @offsetOf(Z, "frame_height_minus_1"));
    try std.testing.expectEqual(@offsetOf(C, "render_width_minus_1"), @offsetOf(Z, "render_width_minus_1"));
    try std.testing.expectEqual(@offsetOf(C, "render_height_minus_1"), @offsetOf(Z, "render_height_minus_1"));
    try std.testing.expectEqual(@offsetOf(C, "last_frame_ts"), @offsetOf(Z, "last_frame_ts"));
    try std.testing.expectEqual(@offsetOf(C, "golden_frame_ts"), @offsetOf(Z, "golden_frame_ts"));
    try std.testing.expectEqual(@offsetOf(C, "alt_frame_ts"), @offsetOf(Z, "alt_frame_ts"));
    try std.testing.expectEqual(@offsetOf(C, "ref_frame_sign_bias"), @offsetOf(Z, "ref_frame_sign_bias"));
    try std.testing.expectEqual(@offsetOf(C, "reset_frame_context"), @offsetOf(Z, "reset_frame_context"));
    try std.testing.expectEqual(@offsetOf(C, "frame_context_idx"), @offsetOf(Z, "frame_context_idx"));
    try std.testing.expectEqual(@offsetOf(C, "profile"), @offsetOf(Z, "profile"));
    try std.testing.expectEqual(@offsetOf(C, "bit_depth"), @offsetOf(Z, "bit_depth"));
    try std.testing.expectEqual(@offsetOf(C, "interpolation_filter"), @offsetOf(Z, "interpolation_filter"));
    try std.testing.expectEqual(@offsetOf(C, "tile_cols_log2"), @offsetOf(Z, "tile_cols_log2"));
    try std.testing.expectEqual(@offsetOf(C, "tile_rows_log2"), @offsetOf(Z, "tile_rows_log2"));
    try std.testing.expectEqual(@offsetOf(C, "reference_mode"), @offsetOf(Z, "reference_mode"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "stateless.vp9.compressed_hdr.MvProbs ABI matches struct_v4l2_vp9_mv_probs" {
    const C = c.struct_v4l2_vp9_mv_probs;
    const Z = stateless.vp9.compressed_hdr.MvProbs;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "joint"), @offsetOf(Z, "joint"));
    try std.testing.expectEqual(@offsetOf(C, "sign"), @offsetOf(Z, "sign"));
    try std.testing.expectEqual(@offsetOf(C, "classes"), @offsetOf(Z, "classes"));
    try std.testing.expectEqual(@offsetOf(C, "class0_bit"), @offsetOf(Z, "class0_bit"));
    try std.testing.expectEqual(@offsetOf(C, "bits"), @offsetOf(Z, "bits"));
    try std.testing.expectEqual(@offsetOf(C, "class0_fr"), @offsetOf(Z, "class0_fr"));
    try std.testing.expectEqual(@offsetOf(C, "fr"), @offsetOf(Z, "fr"));
    try std.testing.expectEqual(@offsetOf(C, "class0_hp"), @offsetOf(Z, "class0_hp"));
    try std.testing.expectEqual(@offsetOf(C, "hp"), @offsetOf(Z, "hp"));
}

test "stateless.vp9.compressed_hdr.Ctrl ABI matches struct_v4l2_ctrl_vp9_compressed_hdr" {
    const C = c.struct_v4l2_ctrl_vp9_compressed_hdr;
    const Z = stateless.vp9.compressed_hdr.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "tx_mode"), @offsetOf(Z, "tx_mode"));
    try std.testing.expectEqual(@offsetOf(C, "tx8"), @offsetOf(Z, "tx8"));
    try std.testing.expectEqual(@offsetOf(C, "tx16"), @offsetOf(Z, "tx16"));
    try std.testing.expectEqual(@offsetOf(C, "tx32"), @offsetOf(Z, "tx32"));
    try std.testing.expectEqual(@offsetOf(C, "coef"), @offsetOf(Z, "coef"));
    try std.testing.expectEqual(@offsetOf(C, "skip"), @offsetOf(Z, "skip"));
    try std.testing.expectEqual(@offsetOf(C, "inter_mode"), @offsetOf(Z, "inter_mode"));
    try std.testing.expectEqual(@offsetOf(C, "interp_filter"), @offsetOf(Z, "interp_filter"));
    try std.testing.expectEqual(@offsetOf(C, "is_inter"), @offsetOf(Z, "is_inter"));
    try std.testing.expectEqual(@offsetOf(C, "comp_mode"), @offsetOf(Z, "comp_mode"));
    try std.testing.expectEqual(@offsetOf(C, "single_ref"), @offsetOf(Z, "single_ref"));
    try std.testing.expectEqual(@offsetOf(C, "comp_ref"), @offsetOf(Z, "comp_ref"));
    try std.testing.expectEqual(@offsetOf(C, "y_mode"), @offsetOf(Z, "y_mode"));
    try std.testing.expectEqual(@offsetOf(C, "uv_mode"), @offsetOf(Z, "uv_mode"));
    try std.testing.expectEqual(@offsetOf(C, "partition"), @offsetOf(Z, "partition"));
    try std.testing.expectEqual(@offsetOf(C, "mv"), @offsetOf(Z, "mv"));
}

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

test "stateless.h264.sps ABI matches struct_v4l2_ctrl_h264_sps" {
    const C = c.struct_v4l2_ctrl_h264_sps;
    const Z = stateless.h264.sps;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "profile_idc"), @offsetOf(Z, "profile_idc"));
    try std.testing.expectEqual(@offsetOf(C, "constraint_set_flags"), @offsetOf(Z, "constraint_set_flags"));
    try std.testing.expectEqual(@offsetOf(C, "level_idc"), @offsetOf(Z, "level_idc"));
    try std.testing.expectEqual(@offsetOf(C, "seq_parameter_set_id"), @offsetOf(Z, "seq_parameter_set_id"));
    try std.testing.expectEqual(@offsetOf(C, "chroma_format_idc"), @offsetOf(Z, "chroma_format_idc"));
    try std.testing.expectEqual(@offsetOf(C, "bit_depth_luma_minus8"), @offsetOf(Z, "bit_depth_luma_minus8"));
    try std.testing.expectEqual(@offsetOf(C, "bit_depth_chroma_minus8"), @offsetOf(Z, "bit_depth_chroma_minus8"));
    try std.testing.expectEqual(@offsetOf(C, "log2_max_frame_num_minus4"), @offsetOf(Z, "log2_max_frame_num_minus4"));
    try std.testing.expectEqual(@offsetOf(C, "pic_order_cnt_type"), @offsetOf(Z, "pic_order_cnt_type"));
    try std.testing.expectEqual(@offsetOf(C, "log2_max_pic_order_cnt_lsb_minus4"), @offsetOf(Z, "log2_max_pic_order_cnt_lsb_minus4"));
    try std.testing.expectEqual(@offsetOf(C, "max_num_ref_frames"), @offsetOf(Z, "max_num_ref_frames"));
    try std.testing.expectEqual(@offsetOf(C, "num_ref_frames_in_pic_order_cnt_cycle"), @offsetOf(Z, "num_ref_frames_in_pic_order_cnt_cycle"));
    try std.testing.expectEqual(@offsetOf(C, "offset_for_ref_frame"), @offsetOf(Z, "offset_for_ref_frame"));
    try std.testing.expectEqual(@offsetOf(C, "offset_for_non_ref_pic"), @offsetOf(Z, "offset_for_non_ref_pic"));
    try std.testing.expectEqual(@offsetOf(C, "offset_for_top_to_bottom_field"), @offsetOf(Z, "offset_for_top_to_bottom_field"));
    try std.testing.expectEqual(@offsetOf(C, "pic_width_in_mbs_minus1"), @offsetOf(Z, "pic_width_in_mbs_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "pic_height_in_map_units_minus1"), @offsetOf(Z, "pic_height_in_map_units_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
}

test "stateless.h264.pps ABI matches struct_v4l2_ctrl_h264_pps" {
    const C = c.struct_v4l2_ctrl_h264_pps;
    const Z = stateless.h264.pps;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "pic_parameter_set_id"), @offsetOf(Z, "pic_parameter_set_id"));
    try std.testing.expectEqual(@offsetOf(C, "seq_parameter_set_id"), @offsetOf(Z, "seq_parameter_set_id"));
    try std.testing.expectEqual(@offsetOf(C, "num_slice_groups_minus1"), @offsetOf(Z, "num_slice_groups_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "num_ref_idx_l0_default_active_minus1"), @offsetOf(Z, "num_ref_idx_l0_default_active_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "num_ref_idx_l1_default_active_minus1"), @offsetOf(Z, "num_ref_idx_l1_default_active_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "weighted_bipred_idc"), @offsetOf(Z, "weighted_bipred_idc"));
    try std.testing.expectEqual(@offsetOf(C, "pic_init_qp_minus26"), @offsetOf(Z, "pic_init_qp_minus26"));
    try std.testing.expectEqual(@offsetOf(C, "pic_init_qs_minus26"), @offsetOf(Z, "pic_init_qs_minus26"));
    try std.testing.expectEqual(@offsetOf(C, "chroma_qp_index_offset"), @offsetOf(Z, "chroma_qp_index_offset"));
    try std.testing.expectEqual(@offsetOf(C, "second_chroma_qp_index_offset"), @offsetOf(Z, "second_chroma_qp_index_offset"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
}

test "stateless.h264.ScalingMatrix ABI matches struct_v4l2_ctrl_h264_scaling_matrix" {
    const C = c.struct_v4l2_ctrl_h264_scaling_matrix;
    const Z = stateless.h264.ScalingMatrix;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "scaling_list_4x4"), @offsetOf(Z, "scaling_list_4x4"));
    try std.testing.expectEqual(@offsetOf(C, "scaling_list_8x8"), @offsetOf(Z, "scaling_list_8x8"));
}

test "stateless.h264.WeightFactors ABI matches struct_v4l2_h264_weight_factors" {
    const C = c.struct_v4l2_h264_weight_factors;
    const Z = stateless.h264.WeightFactors;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "luma_weight"), @offsetOf(Z, "luma_weight"));
    try std.testing.expectEqual(@offsetOf(C, "luma_offset"), @offsetOf(Z, "luma_offset"));
    try std.testing.expectEqual(@offsetOf(C, "chroma_weight"), @offsetOf(Z, "chroma_weight"));
    try std.testing.expectEqual(@offsetOf(C, "chroma_offset"), @offsetOf(Z, "chroma_offset"));
}

test "stateless.h264.pred_weights ABI matches struct_v4l2_ctrl_h264_pred_weights" {
    const C = c.struct_v4l2_ctrl_h264_pred_weights;
    const Z = stateless.h264.pred_weights;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "luma_log2_weight_denom"), @offsetOf(Z, "luma_log2_weight_denom"));
    try std.testing.expectEqual(@offsetOf(C, "chroma_log2_weight_denom"), @offsetOf(Z, "chroma_log2_weight_denom"));
    try std.testing.expectEqual(@offsetOf(C, "weight_factors"), @offsetOf(Z, "weight_factors"));
}

test "stateless.h264.Reference ABI matches struct_v4l2_h264_reference" {
    const C = c.struct_v4l2_h264_reference;
    const Z = stateless.h264.Reference;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "fields"), @offsetOf(Z, "fields"));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
}

test "stateless.h264.slice_params ABI matches struct_v4l2_ctrl_h264_slice_params" {
    const C = c.struct_v4l2_ctrl_h264_slice_params;
    const Z = stateless.h264.slice_params;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "header_bit_size"), @offsetOf(Z, "header_bit_size"));
    try std.testing.expectEqual(@offsetOf(C, "first_mb_in_slice"), @offsetOf(Z, "first_mb_in_slice"));
    try std.testing.expectEqual(@offsetOf(C, "slice_type"), @offsetOf(Z, "slice_type"));
    try std.testing.expectEqual(@offsetOf(C, "colour_plane_id"), @offsetOf(Z, "colour_plane_id"));
    try std.testing.expectEqual(@offsetOf(C, "redundant_pic_cnt"), @offsetOf(Z, "redundant_pic_cnt"));
    try std.testing.expectEqual(@offsetOf(C, "cabac_init_idc"), @offsetOf(Z, "cabac_init_idc"));
    try std.testing.expectEqual(@offsetOf(C, "slice_qp_delta"), @offsetOf(Z, "slice_qp_delta"));
    try std.testing.expectEqual(@offsetOf(C, "slice_qs_delta"), @offsetOf(Z, "slice_qs_delta"));
    try std.testing.expectEqual(@offsetOf(C, "disable_deblocking_filter_idc"), @offsetOf(Z, "disable_deblocking_filter_idc"));
    try std.testing.expectEqual(@offsetOf(C, "slice_alpha_c0_offset_div2"), @offsetOf(Z, "slice_alpha_c0_offset_div2"));
    try std.testing.expectEqual(@offsetOf(C, "slice_beta_offset_div2"), @offsetOf(Z, "slice_beta_offset_div2"));
    try std.testing.expectEqual(@offsetOf(C, "num_ref_idx_l0_active_minus1"), @offsetOf(Z, "num_ref_idx_l0_active_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "num_ref_idx_l1_active_minus1"), @offsetOf(Z, "num_ref_idx_l1_active_minus1"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
    try std.testing.expectEqual(@offsetOf(C, "ref_pic_list0"), @offsetOf(Z, "ref_pic_list0"));
    try std.testing.expectEqual(@offsetOf(C, "ref_pic_list1"), @offsetOf(Z, "ref_pic_list1"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
}

test "stateless.h264.dpb.Entry ABI matches struct_v4l2_h264_dpb_entry" {
    const C = c.struct_v4l2_h264_dpb_entry;
    const Z = stateless.h264.dpb.Entry;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "reference_ts"), @offsetOf(Z, "reference_ts"));
    try std.testing.expectEqual(@offsetOf(C, "pic_num"), @offsetOf(Z, "pic_num"));
    try std.testing.expectEqual(@offsetOf(C, "frame_num"), @offsetOf(Z, "frame_num"));
    try std.testing.expectEqual(@offsetOf(C, "fields"), @offsetOf(Z, "fields"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
    try std.testing.expectEqual(@offsetOf(C, "top_field_order_cnt"), @offsetOf(Z, "top_field_order_cnt"));
    try std.testing.expectEqual(@offsetOf(C, "bottom_field_order_cnt"), @offsetOf(Z, "bottom_field_order_cnt"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
}

test "stateless.vp8.Segment ABI matches struct_v4l2_vp8_segment" {
    const C = c.struct_v4l2_vp8_segment;
    const Z = stateless.vp8.Segment;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "quant_update"), @offsetOf(Z, "quant_update"));
    try std.testing.expectEqual(@offsetOf(C, "lf_update"), @offsetOf(Z, "lf_update"));
    try std.testing.expectEqual(@offsetOf(C, "segment_probs"), @offsetOf(Z, "segment_probs"));
    try std.testing.expectEqual(@offsetOf(C, "padding"), @offsetOf(Z, "padding"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
}

test "stateless.vp8.LoopFilter ABI matches struct_v4l2_vp8_loop_filter" {
    const C = c.struct_v4l2_vp8_loop_filter;
    const Z = stateless.vp8.LoopFilter;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "ref_frm_delta"), @offsetOf(Z, "ref_frm_delta"));
    try std.testing.expectEqual(@offsetOf(C, "mb_mode_delta"), @offsetOf(Z, "mb_mode_delta"));
    try std.testing.expectEqual(@offsetOf(C, "sharpness_level"), @offsetOf(Z, "sharpness_level"));
    try std.testing.expectEqual(@offsetOf(C, "level"), @offsetOf(Z, "level"));
    try std.testing.expectEqual(@offsetOf(C, "padding"), @offsetOf(Z, "padding"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
}

test "stateless.vp8.Quantization ABI matches struct_v4l2_vp8_quantization" {
    const C = c.struct_v4l2_vp8_quantization;
    const Z = stateless.vp8.Quantization;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "y_ac_qi"), @offsetOf(Z, "y_ac_qi"));
    try std.testing.expectEqual(@offsetOf(C, "y_dc_delta"), @offsetOf(Z, "y_dc_delta"));
    try std.testing.expectEqual(@offsetOf(C, "y2_dc_delta"), @offsetOf(Z, "y2_dc_delta"));
    try std.testing.expectEqual(@offsetOf(C, "y2_ac_delta"), @offsetOf(Z, "y2_ac_delta"));
    try std.testing.expectEqual(@offsetOf(C, "uv_dc_delta"), @offsetOf(Z, "uv_dc_delta"));
    try std.testing.expectEqual(@offsetOf(C, "uv_ac_delta"), @offsetOf(Z, "uv_ac_delta"));
    try std.testing.expectEqual(@offsetOf(C, "padding"), @offsetOf(Z, "padding"));
}

test "stateless.vp8.Entropy ABI matches struct_v4l2_vp8_entropy" {
    const C = c.struct_v4l2_vp8_entropy;
    const Z = stateless.vp8.Entropy;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "coeff_probs"), @offsetOf(Z, "coeff_probs"));
    try std.testing.expectEqual(@offsetOf(C, "y_mode_probs"), @offsetOf(Z, "y_mode_probs"));
    try std.testing.expectEqual(@offsetOf(C, "uv_mode_probs"), @offsetOf(Z, "uv_mode_probs"));
    try std.testing.expectEqual(@offsetOf(C, "mv_probs"), @offsetOf(Z, "mv_probs"));
    try std.testing.expectEqual(@offsetOf(C, "padding"), @offsetOf(Z, "padding"));
}

test "stateless.vp8.EntropyCoderState ABI matches struct_v4l2_vp8_entropy_coder_state" {
    const C = c.struct_v4l2_vp8_entropy_coder_state;
    const Z = stateless.vp8.EntropyCoderState;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "range"), @offsetOf(Z, "range"));
    try std.testing.expectEqual(@offsetOf(C, "value"), @offsetOf(Z, "value"));
    try std.testing.expectEqual(@offsetOf(C, "bit_count"), @offsetOf(Z, "bit_count"));
    try std.testing.expectEqual(@offsetOf(C, "padding"), @offsetOf(Z, "padding"));
}

test "stateless.vp8.Frame ABI matches struct_v4l2_ctrl_vp8_frame" {
    const C = c.struct_v4l2_ctrl_vp8_frame;
    const Z = stateless.vp8.Frame;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "segment"), @offsetOf(Z, "segment"));
    try std.testing.expectEqual(@offsetOf(C, "lf"), @offsetOf(Z, "lf"));
    try std.testing.expectEqual(@offsetOf(C, "quant"), @offsetOf(Z, "quant"));
    try std.testing.expectEqual(@offsetOf(C, "entropy"), @offsetOf(Z, "entropy"));
    try std.testing.expectEqual(@offsetOf(C, "coder_state"), @offsetOf(Z, "coder_state"));
    try std.testing.expectEqual(@offsetOf(C, "width"), @offsetOf(Z, "width"));
    try std.testing.expectEqual(@offsetOf(C, "height"), @offsetOf(Z, "height"));
    try std.testing.expectEqual(@offsetOf(C, "horizontal_scale"), @offsetOf(Z, "horizontal_scale"));
    try std.testing.expectEqual(@offsetOf(C, "vertical_scale"), @offsetOf(Z, "vertical_scale"));
    try std.testing.expectEqual(@offsetOf(C, "version"), @offsetOf(Z, "version"));
    try std.testing.expectEqual(@offsetOf(C, "prob_skip_false"), @offsetOf(Z, "prob_skip_false"));
    try std.testing.expectEqual(@offsetOf(C, "prob_intra"), @offsetOf(Z, "prob_intra"));
    try std.testing.expectEqual(@offsetOf(C, "prob_last"), @offsetOf(Z, "prob_last"));
    try std.testing.expectEqual(@offsetOf(C, "prob_gf"), @offsetOf(Z, "prob_gf"));
    try std.testing.expectEqual(@offsetOf(C, "num_dct_parts"), @offsetOf(Z, "num_dct_parts"));
    try std.testing.expectEqual(@offsetOf(C, "first_part_size"), @offsetOf(Z, "first_part_size"));
    try std.testing.expectEqual(@offsetOf(C, "first_part_header_bits"), @offsetOf(Z, "first_part_header_bits"));
    try std.testing.expectEqual(@offsetOf(C, "dct_part_sizes"), @offsetOf(Z, "dct_part_sizes"));
    try std.testing.expectEqual(@offsetOf(C, "last_frame_ts"), @offsetOf(Z, "last_frame_ts"));
    try std.testing.expectEqual(@offsetOf(C, "golden_frame_ts"), @offsetOf(Z, "golden_frame_ts"));
    try std.testing.expectEqual(@offsetOf(C, "alt_frame_ts"), @offsetOf(Z, "alt_frame_ts"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
}

test "stateless.mpeg2.sequence.Ctrl ABI matches struct_v4l2_ctrl_mpeg2_sequence" {
    const C = c.struct_v4l2_ctrl_mpeg2_sequence;
    const Z = stateless.mpeg2.sequence.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "horizontal_size"), @offsetOf(Z, "horizontal_size"));
    try std.testing.expectEqual(@offsetOf(C, "vertical_size"), @offsetOf(Z, "vertical_size"));
    try std.testing.expectEqual(@offsetOf(C, "vbv_buffer_size"), @offsetOf(Z, "vbv_buffer_size"));
    try std.testing.expectEqual(@offsetOf(C, "profile_and_level_indication"), @offsetOf(Z, "profile_and_level_indication"));
    try std.testing.expectEqual(@offsetOf(C, "chroma_format"), @offsetOf(Z, "chroma_format"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
}

test "stateless.mpeg2.picture.Ctrl ABI matches struct_v4l2_ctrl_mpeg2_picture" {
    const C = c.struct_v4l2_ctrl_mpeg2_picture;
    const Z = stateless.mpeg2.picture.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "backward_ref_ts"), @offsetOf(Z, "backward_ref_ts"));
    try std.testing.expectEqual(@offsetOf(C, "forward_ref_ts"), @offsetOf(Z, "forward_ref_ts"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "f_code"), @offsetOf(Z, "f_code"));
    try std.testing.expectEqual(@offsetOf(C, "picture_coding_type"), @offsetOf(Z, "picture_coding_type"));
    try std.testing.expectEqual(@offsetOf(C, "picture_structure"), @offsetOf(Z, "picture_structure"));
    try std.testing.expectEqual(@offsetOf(C, "intra_dc_precision"), @offsetOf(Z, "intra_dc_precision"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "stateless.mpeg2.quantisation.Ctrl ABI matches struct_v4l2_ctrl_mpeg2_quantisation" {
    const C = c.struct_v4l2_ctrl_mpeg2_quantisation;
    const Z = stateless.mpeg2.quantisation.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "intra_quantiser_matrix"), @offsetOf(Z, "intra_quantiser_matrix"));
    try std.testing.expectEqual(@offsetOf(C, "non_intra_quantiser_matrix"), @offsetOf(Z, "non_intra_quantiser_matrix"));
    try std.testing.expectEqual(@offsetOf(C, "chroma_intra_quantiser_matrix"), @offsetOf(Z, "chroma_intra_quantiser_matrix"));
    try std.testing.expectEqual(@offsetOf(C, "chroma_non_intra_quantiser_matrix"), @offsetOf(Z, "chroma_non_intra_quantiser_matrix"));
}
