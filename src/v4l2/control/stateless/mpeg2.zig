const std = @import("std");

const c = @import("bindings");
pub const mpeg2 = @This();

comptime {
    std.testing.refAllDecls(@This());
}

pub const sequence = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_MPEG2_SEQUENCE;

    pub const Ctrl = extern struct {
        horizontal_size: u16,
        vertical_size: u16,
        vbv_buffer_size: u32,
        profile_and_level_indication: u16,
        chroma_format: u8,
        flags: u8,
    };
};

pub const picture = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_MPEG2_PICTURE;

    pub const CodingType = enum(i32) {
        i = c.V4L2_MPEG2_PIC_CODING_TYPE_I,
        p = c.V4L2_MPEG2_PIC_CODING_TYPE_P,
        b = c.V4L2_MPEG2_PIC_CODING_TYPE_B,
        d = c.V4L2_MPEG2_PIC_CODING_TYPE_D,
    };

    pub const Field = enum(i32) {
        top = c.V4L2_MPEG2_PIC_TOP_FIELD,
        bottom = c.V4L2_MPEG2_PIC_BOTTOM_FIELD,
        frame = c.V4L2_MPEG2_PIC_FRAME,
    };

    pub const Flag = enum(i32) {
        top_field_first = c.V4L2_MPEG2_PIC_FLAG_TOP_FIELD_FIRST,
        frame_pred_dct = c.V4L2_MPEG2_PIC_FLAG_FRAME_PRED_DCT,
        concealment_mv = c.V4L2_MPEG2_PIC_FLAG_CONCEALMENT_MV,
        q_scale_type = c.V4L2_MPEG2_PIC_FLAG_Q_SCALE_TYPE,
        intra_vlc = c.V4L2_MPEG2_PIC_FLAG_INTRA_VLC,
        alt_scan = c.V4L2_MPEG2_PIC_FLAG_ALT_SCAN,
        repeat_first = c.V4L2_MPEG2_PIC_FLAG_REPEAT_FIRST,
        progressive = c.V4L2_MPEG2_PIC_FLAG_PROGRESSIVE,
    };

    pub const Ctrl = extern struct {
        backward_ref_ts: u64,
        forward_ref_ts: u64,
        flags: u32,
        f_code: [2][2]u8,
        picture_coding_type: u8,
        picture_structure: u8,
        intra_dc_precision: u8,
        reserved: [5]u8,
    };
};

pub const quantisation = struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_MPEG2_QUANTISATION;

    pub const Ctrl = extern struct {
        intra_quantiser_matrix: [64]u8,
        non_intra_quantiser_matrix: [64]u8,
        chroma_intra_quantiser_matrix: [64]u8,
        chroma_non_intra_quantiser_matrix: [64]u8,
    };
};

test "stateless.mpeg2.sequence.Ctrl ABI matches struct_v4l2_ctrl_mpeg2_sequence" {
    const C = c.struct_v4l2_ctrl_mpeg2_sequence;
    const Z = mpeg2.sequence.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "horizontal_size"), @offsetOf(Z, "horizontal_size"));
    try std.testing.expectEqual(@offsetOf(C, "vertical_size"), @offsetOf(Z, "vertical_size"));
    try std.testing.expectEqual(@offsetOf(C, "vbv_buffer_size"), @offsetOf(Z, "vbv_buffer_size"));
    try std.testing.expectEqual(@offsetOf(C, "profile_and_level_indication"), @offsetOf(Z, "profile_and_level_indication"));
    try std.testing.expectEqual(@offsetOf(C, "chroma_format"), @offsetOf(Z, "chroma_format"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
}

test "stateless.mpeg2.picture.Ctrl ABI matches struct_v4l2_ctrl_mpeg2_picture" {
    const C = c.struct_v4l2_ctrl_mpeg2_picture;
    const Z = mpeg2.picture.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "backward_ref_ts"), @offsetOf(Z, "backward_ref_ts"));
    try std.testing.expectEqual(@offsetOf(C, "forward_ref_ts"), @offsetOf(Z, "forward_ref_ts"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "f_code"), @offsetOf(Z, "f_code"));
    try std.testing.expectEqual(@offsetOf(C, "picture_coding_type"), @offsetOf(Z, "picture_coding_type"));
    try std.testing.expectEqual(@offsetOf(C, "picture_structure"), @offsetOf(Z, "picture_structure"));
    try std.testing.expectEqual(@offsetOf(C, "intra_dc_precision"), @offsetOf(Z, "intra_dc_precision"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "stateless.mpeg2.quantisation.Ctrl ABI matches struct_v4l2_ctrl_mpeg2_quantisation" {
    const C = c.struct_v4l2_ctrl_mpeg2_quantisation;
    const Z = mpeg2.quantisation.Ctrl;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "intra_quantiser_matrix"), @offsetOf(Z, "intra_quantiser_matrix"));
    try std.testing.expectEqual(@offsetOf(C, "non_intra_quantiser_matrix"), @offsetOf(Z, "non_intra_quantiser_matrix"));
    try std.testing.expectEqual(@offsetOf(C, "chroma_intra_quantiser_matrix"), @offsetOf(Z, "chroma_intra_quantiser_matrix"));
    try std.testing.expectEqual(@offsetOf(C, "chroma_non_intra_quantiser_matrix"), @offsetOf(Z, "chroma_non_intra_quantiser_matrix"));
}
