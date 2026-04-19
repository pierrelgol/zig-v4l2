const std = @import("std");

const c = @import("bindings");

pub const vp9 = @This();

comptime {
    std.testing.refAllDecls(@This());
}

pub const LoopFilter = extern struct {
    ref_deltas: [4]i8,
    mode_deltas: [2]i8,
    level: u8,
    sharpness: u8,
    flags: u8,
    reserved: [7]u8,

    pub const Flag = struct {
        pub const enabled: u32 = c.V4L2_VP9_LOOP_FILTER_FLAG_DELTA_ENABLED;
        pub const update: u32 = c.V4L2_VP9_LOOP_FILTER_FLAG_DELTA_UPDATE;
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

    pub const Flag = struct {
        pub const enabled: i32 = c.V4L2_VP9_SEGMENTATION_FLAG_ENABLED;
        pub const update_map: i32 = c.V4L2_VP9_SEGMENTATION_FLAG_UPDATE_MAP;
        pub const temporal_update: i32 = c.V4L2_VP9_SEGMENTATION_FLAG_TEMPORAL_UPDATE;
        pub const update_data: i32 = c.V4L2_VP9_SEGMENTATION_FLAG_UPDATE_DATA;
        pub const abs_or_delta_update: i32 = c.V4L2_VP9_SEGMENTATION_FLAG_ABS_OR_DELTA_UPDATE;
    };

    pub const Level = enum(i32) {
        alt_q = c.V4L2_VP9_SEG_LVL_ALT_Q,
        alt_l = c.V4L2_VP9_SEG_LVL_ALT_L,
        ref_frame = c.V4L2_VP9_SEG_LVL_REF_FRAME,
        skip = c.V4L2_VP9_SEG_LVL_SKIP,
        max = c.V4L2_VP9_SEG_LVL_MAX,
    };

    pub const isFeatureEnabled = &c.V4L2_AV1_SEGMENT_FEATURE_ENABLED;
    pub const featureEnabledMask = c.V4L2_VP9_SEGMENT_FEATURE_ENABLED_MASK;
};

pub const frame = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_VP9_FRAME;

    pub const Flag = struct {
        pub const key_frame: i32 = c.V4L2_VP9_FRAME_FLAG_KEY_FRAME;
        pub const show_frame: i32 = c.V4L2_VP9_FRAME_FLAG_SHOW_FRAME;
        pub const error_resilient: i32 = c.V4L2_VP9_FRAME_FLAG_ERROR_RESILIENT;
        pub const intra_only: i32 = c.V4L2_VP9_FRAME_FLAG_INTRA_ONLY;
        pub const allow_high_prec_mv: i32 = c.V4L2_VP9_FRAME_FLAG_ALLOW_HIGH_PREC_MV;
        pub const refresh_frame_ctx: i32 = c.V4L2_VP9_FRAME_FLAG_REFRESH_FRAME_CTX;
        pub const parallel_dec_mode: i32 = c.V4L2_VP9_FRAME_FLAG_PARALLEL_DEC_MODE;
        pub const x_subsampling: i32 = c.V4L2_VP9_FRAME_FLAG_X_SUBSAMPLING;
        pub const y_subsampling: i32 = c.V4L2_VP9_FRAME_FLAG_Y_SUBSAMPLING;
        pub const color_range_full_swing: i32 = c.V4L2_VP9_FRAME_FLAG_COLOR_RANGE_FULL_SWING;
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

test "stateless.vp9.LoopFilter ABI matches struct_v4l2_vp9_loop_filter" {
    const C = c.struct_v4l2_vp9_loop_filter;
    const Z = vp9.LoopFilter;
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
    const Z = vp9.Quantization;
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
    const Z = vp9.Segmentation;
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
    const Z = vp9.frame.Ctrl;
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
    const Z = vp9.compressed_hdr.MvProbs;
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
    const Z = vp9.compressed_hdr.Ctrl;
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
