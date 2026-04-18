const std = @import("std");

const c = @import("bindings");
const abi = @import("../../abi.zig");
pub const version: u32 = c.V4L2_FWHT_VERSION;
// @TODO  WIP
// pub const isInterlaced = c.V4L2_FWHT_FL_IS_INTERLACED;
// pub const isBottomFirst = c.V4L2_FWHT_FL_IS_INTERLACED;
// pub const isAlternate = c.V4L2_FWHT_FL_IS_ALTERNATE;
// pub const isBottomField = c.V4L2_FWHT_FL_IS_BOTTOM_FIELD;
// pub const isLumaUncompressed = c.V4L2_FWHT_FL_LUMA_IS_UNCOMPRESSED;
// pub const isCbUncompressed = c.V4L2_FWHT_FL_CB_IS_UNCOMPRESSED;
// pub const isCrUncompressed = c.V4L2_FWHT_FL_CR_IS_UNCOMPRESSED;
// pub const isChromaFullHeight = c.V4L2_FWHT_FL_CHROMA_FULL_HEIGHT;
// pub const isChromaFullWidth = c.V4L2_FWHT_FL_CHROMA_FULL_WIDTH;
// pub const isAlphaUncompressed = c.V4L2_FWHT_FL_ALPHA_IS_UNCOMPRESSED;
// pub const isIFrame = c.V4L2_FWHT_FL_I_FRAME;
// pub const componentsNumberOffset = c.V4L2_FWHT_FL_COMPONENTS_NUM_OFFSET;
// pub const pixelEncodingOffset = c.V4L2_FWHT_FL_PIXENC_OFFSET;
// pub const pixelEncodingYuv = c.V4L2_FWHT_FL_PIXENC_YUV;
// pub const pixelEncodingRgb = c.V4L2_FWHT_FL_PIXENC_RGB;
// pub const pixelEncodingHsv = c.V4L2_FWHT_FL_PIXENC_HSV;

pub const fwht = @This();

comptime {
    std.testing.refAllDecls(@This());
}

pub const params = extern struct {
    pub const id: u32 = c.V4L2_CID_STATELESS_FWHT_PARAMS;

    backward_ref_ts: u64,
    version: u32,
    width: u32,
    height: u32,
    flags: u32,
    colorspace: u32,
    xfer_func: u32,
    ycbcr_enc: u32,
    quantization: u32,
};

test "stateless.fwht.params ABI matches struct_v4l2_ctrl_fwht_params" {
    const C = c.struct_v4l2_ctrl_fwht_params;
    const Z = params;
    try abi.expectStruct(C, Z, &.{
        .{ .c_name = "backward_ref_ts", .z_name = "backward_ref_ts" },
        .{ .c_name = "version", .z_name = "version" },
        .{ .c_name = "width", .z_name = "width" },
        .{ .c_name = "height", .z_name = "height" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "colorspace", .z_name = "colorspace" },
        .{ .c_name = "xfer_func", .z_name = "xfer_func" },
        .{ .c_name = "ycbcr_enc", .z_name = "ycbcr_enc" },
        .{ .c_name = "quantization", .z_name = "quantization" },
    });
}

// pub const componentsNumberMask = DONT_TOUCH.genmask(c_long, 18, 16);
// pub const pixelEncodingMask = DONT_TOUCH.genmask(c_long, 20, 19);
// comptime {
//     std.testing.refAllDecls(@This());
// }

// const DONT_TOUCH = struct {
//     fn genmask(comptime T: type, hi: u6, lo: u6) T {
//         comptime {
//             if (!@typeInfo(T)..is_signed)
//                 @compileError("T must be an unsigned integer type");
//             if (hi < lo)
//                 @compileError("hi must be >= lo");
//             if (hi >= @bitSizeOf(T))
//                 @compileError("hi out of range for type");
//         }

//         const all_ones: T = ~@as(T, 0);

//         return (all_ones >> (@bitSizeOf(T) - 1 - hi)) &
//             (all_ones << lo);
//     }
// };
