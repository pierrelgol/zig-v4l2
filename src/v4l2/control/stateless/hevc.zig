const c = @import("bindings");
pub const hevc = @This();
const std = @import("std");

comptime {
    std.testing.refAllDecls(@This());
}

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
    pub const pic_struct_frame = c.V4L2_HEVC_SEI_PIC_STRUCT_FRAME;
    pub const pic_struct_top_field = c.V4L2_HEVC_SEI_PIC_STRUCT_TOP_FIELD;
    pub const pic_struct_bottom_field = c.V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_FIELD;
    pub const pic_struct_top_bottom = c.V4L2_HEVC_SEI_PIC_STRUCT_TOP_BOTTOM;
    pub const pic_struct_bottom_top = c.V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_TOP;
    pub const pic_struct_top_bottom_top = c.V4L2_HEVC_SEI_PIC_STRUCT_TOP_BOTTOM_TOP;
    pub const pic_struct_bottom_top_bottom = c.V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_TOP_BOTTOM;
    pub const pic_struct_frame_doubling = c.V4L2_HEVC_SEI_PIC_STRUCT_FRAME_DOUBLING;
    pub const pic_struct_frame_tripling = c.V4L2_HEVC_SEI_PIC_STRUCT_FRAME_TRIPLING;
    pub const pic_struct_top_paired_previous_bottom = c.V4L2_HEVC_SEI_PIC_STRUCT_TOP_PAIRED_PREVIOUS_BOTTOM;
    pub const pic_struct_bottom_paired_previous_top = c.V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_PAIRED_PREVIOUS_TOP;
    pub const pic_struct_top_paired_next_bottom = c.V4L2_HEVC_SEI_PIC_STRUCT_TOP_PAIRED_NEXT_BOTTOM;
    pub const pic_struct_bottom_paired_next_top = c.V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_PAIRED_NEXT_TOP;
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

test "stateless.hevc.sps.Ctrl ABI matches struct_v4l2_ctrl_hevc_sps" {
    const C = c.struct_v4l2_ctrl_hevc_sps;
    const Z = hevc.sps.Ctrl;
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
    const Z = hevc.pps.Ctrl;
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
    const Z = hevc.scaling_matrix.Ctrl;
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
    const Z = hevc.dpb.Entry;
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
    const Z = hevc.PredWeightTable;
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
    const Z = hevc.slice.params.Ctrl;
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
    const Z = hevc.decode.params.Ctrl;
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
