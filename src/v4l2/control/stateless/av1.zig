const std = @import("std");

const c = @import("bindings");

pub const av1 = @This();

comptime {
    std.testing.refAllDecls(@This());
}

pub const WarpModel = enum(c_int) {
    identity = c.V4L2_AV1_WARP_MODEL_IDENTITY,
    translation = c.V4L2_AV1_WARP_MODEL_TRANSLATION,
    rotzoom = c.V4L2_AV1_WARP_MODEL_ROTZOOM,
    affine = c.V4L2_AV1_WARP_MODEL_AFFINE,
};

pub const ReferenceFrame = enum(c_int) {
    intra = c.V4L2_AV1_REF_INTRA_FRAME,
    last = c.V4L2_AV1_REF_LAST_FRAME,
    last2 = c.V4L2_AV1_REF_LAST2_FRAME,
    last3 = c.V4L2_AV1_REF_LAST3_FRAME,
    golden = c.V4L2_AV1_REF_GOLDEN_FRAME,
    bwdref = c.V4L2_AV1_REF_BWDREF_FRAME,
    altref2 = c.V4L2_AV1_REF_ALTREF2_FRAME,
    altref = c.V4L2_AV1_REF_ALTREF_FRAME,
};

pub const FrameRestorationType = enum(c_int) {
    none = c.V4L2_AV1_FRAME_RESTORE_NONE,
    wiener = c.V4L2_AV1_FRAME_RESTORE_WIENER,
    sgrproj = c.V4L2_AV1_FRAME_RESTORE_SGRPROJ,
    switchable = c.V4L2_AV1_FRAME_RESTORE_SWITCHABLE,
};

pub const SegmentFeature = enum(c_int) {
    alt_q = c.V4L2_AV1_SEG_LVL_ALT_Q,
    alt_lf_y_v = c.V4L2_AV1_SEG_LVL_ALT_LF_Y_V,
    ref_frame = c.V4L2_AV1_SEG_LVL_REF_FRAME,
    ref_skip = c.V4L2_AV1_SEG_LVL_REF_SKIP,
    ref_globalmv = c.V4L2_AV1_SEG_LVL_REF_GLOBALMV,
    max = c.V4L2_AV1_SEG_LVL_MAX,
};

pub const FrameType = enum(c_int) {
    key = c.V4L2_AV1_KEY_FRAME,
    inter = c.V4L2_AV1_INTER_FRAME,
    intra_only = c.V4L2_AV1_INTRA_ONLY_FRAME,
    switch_frame = c.V4L2_AV1_SWITCH_FRAME,
};

pub const InterpolationFilter = enum(c_int) {
    eighttap = c.V4L2_AV1_INTERPOLATION_FILTER_EIGHTTAP,
    eighttap_smooth = c.V4L2_AV1_INTERPOLATION_FILTER_EIGHTTAP_SMOOTH,
    eighttap_sharp = c.V4L2_AV1_INTERPOLATION_FILTER_EIGHTTAP_SHARP,
    bilinear = c.V4L2_AV1_INTERPOLATION_FILTER_BILINEAR,
    switchable = c.V4L2_AV1_INTERPOLATION_FILTER_SWITCHABLE,
};

pub const TxMode = enum(c_int) {
    only_4x4 = c.V4L2_AV1_TX_MODE_ONLY_4X4,
    largest = c.V4L2_AV1_TX_MODE_LARGEST,
    select = c.V4L2_AV1_TX_MODE_SELECT,
};

pub const global_motion_flag = struct {
    pub const is_global: u32 = c.V4L2_AV1_GLOBAL_MOTION_FLAG_IS_GLOBAL;
    pub const is_rot_zoom: u32 = c.V4L2_AV1_GLOBAL_MOTION_FLAG_IS_ROT_ZOOM;
    pub const is_translation: u32 = c.V4L2_AV1_GLOBAL_MOTION_FLAG_IS_TRANSLATION;
};

pub const loop_restoration_flag = struct {
    pub const uses_lr: u32 = c.V4L2_AV1_LOOP_RESTORATION_FLAG_USES_LR;
    pub const uses_chroma_lr: u32 = c.V4L2_AV1_LOOP_RESTORATION_FLAG_USES_CHROMA_LR;
};

