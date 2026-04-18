const c = @import("bindings");
const std = @import("std");
const geometry = @import("../geometry.zig");
const Area = geometry.Area;
const Rectangle = geometry.Rectangle;

comptime {
    std.testing.refAllDecls(@This());
}

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

    pub const Flag = packed struct(u32) {
        disabled: bool = false,
        grabbed: bool = false,
        read_only: bool = false,
        update: bool = false,
        inactive: bool = false,
        slider: bool = false,
        write_only: bool = false,
        @"volatile": bool = false,
        has_payload: bool = false,
        execute_on_write: bool = false,
        modify_layout: bool = false,
        dynamic_array: bool = false,
        has_which_min_max: bool = false,
        _padding: u19 = 0,
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
