const c = @import("bindings");
const std = @import("std");

comptime {
    std.testing.refAllDecls(@This());
}

pub const user = struct {
    pub const base: u32 = c.V4L2_CID_USER_BASE;
    pub const class: u32 = c.V4L2_CID_USER_CLASS;
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
