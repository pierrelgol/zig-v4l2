const bindings = @import("bindings");
const std = @import("std");
const Buffer = @import("buffer.zig").Buffer;

comptime {
    std.testing.refAllDecls(@This());
}

pub const Capability = extern struct {
    driver: [16]u8,
    card: [32]u8,
    bus_info: [32]u8,
    version: u32,
    capabilities: u32,
    device_caps: u32,
    reserved: [3]u32,

    pub const Flag = struct {
        pub const video_capture: u32 = @intCast(bindings.V4L2_CAP_VIDEO_CAPTURE);
        pub const video_output: u32 = @intCast(bindings.V4L2_CAP_VIDEO_OUTPUT);
        pub const video_overlay: u32 = @intCast(bindings.V4L2_CAP_VIDEO_OVERLAY);
        pub const vbi_capture: u32 = @intCast(bindings.V4L2_CAP_VBI_CAPTURE);
        pub const vbi_output: u32 = @intCast(bindings.V4L2_CAP_VBI_OUTPUT);
        pub const sliced_vbi_capture: u32 = @intCast(bindings.V4L2_CAP_SLICED_VBI_CAPTURE);
        pub const sliced_vbi_output: u32 = @intCast(bindings.V4L2_CAP_SLICED_VBI_OUTPUT);
        pub const rds_capture: u32 = @intCast(bindings.V4L2_CAP_RDS_CAPTURE);
        pub const video_output_overlay: u32 = @intCast(bindings.V4L2_CAP_VIDEO_OUTPUT_OVERLAY);
        pub const hw_freq_seek: u32 = @intCast(bindings.V4L2_CAP_HW_FREQ_SEEK);
        pub const rds_output: u32 = @intCast(bindings.V4L2_CAP_RDS_OUTPUT);
        pub const video_capture_mplane: u32 = @intCast(bindings.V4L2_CAP_VIDEO_CAPTURE_MPLANE);
        pub const video_output_mplane: u32 = @intCast(bindings.V4L2_CAP_VIDEO_OUTPUT_MPLANE);
        pub const video_m2m_mplane: u32 = @intCast(bindings.V4L2_CAP_VIDEO_M2M_MPLANE);
        pub const video_m2m: u32 = @intCast(bindings.V4L2_CAP_VIDEO_M2M);
        pub const tuner: u32 = @intCast(bindings.V4L2_CAP_TUNER);
        pub const audio: u32 = @intCast(bindings.V4L2_CAP_AUDIO);
        pub const radio: u32 = @intCast(bindings.V4L2_CAP_RADIO);
        pub const modulator: u32 = @intCast(bindings.V4L2_CAP_MODULATOR);
        pub const sdr_capture: u32 = @intCast(bindings.V4L2_CAP_SDR_CAPTURE);
        pub const ext_pix_format: u32 = @intCast(bindings.V4L2_CAP_EXT_PIX_FORMAT);
        pub const sdr_output: u32 = @intCast(bindings.V4L2_CAP_SDR_OUTPUT);
        pub const meta_capture: u32 = @intCast(bindings.V4L2_CAP_META_CAPTURE);
        pub const readwrite: u32 = @intCast(bindings.V4L2_CAP_READWRITE);
        pub const edid: u32 = @intCast(bindings.V4L2_CAP_EDID);
        pub const streaming: u32 = @intCast(bindings.V4L2_CAP_STREAMING);
        pub const meta_output: u32 = @intCast(bindings.V4L2_CAP_META_OUTPUT);
        pub const touch: u32 = @intCast(bindings.V4L2_CAP_TOUCH);
        pub const io_mc: u32 = @intCast(bindings.V4L2_CAP_IO_MC);
        pub const device_caps: u32 = @intCast(bindings.V4L2_CAP_DEVICE_CAPS);

        pub const asyncio: u32 = edid;
    };

    pub const Description = extern struct {
        index: u32,
        type: u32,
        flags: u32,
        description: [32]u8,
        pixelformat: u32,
        mbus_code: u32,
        reserved: [3]u32,

        pub const FlagSet = struct {
            pub const compressed: u32 = @intCast(bindings.V4L2_FMT_FLAG_COMPRESSED);
            pub const emulated: u32 = @intCast(bindings.V4L2_FMT_FLAG_EMULATED);
            pub const continuous_bytestream: u32 = @intCast(bindings.V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM);
            pub const dyn_resolution: u32 = @intCast(bindings.V4L2_FMT_FLAG_DYN_RESOLUTION);
            pub const enc_cap_frame_interval: u32 = @intCast(bindings.V4L2_FMT_FLAG_ENC_CAP_FRAME_INTERVAL);
            pub const csc_colorspace: u32 = @intCast(bindings.V4L2_FMT_FLAG_CSC_COLORSPACE);
            pub const csc_xfer_func: u32 = @intCast(bindings.V4L2_FMT_FLAG_CSC_XFER_FUNC);
            pub const csc_ycbcr_enc: u32 = @intCast(bindings.V4L2_FMT_FLAG_CSC_YCBCR_ENC);
            pub const csc_quantization: u32 = @intCast(bindings.V4L2_FMT_FLAG_CSC_QUANTIZATION);
            pub const meta_line_based: u32 = @intCast(bindings.V4L2_FMT_FLAG_META_LINE_BASED);

            pub const csc_hsv_enc: u32 = csc_ycbcr_enc;
            pub const enum_all: u32 = @intCast(bindings.V4L2_FMT_FLAG_ENUM_ALL);
        };
    };
};

test "Capability.Flag aliases match linux/videodev2.h" {
    try std.testing.expectEqual(Capability.Flag.edid, Capability.Flag.asyncio);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.V4L2_CAP_ASYNCIO)), Capability.Flag.asyncio);
}

test "Capability ABI matches struct_v4l2_capability" {
    const C = bindings.struct_v4l2_capability;
    const Z = Capability;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "driver"), @offsetOf(Z, "driver"));
    try std.testing.expectEqual(@offsetOf(C, "card"), @offsetOf(Z, "card"));
    try std.testing.expectEqual(@offsetOf(C, "bus_info"), @offsetOf(Z, "bus_info"));
    try std.testing.expectEqual(@offsetOf(C, "version"), @offsetOf(Z, "version"));
    try std.testing.expectEqual(@offsetOf(C, "capabilities"), @offsetOf(Z, "capabilities"));
    try std.testing.expectEqual(@offsetOf(C, "device_caps"), @offsetOf(Z, "device_caps"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Capability.Description ABI matches struct_v4l2_fmtdesc" {
    const C = bindings.struct_v4l2_fmtdesc;
    const Z = Capability.Description;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "index"), @offsetOf(Z, "index"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "description"), @offsetOf(Z, "description"));
    try std.testing.expectEqual(@offsetOf(C, "pixelformat"), @offsetOf(Z, "pixelformat"));
    try std.testing.expectEqual(@offsetOf(C, "mbus_code"), @offsetOf(Z, "mbus_code"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}
