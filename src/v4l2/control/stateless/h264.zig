const std = @import("std");

const c = @import("bindings");
const abi = @import("../../abi.zig");

pub const h264 = @This();
comptime {
    std.testing.refAllDecls(@This());
}

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

    dpb: [16]dpb.Entry,
    nal_ref_idc: u16,
    frame_num: u16,
    top_field_order_cnt: i32,
    bottom_field_order_cnt: i32,
    idr_pic_id: u16,
    pic_order_cnt_lsb: u16,
    delta_pic_order_cnt_bottom: i32,
    delta_pic_order_cnt0: i32,
    delta_pic_order_cnt1: i32,
    dec_ref_pic_marking_bit_size: u32,
    pic_order_cnt_bit_size: u32,
    slice_group_change_cycle: u32,
    reserved: u32,
    flags: u32,
};

test "stateless.h264.sps ABI matches struct_v4l2_ctrl_h264_sps" {
    const C = c.struct_v4l2_ctrl_h264_sps;
    const Z = h264.sps;
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
    const Z = h264.pps;
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
    const Z = h264.ScalingMatrix;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "scaling_list_4x4"), @offsetOf(Z, "scaling_list_4x4"));
    try std.testing.expectEqual(@offsetOf(C, "scaling_list_8x8"), @offsetOf(Z, "scaling_list_8x8"));
}

test "stateless.h264.WeightFactors ABI matches struct_v4l2_h264_weight_factors" {
    const C = c.struct_v4l2_h264_weight_factors;
    const Z = h264.WeightFactors;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "luma_weight"), @offsetOf(Z, "luma_weight"));
    try std.testing.expectEqual(@offsetOf(C, "luma_offset"), @offsetOf(Z, "luma_offset"));
    try std.testing.expectEqual(@offsetOf(C, "chroma_weight"), @offsetOf(Z, "chroma_weight"));
    try std.testing.expectEqual(@offsetOf(C, "chroma_offset"), @offsetOf(Z, "chroma_offset"));
}

test "stateless.h264.pred_weights ABI matches struct_v4l2_ctrl_h264_pred_weights" {
    const C = c.struct_v4l2_ctrl_h264_pred_weights;
    const Z = h264.pred_weights;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "luma_log2_weight_denom"), @offsetOf(Z, "luma_log2_weight_denom"));
    try std.testing.expectEqual(@offsetOf(C, "chroma_log2_weight_denom"), @offsetOf(Z, "chroma_log2_weight_denom"));
    try std.testing.expectEqual(@offsetOf(C, "weight_factors"), @offsetOf(Z, "weight_factors"));
}

test "stateless.h264.Reference ABI matches struct_v4l2_h264_reference" {
    const C = c.struct_v4l2_h264_reference;
    const Z = h264.Reference;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "fields"), @offsetOf(Z, "fields"));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
}

test "stateless.h264.slice_params ABI matches struct_v4l2_ctrl_h264_slice_params" {
    const C = c.struct_v4l2_ctrl_h264_slice_params;
    const Z = h264.slice_params;
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
    const Z = h264.dpb.Entry;
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

test "stateless.h264.DecodeParams ABI matches struct_v4l2_ctrl_h264_decode_params" {
    const C = c.struct_v4l2_ctrl_h264_decode_params;
    const Z = h264.DecodeParams;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "dpb", .z_name = "dpb" },
        .{ .c_name = "nal_ref_idc", .z_name = "nal_ref_idc" },
        .{ .c_name = "frame_num", .z_name = "frame_num" },
        .{ .c_name = "top_field_order_cnt", .z_name = "top_field_order_cnt" },
        .{ .c_name = "bottom_field_order_cnt", .z_name = "bottom_field_order_cnt" },
        .{ .c_name = "idr_pic_id", .z_name = "idr_pic_id" },
        .{ .c_name = "pic_order_cnt_lsb", .z_name = "pic_order_cnt_lsb" },
        .{ .c_name = "delta_pic_order_cnt_bottom", .z_name = "delta_pic_order_cnt_bottom" },
        .{ .c_name = "delta_pic_order_cnt0", .z_name = "delta_pic_order_cnt0" },
        .{ .c_name = "delta_pic_order_cnt1", .z_name = "delta_pic_order_cnt1" },
        .{ .c_name = "dec_ref_pic_marking_bit_size", .z_name = "dec_ref_pic_marking_bit_size" },
        .{ .c_name = "pic_order_cnt_bit_size", .z_name = "pic_order_cnt_bit_size" },
        .{ .c_name = "slice_group_change_cycle", .z_name = "slice_group_change_cycle" },
        .{ .c_name = "reserved", .z_name = "reserved" },
        .{ .c_name = "flags", .z_name = "flags" },
    });
}
