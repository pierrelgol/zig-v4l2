const std = @import("std");
const bindings = @import("bindings");

pub const Control = struct {
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

    pub const Brightness = struct {
        pub const id: u32 = bindings.V4L2_CID_BRIGHTNESS;
    };

    pub const Contrast = struct {
        pub const id: u32 = bindings.V4L2_CID_CONTRAST;
    };

    pub const Saturation = struct {
        pub const id: u32 = bindings.V4L2_CID_SATURATION;
    };

    pub const Hue = struct {
        pub const id: u32 = bindings.V4L2_CID_HUE;
    };

    pub const AudioVolume = struct {
        pub const id: u32 = bindings.V4L2_CID_AUDIO_VOLUME;
    };

    pub const AudioBalance = struct {
        pub const id: u32 = bindings.V4L2_CID_AUDIO_BALANCE;
    };

    pub const AudioBass = struct {
        pub const id: u32 = bindings.V4L2_CID_AUDIO_BASS;
    };

    pub const AudioTreble = struct {
        pub const id: u32 = bindings.V4L2_CID_AUDIO_TREBLE;
    };

    pub const AudioMute = struct {
        pub const id: u32 = bindings.V4L2_CID_AUDIO_MUTE;
    };

    pub const AudioLoudness = struct {
        pub const id: u32 = bindings.V4L2_CID_AUDIO_LOUDNESS;
    };

    pub const BlackLevel = struct {
        pub const id: u32 = bindings.V4L2_CID_BLACK_LEVEL;
    };

    pub const AutoWhiteBalance = struct {
        pub const id: u32 = bindings.V4L2_CID_AUTO_WHITE_BALANCE;
    };

    pub const DoWhiteBalance = struct {
        pub const id: u32 = bindings.V4L2_CID_DO_WHITE_BALANCE;
    };

    pub const RedBalance = struct {
        pub const id: u32 = bindings.V4L2_CID_RED_BALANCE;
    };

    pub const BlueBalance = struct {
        pub const id: u32 = bindings.V4L2_CID_BLUE_BALANCE;
    };

    pub const Gamma = struct {
        pub const id: u32 = bindings.V4L2_CID_GAMMA;
    };

    pub const Whiteness = struct {
        pub const id: u32 = bindings.V4L2_CID_WHITENESS;
    };

    pub const Exposure = struct {
        pub const id: u32 = bindings.V4L2_CID_EXPOSURE;
    };

    pub const Autogain = struct {
        pub const id: u32 = bindings.V4L2_CID_AUTOGAIN;
    };

    pub const Gain = struct {
        pub const id: u32 = bindings.V4L2_CID_GAIN;
    };

    pub const HFlip = struct {
        pub const id: u32 = bindings.V4L2_CID_HFLIP;
    };

    pub const VFlip = struct {
        pub const id: u32 = bindings.V4L2_CID_VFLIP;
    };

    pub const PowerLineFrequency = struct {
        pub const id: u32 = bindings.V4L2_CID_POWER_LINE_FREQUENCY;

        pub const Value = enum(i32) {
            disabled = bindings.V4L2_CID_POWER_LINE_FREQUENCY_DISABLED,
            hz_50 = bindings.V4L2_CID_POWER_LINE_FREQUENCY_50HZ,
            hz_60 = bindings.V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
            auto = bindings.V4L2_CID_POWER_LINE_FREQUENCY_AUTO,
        };
    };

    pub const Autobrightness = struct {
        pub const id: u32 = bindings.V4L2_CID_AUTOBRIGHTNESS;
    };

    pub const BandStopFilter = struct {
        pub const id: u32 = bindings.V4L2_CID_BAND_STOP_FILTER;
    };

    pub const Rotate = struct {
        pub const id: u32 = bindings.V4L2_CID_ROTATE;
    };

    pub const BgColor = struct {
        pub const id: u32 = bindings.V4L2_CID_BG_COLOR;
    };

    pub const ChromaGain = struct {
        pub const id: u32 = bindings.V4L2_CID_CHROMA_GAIN;
    };

    pub const Illuminators1 = struct {
        pub const id: u32 = bindings.V4L2_CID_ILLUMINATORS_1;
    };

    pub const Illuminators2 = struct {
        pub const id: u32 = bindings.V4L2_CID_ILLUMINATORS_2;
    };

    pub const MinBuffersForCapture = struct {
        pub const id: u32 = bindings.V4L2_CID_MIN_BUFFERS_FOR_CAPTURE;
    };

    pub const MinBuffersForOutput = struct {
        pub const id: u32 = bindings.V4L2_CID_MIN_BUFFERS_FOR_OUTPUT;
    };

    pub const AlphaComponent = struct {
        pub const id: u32 = bindings.V4L2_CID_ALPHA_COMPONENT;
    };

    pub const ColorFx = struct {
        pub const id: u32 = bindings.V4L2_CID_COLORFX;
        pub const cbcr_id: u32 = bindings.V4L2_CID_COLORFX_CBCR;
        pub const rgb_id: u32 = bindings.V4L2_CID_COLORFX_RGB;

        pub const Value = enum(i32) {
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
    };

    pub const User = struct {
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

    pub const Codec = struct {
        pub const base: u32 = bindings.V4L2_CID_CODEC_BASE;
        pub const class: u32 = bindings.V4L2_CID_CODEC_CLASS;
    };

    pub const Mpeg = struct {
        pub const Stream = struct {
            pub const Type = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_STREAM_TYPE;

                pub const Value = enum(i32) {
                    mpeg2_ps = bindings.V4L2_MPEG_STREAM_TYPE_MPEG2_PS,
                    mpeg2_ts = bindings.V4L2_MPEG_STREAM_TYPE_MPEG2_TS,
                    mpeg1_ss = bindings.V4L2_MPEG_STREAM_TYPE_MPEG1_SS,
                    mpeg2_dvd = bindings.V4L2_MPEG_STREAM_TYPE_MPEG2_DVD,
                    mpeg1_vcd = bindings.V4L2_MPEG_STREAM_TYPE_MPEG1_VCD,
                    mpeg2_svcd = bindings.V4L2_MPEG_STREAM_TYPE_MPEG2_SVCD,
                };
            };

            pub const PidPmt = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_STREAM_PID_PMT;
            };
            pub const PidAudio = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_STREAM_PID_AUDIO;
            };
            pub const PidVideo = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_STREAM_PID_VIDEO;
            };
            pub const PidPcr = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_STREAM_PID_PCR;
            };
            pub const PesIdAudio = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_STREAM_PES_ID_AUDIO;
            };
            pub const PesIdVideo = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_STREAM_PES_ID_VIDEO;
            };

            pub const VbiFmt = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_STREAM_VBI_FMT;

                pub const Value = enum(i32) {
                    none = bindings.V4L2_MPEG_STREAM_VBI_FMT_NONE,
                    ivtv = bindings.V4L2_MPEG_STREAM_VBI_FMT_IVTV,
                };
            };
        };

        pub const Audio = struct {
            pub const SamplingFreq = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_SAMPLING_FREQ;

                pub const Value = enum(i32) {
                    freq_44100 = bindings.V4L2_MPEG_AUDIO_SAMPLING_FREQ_44100,
                    freq_48000 = bindings.V4L2_MPEG_AUDIO_SAMPLING_FREQ_48000,
                    freq_32000 = bindings.V4L2_MPEG_AUDIO_SAMPLING_FREQ_32000,
                };
            };

            pub const Encoding = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_ENCODING;

                pub const Value = enum(i32) {
                    layer_1 = bindings.V4L2_MPEG_AUDIO_ENCODING_LAYER_1,
                    layer_2 = bindings.V4L2_MPEG_AUDIO_ENCODING_LAYER_2,
                    layer_3 = bindings.V4L2_MPEG_AUDIO_ENCODING_LAYER_3,
                    aac = bindings.V4L2_MPEG_AUDIO_ENCODING_AAC,
                    ac3 = bindings.V4L2_MPEG_AUDIO_ENCODING_AC3,
                };
            };

            pub const L1 = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_L1_BITRATE;

                pub const Value = enum(i32) {
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
            };

            pub const L2 = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_L2_BITRATE;

                pub const Value = enum(i32) {
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
            };

            pub const L3 = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_L3_BITRATE;

                pub const Value = enum(i32) {
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
            };

            pub const Mode = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_MODE;

                pub const Value = enum(i32) {
                    stereo = bindings.V4L2_MPEG_AUDIO_MODE_STEREO,
                    joint_stereo = bindings.V4L2_MPEG_AUDIO_MODE_JOINT_STEREO,
                    dual = bindings.V4L2_MPEG_AUDIO_MODE_DUAL,
                    mono = bindings.V4L2_MPEG_AUDIO_MODE_MONO,
                };
            };

            pub const ModeExtension = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_MODE_EXTENSION;

                pub const Value = enum(i32) {
                    bound_4 = bindings.V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_4,
                    bound_8 = bindings.V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_8,
                    bound_12 = bindings.V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_12,
                    bound_16 = bindings.V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_16,
                };
            };

            pub const Emphasis = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_EMPHASIS;

                pub const Value = enum(i32) {
                    emphasis_none = bindings.V4L2_MPEG_AUDIO_EMPHASIS_NONE,
                    emphasis_50_div_15_Us = bindings.V4L2_MPEG_AUDIO_EMPHASIS_50_DIV_15_uS,
                    emphasis_ccitt_j17 = bindings.V4L2_MPEG_AUDIO_EMPHASIS_CCITT_J17,
                };
            };

            pub const Crc = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_CRC;

                pub const Value = enum(i32) {
                    none = bindings.V4L2_MPEG_AUDIO_CRC_NONE,
                    crc16 = bindings.V4L2_MPEG_AUDIO_CRC_CRC16,
                };
            };

            pub const Mute = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_MUTE;
            };

            pub const AAC = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_AAC_BITRATE;
            };

            pub const AC3 = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_AC3_BITRATE;

                pub const Value = enum(i32) {
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
            };

            pub const Dec = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_DEC_PLAYBACK;

                pub const Value = enum(i32) {
                    playback_auto = bindings.V4L2_MPEG_AUDIO_DEC_PLAYBACK_AUTO,
                    playback_stereo = bindings.V4L2_MPEG_AUDIO_DEC_PLAYBACK_STEREO,
                    playback_left = bindings.V4L2_MPEG_AUDIO_DEC_PLAYBACK_LEFT,
                    playback_right = bindings.V4L2_MPEG_AUDIO_DEC_PLAYBACK_RIGHT,
                    playback_mono = bindings.V4L2_MPEG_AUDIO_DEC_PLAYBACK_MONO,
                    playback_swapped_stereo = bindings.V4L2_MPEG_AUDIO_DEC_PLAYBACK_SWAPPED_STEREO,
                };
            };

            pub const MultilingualDec = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_AUDIO_DEC_MULTILINGUAL_PLAYBACK;
            };
        };

        pub const Video = struct {
            pub const Encoding = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_ENCODING;

                pub const Value = enum(i32) {
                    mpeg_1 = bindings.V4L2_MPEG_VIDEO_ENCODING_MPEG_1,
                    mpeg_2 = bindings.V4L2_MPEG_VIDEO_ENCODING_MPEG_2,
                    mpeg_4_avc = bindings.V4L2_MPEG_VIDEO_ENCODING_MPEG_4_AVC,
                };
            };

            pub const Aspect = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_ASPECT;

                pub const Value = enum(i32) {
                    V4L2_MPEG_VIDEO_ASPECT_1x1 = bindings.V4L2_MPEG_VIDEO_ASPECT_1x1,
                    V4L2_MPEG_VIDEO_ASPECT_4x3 = bindings.V4L2_MPEG_VIDEO_ASPECT_4x3,
                    V4L2_MPEG_VIDEO_ASPECT_16x9 = bindings.V4L2_MPEG_VIDEO_ASPECT_16x9,
                    V4L2_MPEG_VIDEO_ASPECT_221x100 = bindings.V4L2_MPEG_VIDEO_ASPECT_221x100,
                };
            };

            pub const BFrames = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_B_FRAMES;
            };

            pub const GopSize = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_GOP_SIZE;
            };

            pub const GopClosure = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_GOP_CLOSURE;
            };

            pub const PullDown = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_PULLDOWN;
            };

            pub const BitrateMode = struct {
                pub const id: u32 = bindings.V4L2_CID_MPEG_VIDEO_BITRATE_MODE;

                pub const Value = enum(i32) {
                    V4L2_MPEG_VIDEO_BITRATE_MODE_VBR = bindings.V4L2_MPEG_VIDEO_BITRATE_MODE_VBR,
                    V4L2_MPEG_VIDEO_BITRATE_MODE_CBR = bindings.V4L2_MPEG_VIDEO_BITRATE_MODE_CBR,
                    V4L2_MPEG_VIDEO_BITRATE_MODE_CQ = bindings.V4L2_MPEG_VIDEO_BITRATE_MODE_CQ,
                };
            };
        };
    };
};