pub const segmentation_flag = struct {
    pub const enabled: u32 = c.V4L2_AV1_SEGMENTATION_FLAG_ENABLED;
    pub const update_map: u32 = c.V4L2_AV1_SEGMENTATION_FLAG_UPDATE_MAP;
    pub const temporal_update: u32 = c.V4L2_AV1_SEGMENTATION_FLAG_TEMPORAL_UPDATE;
    pub const update_data: u32 = c.V4L2_AV1_SEGMENTATION_FLAG_UPDATE_DATA;
    pub const seg_id_pre_skip: u32 = c.V4L2_AV1_SEGMENTATION_FLAG_SEG_ID_PRE_SKIP;
};

pub const loop_filter_flag = struct {
    pub const delta_enabled: u32 = c.V4L2_AV1_LOOP_FILTER_FLAG_DELTA_ENABLED;
    pub const delta_update: u32 = c.V4L2_AV1_LOOP_FILTER_FLAG_DELTA_UPDATE;
    pub const delta_lf_present: u32 = c.V4L2_AV1_LOOP_FILTER_FLAG_DELTA_LF_PRESENT;
    pub const delta_lf_multi: u32 = c.V4L2_AV1_LOOP_FILTER_FLAG_DELTA_LF_MULTI;
};

pub const quantization_flag = struct {
    pub const diff_uv_delta: u32 = c.V4L2_AV1_QUANTIZATION_FLAG_DIFF_UV_DELTA;
    pub const using_qmatrix: u32 = c.V4L2_AV1_QUANTIZATION_FLAG_USING_QMATRIX;
    pub const delta_q_present: u32 = c.V4L2_AV1_QUANTIZATION_FLAG_DELTA_Q_PRESENT;
};

pub const tile_info_flag = struct {
    pub const uniform_tile_spacing: u32 = c.V4L2_AV1_TILE_INFO_FLAG_UNIFORM_TILE_SPACING;
};

pub const frame_flag = struct {
    pub const show_frame: u32 = c.V4L2_AV1_FRAME_FLAG_SHOW_FRAME;
    pub const showable_frame: u32 = c.V4L2_AV1_FRAME_FLAG_SHOWABLE_FRAME;
    pub const error_resilient_mode: u32 = c.V4L2_AV1_FRAME_FLAG_ERROR_RESILIENT_MODE;
    pub const disable_cdf_update: u32 = c.V4L2_AV1_FRAME_FLAG_DISABLE_CDF_UPDATE;
    pub const allow_screen_content_tools: u32 = c.V4L2_AV1_FRAME_FLAG_ALLOW_SCREEN_CONTENT_TOOLS;
    pub const force_integer_mv: u32 = c.V4L2_AV1_FRAME_FLAG_FORCE_INTEGER_MV;
    pub const allow_intrabc: u32 = c.V4L2_AV1_FRAME_FLAG_ALLOW_INTRABC;
    pub const use_superres: u32 = c.V4L2_AV1_FRAME_FLAG_USE_SUPERRES;
    pub const allow_high_precision_mv: u32 = c.V4L2_AV1_FRAME_FLAG_ALLOW_HIGH_PRECISION_MV;
    pub const is_motion_mode_switchable: u32 = c.V4L2_AV1_FRAME_FLAG_IS_MOTION_MODE_SWITCHABLE;
    pub const use_ref_frame_mvs: u32 = c.V4L2_AV1_FRAME_FLAG_USE_REF_FRAME_MVS;
    pub const disable_frame_end_update_cdf: u32 = c.V4L2_AV1_FRAME_FLAG_DISABLE_FRAME_END_UPDATE_CDF;
    pub const allow_warped_motion: u32 = c.V4L2_AV1_FRAME_FLAG_ALLOW_WARPED_MOTION;
    pub const reference_select: u32 = c.V4L2_AV1_FRAME_FLAG_REFERENCE_SELECT;
    pub const reduced_tx_set: u32 = c.V4L2_AV1_FRAME_FLAG_REDUCED_TX_SET;
    pub const skip_mode_allowed: u32 = c.V4L2_AV1_FRAME_FLAG_SKIP_MODE_ALLOWED;
    pub const skip_mode_present: u32 = c.V4L2_AV1_FRAME_FLAG_SKIP_MODE_PRESENT;
    pub const frame_size_override: u32 = c.V4L2_AV1_FRAME_FLAG_FRAME_SIZE_OVERRIDE;
    pub const buffer_removal_time_present: u32 = c.V4L2_AV1_FRAME_FLAG_BUFFER_REMOVAL_TIME_PRESENT;
    pub const frame_refs_short_signaling: u32 = c.V4L2_AV1_FRAME_FLAG_FRAME_REFS_SHORT_SIGNALING;
};

