const std = @import("std");

const c = @import("bindings");

pub const vp8 = @This();

comptime {
    std.testing.refAllDecls(@This());
}

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

pub const frame = struct {
    pub const Flag = enum(i32) {
        key_frame = c.V4L2_VP8_FRAME_FLAG_KEY_FRAME,
        experimental = c.V4L2_VP8_FRAME_FLAG_EXPERIMENTAL,
        show_frame = c.V4L2_VP8_FRAME_FLAG_SHOW_FRAME,
        mb_no_skip_coeff = c.V4L2_VP8_FRAME_FLAG_MB_NO_SKIP_COEFF,
        sign_bias_golden = c.V4L2_VP8_FRAME_FLAG_SIGN_BIAS_GOLDEN,
        sign_bias_alt = c.V4L2_VP8_FRAME_FLAG_SIGN_BIAS_ALT,
    };

    pub const isKeyFrame = &c.V4L2_VP8_FRAME_IS_KEY_FRAME;

    pub const Ctrl = extern struct {
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
    };
};

test "stateless.vp8.Segment ABI matches struct_v4l2_vp8_segment" {
    const C = c.struct_v4l2_vp8_segment;
    const Z = vp8.Segment;
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
    const Z = vp8.LoopFilter;
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
    const Z = vp8.Quantization;
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
    const Z = vp8.Entropy;
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
    const Z = vp8.EntropyCoderState;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "range"), @offsetOf(Z, "range"));
    try std.testing.expectEqual(@offsetOf(C, "value"), @offsetOf(Z, "value"));
    try std.testing.expectEqual(@offsetOf(C, "bit_count"), @offsetOf(Z, "bit_count"));
    try std.testing.expectEqual(@offsetOf(C, "padding"), @offsetOf(Z, "padding"));
}

test "stateless.vp8.Frame ABI matches struct_v4l2_ctrl_vp8_frame" {
    const C = c.struct_v4l2_ctrl_vp8_frame;
    const Z = vp8.frame.Ctrl;
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
