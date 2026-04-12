const geometry = @import("geometry.zig");
const Area = geometry.Area;
const Rectangle = geometry.Rectangle;

pub const Control = @This();

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
    id: u32,
    size: u32,
    reserved2: [1]u32,
    value: extern union {
        s32: i32,
        s64: i64,
        string: ?[*]u8,
        p_u8: ?[*]u8,
        p_u16: ?[*]u16,
        p_u32: ?[*]u32,
        p_s32: ?[*]i32,
        p_s64: ?[*]i64,
        p_area: ?*Area,
        p_rect: ?*Rectangle,
        p_h264_sps: ?*H264Sps,
        p_h264_pps: ?*H264Pps,
        p_h264_scaling_matrix: ?*H264ScalingMatrix,
        p_h264_pred_weights: ?*H264PredWeights,
        p_h264_slice_params: ?*H264SliceParams,
        p_h264_decode_params: ?*H264DecodeParams,
        p_fwht_params: ?*FwhtParams,
        p_vp8_frame: ?*Vp8Frame,
        p_mpeg2_sequence: ?*Mpeg2Sequence,
        p_mpeg2_picture: ?*Mpeg2Picture,
        p_mpeg2_quantisation: ?*Mpeg2Quantisation,
        p_vp9_compressed_hdr_probs: ?*Vp9CompressedHdr,
        p_vp9_frame: ?*Vp9Frame,
        p_hevc_sps: ?*HevcSps,
        p_hevc_pps: ?*HevcPps,
        p_hevc_slice_params: ?*HevcSliceParams,
        p_hevc_scaling_matrix: ?*HevcScalingMatrix,
        p_hevc_decode_params: ?*HevcDecodeParams,
        p_av1_sequence: ?*Av1Sequence,
        p_av1_tile_group_entry: ?*Av1TileGroupEntry,
        p_av1_frame: ?*Av1Frame,
        p_av1_film_grain: ?*Av1FilmGrain,
        p_hdr10_cll_info: ?*Hdr10CllInfo,
        p_hdr10_mastering_display: ?*Hdr10MasteringDisplay,
        ptr: ?*anyopaque,
    },
};

pub const ExtSet = struct {
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
    integer = 1,
    boolean = 2,
    menu = 3,
    button = 4,
    integer64 = 5,
    class = 6,
    string = 7,
    bitmask = 8,
    integer_menu = 9,
    u8 = 0x0100,
    u16 = 0x0101,
    u32 = 0x0102,
    area = 0x0106,
    rect = 0x0107,
    hdr10_cll_info = 0x0110,
    hdr10_mastering_display = 0x0111,
    h264_sps = 0x0200,
    h264_pps = 0x0201,
    h264_scaling_matrix = 0x0202,
    h264_slice_params = 0x0203,
    h264_decode_params = 0x0204,
    h264_pred_weights = 0x0205,
    fwht_params = 0x0220,
    vp8_frame = 0x0240,
    mpeg2_quantisation = 0x0250,
    mpeg2_sequence = 0x0251,
    mpeg2_picture = 0x0252,
    vp9_compressed_hdr = 0x0260,
    vp9_frame = 0x0261,
    hevc_sps = 0x0270,
    hevc_pps = 0x0271,
    hevc_slice_params = 0x0272,
    hevc_scaling_matrix = 0x0273,
    hevc_decode_params = 0x0274,
    av1_sequence = 0x0280,
    av1_tile_group_entry = 0x0281,
    av1_frame = 0x0282,
    av1_film_grain = 0x0283,

    pub const compound_types: u32 = 0x0100;
};

pub const Flag = enum(u32) {
    disabled = 0x0001,
    grabbed = 0x0002,
    read_only = 0x0004,
    update = 0x0008,
    inactive = 0x0010,
    slider = 0x0020,
    write_only = 0x0040,
    @"volatile" = 0x0080,
    has_payload = 0x0100,
    execute_on_write = 0x0200,
    modify_layout = 0x0400,
    dynamic_array = 0x0800,
    has_which_min_max = 0x1000,
};

pub const Query = struct {
    id: u32,
    type: Type,
    name: [32]u8,
    minimum: i32,
    maximum: i32,
    step: i32,
    default_value: i32,
    flags: u32,
    reserved: [2]u32,
};

pub const ExtendedQuery = struct {
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
    id: u32,
    index: u32,
    value: extern union {
        name: [32]u8,
        s64: i64,
    },
    reserved: u32,
};