pub const film_grain_flag = struct {
    pub const apply_grain: u32 = c.V4L2_AV1_FILM_GRAIN_FLAG_APPLY_GRAIN;
    pub const update_grain: u32 = c.V4L2_AV1_FILM_GRAIN_FLAG_UPDATE_GRAIN;
    pub const chroma_scaling_from_luma: u32 = c.V4L2_AV1_FILM_GRAIN_FLAG_CHROMA_SCALING_FROM_LUMA;
    pub const overlap: u32 = c.V4L2_AV1_FILM_GRAIN_FLAG_OVERLAP;
    pub const clip_to_restricted_range: u32 = c.V4L2_AV1_FILM_GRAIN_FLAG_CLIP_TO_RESTRICTED_RANGE;
};

pub const isGlobalMotionInvalid = &c.V4L2_AV1_GLOBAL_MOTION_IS_INVALID;
pub const isSegmentFeatureEnabled = &c.V4L2_AV1_SEGMENT_FEATURE_ENABLED;

pub const sequence = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_AV1_SEQUENCE;

    pub const max_tile_count: u32 = c.V4L2_AV1_MAX_TILE_COUNT;

    pub const flag = struct {
        pub const still_picture: u32 = c.V4L2_AV1_SEQUENCE_FLAG_STILL_PICTURE;
        pub const use_128x128_superblock: u32 = c.V4L2_AV1_SEQUENCE_FLAG_USE_128X128_SUPERBLOCK;
        pub const enable_filter_intra: u32 = c.V4L2_AV1_SEQUENCE_FLAG_ENABLE_FILTER_INTRA;
        pub const enable_intra_edge_filter: u32 = c.V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTRA_EDGE_FILTER;
        pub const enable_interintra_compound: u32 = c.V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTERINTRA_COMPOUND;
        pub const enable_masked_compound: u32 = c.V4L2_AV1_SEQUENCE_FLAG_ENABLE_MASKED_COMPOUND;
        pub const enable_warped_motion: u32 = c.V4L2_AV1_SEQUENCE_FLAG_ENABLE_WARPED_MOTION;
        pub const enable_dual_filter: u32 = c.V4L2_AV1_SEQUENCE_FLAG_ENABLE_DUAL_FILTER;
        pub const enable_order_hint: u32 = c.V4L2_AV1_SEQUENCE_FLAG_ENABLE_ORDER_HINT;
        pub const enable_jnt_comp: u32 = c.V4L2_AV1_SEQUENCE_FLAG_ENABLE_JNT_COMP;
        pub const enable_ref_frame_mvs: u32 = c.V4L2_AV1_SEQUENCE_FLAG_ENABLE_REF_FRAME_MVS;
        pub const enable_superres: u32 = c.V4L2_AV1_SEQUENCE_FLAG_ENABLE_SUPERRES;
        pub const enable_cdef: u32 = c.V4L2_AV1_SEQUENCE_FLAG_ENABLE_CDEF;
        pub const enable_restoration: u32 = c.V4L2_AV1_SEQUENCE_FLAG_ENABLE_RESTORATION;
        pub const mono_chrome: u32 = c.V4L2_AV1_SEQUENCE_FLAG_MONO_CHROME;
        pub const color_range: u32 = c.V4L2_AV1_SEQUENCE_FLAG_COLOR_RANGE;
        pub const subsampling_x: u32 = c.V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_X;
        pub const subsampling_y: u32 = c.V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_Y;
        pub const film_grain_params_present: u32 = c.V4L2_AV1_SEQUENCE_FLAG_FILM_GRAIN_PARAMS_PRESENT;
        pub const separate_uv_delta_q: u32 = c.V4L2_AV1_SEQUENCE_FLAG_SEPARATE_UV_DELTA_Q;
    };

    pub const Ctrl = extern struct {
        flags: u32,
        seq_profile: u8,
        order_hint_bits: u8,
        bit_depth: u8,
        reserved: u8,
        max_frame_width_minus_1: u16,
        max_frame_height_minus_1: u16,
    };
};

