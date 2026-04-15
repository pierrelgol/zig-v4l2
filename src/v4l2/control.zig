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