pub const tile_group_entry = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY;

    pub const Ctrl = extern struct {
        tile_offset: u32,
        tile_size: u32,
        tile_row: u32,
        tile_col: u32,
    };
};

pub const global_motion = struct {
    pub const Ctrl = extern struct {
        flags: [c.V4L2_AV1_TOTAL_REFS_PER_FRAME]u8,
        warp_model: [c.V4L2_AV1_TOTAL_REFS_PER_FRAME]WarpModel,
        params: [c.V4L2_AV1_TOTAL_REFS_PER_FRAME][6]i32,
        invalid: u8,
        reserved: [3]u8,
    };
};

pub const loop_restoration = struct {
    pub const Ctrl = extern struct {
        flags: u8,
        lr_unit_shift: u8,
        lr_uv_shift: u8,
        reserved: u8,
        frame_restoration_type: [c.V4L2_AV1_NUM_PLANES_MAX]FrameRestorationType,
        loop_restoration_size: [c.V4L2_AV1_MAX_NUM_PLANES]u32,
    };
};

pub const cdef = struct {
    pub const Ctrl = extern struct {
        damping_minus_3: u8,
        bits: u8,
        y_pri_strength: [c.V4L2_AV1_CDEF_MAX]u8,
        y_sec_strength: [c.V4L2_AV1_CDEF_MAX]u8,
        uv_pri_strength: [c.V4L2_AV1_CDEF_MAX]u8,
        uv_sec_strength: [c.V4L2_AV1_CDEF_MAX]u8,
    };
};

pub const segmentation = struct {
    pub const Ctrl = extern struct {
        flags: u8,
        last_active_seg_id: u8,
        feature_enabled: [c.V4L2_AV1_MAX_SEGMENTS]u8,
        feature_data: [c.V4L2_AV1_MAX_SEGMENTS][c.V4L2_AV1_SEG_LVL_MAX]i16,
    };
};

pub const loop_filter = struct {
    pub const Ctrl = extern struct {
        flags: u8,
        level: [4]u8,
        sharpness: u8,
        ref_deltas: [c.V4L2_AV1_TOTAL_REFS_PER_FRAME]i8,
        mode_deltas: [2]i8,
        delta_lf_res: u8,
    };
};

pub const quantization = struct {
    pub const Ctrl = extern struct {
        flags: u8,
        base_q_idx: u8,
        delta_q_y_dc: i8,
        delta_q_u_dc: i8,
        delta_q_u_ac: i8,
        delta_q_v_dc: i8,
        delta_q_v_ac: i8,
        qm_y: u8,
        qm_u: u8,
        qm_v: u8,
        delta_q_res: u8,
    };
};

pub const tile_info = struct {
    pub const Ctrl = extern struct {
        flags: u8,
        context_update_tile_id: u8,
        tile_cols: u8,
        tile_rows: u8,
        mi_col_starts: [c.V4L2_AV1_MAX_TILE_COLS + 1]u32,
        mi_row_starts: [c.V4L2_AV1_MAX_TILE_ROWS + 1]u32,
        width_in_sbs_minus_1: [c.V4L2_AV1_MAX_TILE_COLS]u32,
        height_in_sbs_minus_1: [c.V4L2_AV1_MAX_TILE_ROWS]u32,
        tile_size_bytes: u8,
        reserved: [3]u8,
    };
};

pub const frame = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_AV1_FRAME;

    pub const Ctrl = extern struct {
        tile_info: tile_info.Ctrl,
        quantization: quantization.Ctrl,
        superres_denom: u8,
        segmentation: segmentation.Ctrl,
        loop_filter: loop_filter.Ctrl,
        cdef: cdef.Ctrl,
        skip_mode_frame: [2]u8,
        primary_ref_frame: u8,
        loop_restoration: loop_restoration.Ctrl,
        global_motion: global_motion.Ctrl,
        flags: u32,
        frame_type: FrameType,
        order_hint: u32,
        upscaled_width: u32,
        interpolation_filter: InterpolationFilter,
        tx_mode: TxMode,
        frame_width_minus_1: u32,
        frame_height_minus_1: u32,
        render_width_minus_1: u16,
        render_height_minus_1: u16,
        current_frame_id: u32,
        buffer_removal_time: [c.V4L2_AV1_MAX_OPERATING_POINTS]u32,
        reserved: [4]u8,
        order_hints: [c.V4L2_AV1_TOTAL_REFS_PER_FRAME]u32,
        reference_frame_ts: [c.V4L2_AV1_TOTAL_REFS_PER_FRAME]u64,
        ref_frame_idx: [c.V4L2_AV1_REFS_PER_FRAME]i8,
        refresh_frame_flags: u8,
    };
};

pub const film_grain = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_AV1_FILM_GRAIN;

    pub const Ctrl = extern struct {
        flags: u8,
        cr_mult: u8,
        grain_seed: u16,
        film_grain_params_ref_idx: u8,
        num_y_points: u8,
        point_y_value: [c.V4L2_AV1_MAX_NUM_Y_POINTS]u8,
        point_y_scaling: [c.V4L2_AV1_MAX_NUM_Y_POINTS]u8,
        num_cb_points: u8,
        point_cb_value: [c.V4L2_AV1_MAX_NUM_CB_POINTS]u8,
        point_cb_scaling: [c.V4L2_AV1_MAX_NUM_CB_POINTS]u8,
        num_cr_points: u8,
        point_cr_value: [c.V4L2_AV1_MAX_NUM_CR_POINTS]u8,
        point_cr_scaling: [c.V4L2_AV1_MAX_NUM_CR_POINTS]u8,
        grain_scaling_minus_8: u8,
        ar_coeff_lag: u8,
        ar_coeffs_y_plus_128: [c.V4L2_AV1_AR_COEFFS_SIZE]u8,
        ar_coeffs_cb_plus_128: [c.V4L2_AV1_AR_COEFFS_SIZE]u8,
        ar_coeffs_cr_plus_128: [c.V4L2_AV1_AR_COEFFS_SIZE]u8,
        ar_coeff_shift_minus_6: u8,
        grain_scale_shift: u8,
        cb_mult: u8,
        cb_luma_mult: u8,
        cr_luma_mult: u8,
        cb_offset: u16,
        cr_offset: u16,
        reserved: [4]u8,
    };
};

test "stateless.av1.tile_group_entry.Ctrl ABI matches struct_v4l2_ctrl_av1_tile_group_entry" {
    const C = c.struct_v4l2_ctrl_av1_tile_group_entry;
    const Z = av1.tile_group_entry.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "tile_offset"), @offsetOf(Z, "tile_offset"));
    try std.testing.expectEqual(@offsetOf(C, "tile_size"), @offsetOf(Z, "tile_size"));
    try std.testing.expectEqual(@offsetOf(C, "tile_row"), @offsetOf(Z, "tile_row"));
    try std.testing.expectEqual(@offsetOf(C, "tile_col"), @offsetOf(Z, "tile_col"));
}

test "stateless.av1.sequence.Ctrl ABI matches struct_v4l2_ctrl_av1_sequence" {
    const C = c.struct_v4l2_ctrl_av1_sequence;
    const Z = av1.sequence.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "seq_profile"), @offsetOf(Z, "seq_profile"));
    try std.testing.expectEqual(@offsetOf(C, "order_hint_bits"), @offsetOf(Z, "order_hint_bits"));
    try std.testing.expectEqual(@offsetOf(C, "bit_depth"), @offsetOf(Z, "bit_depth"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
    try std.testing.expectEqual(@offsetOf(C, "max_frame_width_minus_1"), @offsetOf(Z, "max_frame_width_minus_1"));
    try std.testing.expectEqual(@offsetOf(C, "max_frame_height_minus_1"), @offsetOf(Z, "max_frame_height_minus_1"));
}

test "stateless.av1.global_motion.Ctrl ABI matches struct_v4l2_av1_global_motion" {
    const C = c.struct_v4l2_av1_global_motion;
    const Z = av1.global_motion.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "warp_model"));
    try std.testing.expectEqual(@offsetOf(C, "params"), @offsetOf(Z, "params"));
    try std.testing.expectEqual(@offsetOf(C, "invalid"), @offsetOf(Z, "invalid"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "stateless.av1.loop_restoration.Ctrl ABI matches struct_v4l2_av1_loop_restoration" {
    const C = c.struct_v4l2_av1_loop_restoration;
    const Z = av1.loop_restoration.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "lr_unit_shift"), @offsetOf(Z, "lr_unit_shift"));
    try std.testing.expectEqual(@offsetOf(C, "lr_uv_shift"), @offsetOf(Z, "lr_uv_shift"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
    try std.testing.expectEqual(@offsetOf(C, "frame_restoration_type"), @offsetOf(Z, "frame_restoration_type"));
    try std.testing.expectEqual(@offsetOf(C, "loop_restoration_size"), @offsetOf(Z, "loop_restoration_size"));
}

test "stateless.av1.cdef.Ctrl ABI matches struct_v4l2_av1_cdef" {
    const C = c.struct_v4l2_av1_cdef;
    const Z = av1.cdef.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "damping_minus_3"), @offsetOf(Z, "damping_minus_3"));
    try std.testing.expectEqual(@offsetOf(C, "bits"), @offsetOf(Z, "bits"));
    try std.testing.expectEqual(@offsetOf(C, "y_pri_strength"), @offsetOf(Z, "y_pri_strength"));
    try std.testing.expectEqual(@offsetOf(C, "y_sec_strength"), @offsetOf(Z, "y_sec_strength"));
    try std.testing.expectEqual(@offsetOf(C, "uv_pri_strength"), @offsetOf(Z, "uv_pri_strength"));
    try std.testing.expectEqual(@offsetOf(C, "uv_sec_strength"), @offsetOf(Z, "uv_sec_strength"));
}

test "stateless.av1.segmentation.Ctrl ABI matches struct_v4l2_av1_segmentation" {
    const C = c.struct_v4l2_av1_segmentation;
    const Z = av1.segmentation.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "last_active_seg_id"), @offsetOf(Z, "last_active_seg_id"));
    try std.testing.expectEqual(@offsetOf(C, "feature_enabled"), @offsetOf(Z, "feature_enabled"));
    try std.testing.expectEqual(@offsetOf(C, "feature_data"), @offsetOf(Z, "feature_data"));
}

test "stateless.av1.loop_filter.Ctrl ABI matches struct_v4l2_av1_loop_filter" {
    const C = c.struct_v4l2_av1_loop_filter;
    const Z = av1.loop_filter.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "level"), @offsetOf(Z, "level"));
    try std.testing.expectEqual(@offsetOf(C, "sharpness"), @offsetOf(Z, "sharpness"));
    try std.testing.expectEqual(@offsetOf(C, "ref_deltas"), @offsetOf(Z, "ref_deltas"));
    try std.testing.expectEqual(@offsetOf(C, "mode_deltas"), @offsetOf(Z, "mode_deltas"));
    try std.testing.expectEqual(@offsetOf(C, "delta_lf_res"), @offsetOf(Z, "delta_lf_res"));
}

test "stateless.av1.quantization.Ctrl ABI matches struct_v4l2_av1_quantization" {
    const C = c.struct_v4l2_av1_quantization;
    const Z = av1.quantization.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "base_q_idx"), @offsetOf(Z, "base_q_idx"));
    try std.testing.expectEqual(@offsetOf(C, "delta_q_y_dc"), @offsetOf(Z, "delta_q_y_dc"));
    try std.testing.expectEqual(@offsetOf(C, "delta_q_u_dc"), @offsetOf(Z, "delta_q_u_dc"));
    try std.testing.expectEqual(@offsetOf(C, "delta_q_u_ac"), @offsetOf(Z, "delta_q_u_ac"));
    try std.testing.expectEqual(@offsetOf(C, "delta_q_v_dc"), @offsetOf(Z, "delta_q_v_dc"));
    try std.testing.expectEqual(@offsetOf(C, "delta_q_v_ac"), @offsetOf(Z, "delta_q_v_ac"));
    try std.testing.expectEqual(@offsetOf(C, "qm_y"), @offsetOf(Z, "qm_y"));
    try std.testing.expectEqual(@offsetOf(C, "qm_u"), @offsetOf(Z, "qm_u"));
    try std.testing.expectEqual(@offsetOf(C, "qm_v"), @offsetOf(Z, "qm_v"));
    try std.testing.expectEqual(@offsetOf(C, "delta_q_res"), @offsetOf(Z, "delta_q_res"));
}

test "stateless.av1.tile_info.Ctrl ABI matches struct_v4l2_av1_tile_info" {
    const C = c.struct_v4l2_av1_tile_info;
    const Z = av1.tile_info.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "context_update_tile_id"), @offsetOf(Z, "context_update_tile_id"));
    try std.testing.expectEqual(@offsetOf(C, "tile_cols"), @offsetOf(Z, "tile_cols"));
    try std.testing.expectEqual(@offsetOf(C, "tile_rows"), @offsetOf(Z, "tile_rows"));
    try std.testing.expectEqual(@offsetOf(C, "mi_col_starts"), @offsetOf(Z, "mi_col_starts"));
    try std.testing.expectEqual(@offsetOf(C, "mi_row_starts"), @offsetOf(Z, "mi_row_starts"));
    try std.testing.expectEqual(@offsetOf(C, "width_in_sbs_minus_1"), @offsetOf(Z, "width_in_sbs_minus_1"));
    try std.testing.expectEqual(@offsetOf(C, "height_in_sbs_minus_1"), @offsetOf(Z, "height_in_sbs_minus_1"));
    try std.testing.expectEqual(@offsetOf(C, "tile_size_bytes"), @offsetOf(Z, "tile_size_bytes"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "stateless.av1.frame.Ctrl ABI matches struct_v4l2_ctrl_av1_frame" {
    const C = c.struct_v4l2_ctrl_av1_frame;
    const Z = av1.frame.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "tile_info"), @offsetOf(Z, "tile_info"));
    try std.testing.expectEqual(@offsetOf(C, "quantization"), @offsetOf(Z, "quantization"));
    try std.testing.expectEqual(@offsetOf(C, "superres_denom"), @offsetOf(Z, "superres_denom"));
    try std.testing.expectEqual(@offsetOf(C, "segmentation"), @offsetOf(Z, "segmentation"));
    try std.testing.expectEqual(@offsetOf(C, "loop_filter"), @offsetOf(Z, "loop_filter"));
    try std.testing.expectEqual(@offsetOf(C, "cdef"), @offsetOf(Z, "cdef"));
    try std.testing.expectEqual(@offsetOf(C, "skip_mode_frame"), @offsetOf(Z, "skip_mode_frame"));
    try std.testing.expectEqual(@offsetOf(C, "primary_ref_frame"), @offsetOf(Z, "primary_ref_frame"));
    try std.testing.expectEqual(@offsetOf(C, "loop_restoration"), @offsetOf(Z, "loop_restoration"));
    try std.testing.expectEqual(@offsetOf(C, "global_motion"), @offsetOf(Z, "global_motion"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "frame_type"), @offsetOf(Z, "frame_type"));
    try std.testing.expectEqual(@offsetOf(C, "order_hint"), @offsetOf(Z, "order_hint"));
    try std.testing.expectEqual(@offsetOf(C, "upscaled_width"), @offsetOf(Z, "upscaled_width"));
    try std.testing.expectEqual(@offsetOf(C, "interpolation_filter"), @offsetOf(Z, "interpolation_filter"));
    try std.testing.expectEqual(@offsetOf(C, "tx_mode"), @offsetOf(Z, "tx_mode"));
    try std.testing.expectEqual(@offsetOf(C, "frame_width_minus_1"), @offsetOf(Z, "frame_width_minus_1"));
    try std.testing.expectEqual(@offsetOf(C, "frame_height_minus_1"), @offsetOf(Z, "frame_height_minus_1"));
    try std.testing.expectEqual(@offsetOf(C, "render_width_minus_1"), @offsetOf(Z, "render_width_minus_1"));
    try std.testing.expectEqual(@offsetOf(C, "render_height_minus_1"), @offsetOf(Z, "render_height_minus_1"));
    try std.testing.expectEqual(@offsetOf(C, "current_frame_id"), @offsetOf(Z, "current_frame_id"));
    try std.testing.expectEqual(@offsetOf(C, "buffer_removal_time"), @offsetOf(Z, "buffer_removal_time"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
    try std.testing.expectEqual(@offsetOf(C, "order_hints"), @offsetOf(Z, "order_hints"));
    try std.testing.expectEqual(@offsetOf(C, "reference_frame_ts"), @offsetOf(Z, "reference_frame_ts"));
    try std.testing.expectEqual(@offsetOf(C, "ref_frame_idx"), @offsetOf(Z, "ref_frame_idx"));
    try std.testing.expectEqual(@offsetOf(C, "refresh_frame_flags"), @offsetOf(Z, "refresh_frame_flags"));
}

test "stateless.av1.film_grain.Ctrl ABI matches struct_v4l2_ctrl_av1_film_grain" {
    const C = c.struct_v4l2_ctrl_av1_film_grain;
    const Z = av1.film_grain.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "cr_mult"), @offsetOf(Z, "cr_mult"));
    try std.testing.expectEqual(@offsetOf(C, "grain_seed"), @offsetOf(Z, "grain_seed"));
    try std.testing.expectEqual(@offsetOf(C, "film_grain_params_ref_idx"), @offsetOf(Z, "film_grain_params_ref_idx"));
    try std.testing.expectEqual(@offsetOf(C, "num_y_points"), @offsetOf(Z, "num_y_points"));
    try std.testing.expectEqual(@offsetOf(C, "point_y_value"), @offsetOf(Z, "point_y_value"));
    try std.testing.expectEqual(@offsetOf(C, "point_y_scaling"), @offsetOf(Z, "point_y_scaling"));
    try std.testing.expectEqual(@offsetOf(C, "num_cb_points"), @offsetOf(Z, "num_cb_points"));
    try std.testing.expectEqual(@offsetOf(C, "point_cb_value"), @offsetOf(Z, "point_cb_value"));
    try std.testing.expectEqual(@offsetOf(C, "point_cb_scaling"), @offsetOf(Z, "point_cb_scaling"));
    try std.testing.expectEqual(@offsetOf(C, "num_cr_points"), @offsetOf(Z, "num_cr_points"));
    try std.testing.expectEqual(@offsetOf(C, "point_cr_value"), @offsetOf(Z, "point_cr_value"));
    try std.testing.expectEqual(@offsetOf(C, "point_cr_scaling"), @offsetOf(Z, "point_cr_scaling"));
    try std.testing.expectEqual(@offsetOf(C, "grain_scaling_minus_8"), @offsetOf(Z, "grain_scaling_minus_8"));
    try std.testing.expectEqual(@offsetOf(C, "ar_coeff_lag"), @offsetOf(Z, "ar_coeff_lag"));
    try std.testing.expectEqual(@offsetOf(C, "ar_coeffs_y_plus_128"), @offsetOf(Z, "ar_coeffs_y_plus_128"));
    try std.testing.expectEqual(@offsetOf(C, "ar_coeffs_cb_plus_128"), @offsetOf(Z, "ar_coeffs_cb_plus_128"));
    try std.testing.expectEqual(@offsetOf(C, "ar_coeffs_cr_plus_128"), @offsetOf(Z, "ar_coeffs_cr_plus_128"));
    try std.testing.expectEqual(@offsetOf(C, "ar_coeff_shift_minus_6"), @offsetOf(Z, "ar_coeff_shift_minus_6"));
    try std.testing.expectEqual(@offsetOf(C, "grain_scale_shift"), @offsetOf(Z, "grain_scale_shift"));
    try std.testing.expectEqual(@offsetOf(C, "cb_mult"), @offsetOf(Z, "cb_mult"));
    try std.testing.expectEqual(@offsetOf(C, "cb_luma_mult"), @offsetOf(Z, "cb_luma_mult"));
    try std.testing.expectEqual(@offsetOf(C, "cr_luma_mult"), @offsetOf(Z, "cr_luma_mult"));
    try std.testing.expectEqual(@offsetOf(C, "cb_offset"), @offsetOf(Z, "cb_offset"));
    try std.testing.expectEqual(@offsetOf(C, "cr_offset"), @offsetOf(Z, "cr_offset"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}
