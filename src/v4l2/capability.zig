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

    pub const Flag = enum(u32) {
        video_capture = @intCast(bindings.V4L2_CAP_VIDEO_CAPTURE),
        video_output = @intCast(bindings.V4L2_CAP_VIDEO_OUTPUT),
        video_overlay = @intCast(bindings.V4L2_CAP_VIDEO_OVERLAY),
        vbi_capture = @intCast(bindings.V4L2_CAP_VBI_CAPTURE),
        vbi_output = @intCast(bindings.V4L2_CAP_VBI_OUTPUT),
        sliced_vbi_capture = @intCast(bindings.V4L2_CAP_SLICED_VBI_CAPTURE),
        sliced_vbi_output = @intCast(bindings.V4L2_CAP_SLICED_VBI_OUTPUT),
        rds_capture = @intCast(bindings.V4L2_CAP_RDS_CAPTURE),
        video_output_overlay = @intCast(bindings.V4L2_CAP_VIDEO_OUTPUT_OVERLAY),
        hw_freq_seek = @intCast(bindings.V4L2_CAP_HW_FREQ_SEEK),
        rds_output = @intCast(bindings.V4L2_CAP_RDS_OUTPUT),
        video_capture_mplane = @intCast(bindings.V4L2_CAP_VIDEO_CAPTURE_MPLANE),
        video_output_mplane = @intCast(bindings.V4L2_CAP_VIDEO_OUTPUT_MPLANE),
        video_m2m_mplane = @intCast(bindings.V4L2_CAP_VIDEO_M2M_MPLANE),
        video_m2m = @intCast(bindings.V4L2_CAP_VIDEO_M2M),
        tuner = @intCast(bindings.V4L2_CAP_TUNER),
        audio = @intCast(bindings.V4L2_CAP_AUDIO),
        radio = @intCast(bindings.V4L2_CAP_RADIO),
        modulator = @intCast(bindings.V4L2_CAP_MODULATOR),
        sdr_capture = @intCast(bindings.V4L2_CAP_SDR_CAPTURE),
        ext_pix_format = @intCast(bindings.V4L2_CAP_EXT_PIX_FORMAT),
        sdr_output = @intCast(bindings.V4L2_CAP_SDR_OUTPUT),
        meta_capture = @intCast(bindings.V4L2_CAP_META_CAPTURE),
        readwrite = @intCast(bindings.V4L2_CAP_READWRITE),
        edid = @intCast(bindings.V4L2_CAP_EDID),
        streaming = @intCast(bindings.V4L2_CAP_STREAMING),
        meta_output = @intCast(bindings.V4L2_CAP_META_OUTPUT),
        touch = @intCast(bindings.V4L2_CAP_TOUCH),
        io_mc = @intCast(bindings.V4L2_CAP_IO_MC),
        device_caps = @intCast(bindings.V4L2_CAP_DEVICE_CAPS),
    };

    pub const Description = extern struct {
        index: u32,
        type: u32,
        flags: u32,
        description: [32]u8,
        pixelformat: u32,
        mbus_code: u32,
        reserved: [3]u32,

        pub const FlagSet = enum(u32) {
            compressed = @intCast(bindings.V4L2_FMT_FLAG_COMPRESSED),
            emulated = @intCast(bindings.V4L2_FMT_FLAG_EMULATED),
            continuous_bytestream = @intCast(bindings.V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM),
            dyn_resolution = @intCast(bindings.V4L2_FMT_FLAG_DYN_RESOLUTION),
            enc_cap_frame_interval = @intCast(bindings.V4L2_FMT_FLAG_ENC_CAP_FRAME_INTERVAL),
            csc_colorspace = @intCast(bindings.V4L2_FMT_FLAG_CSC_COLORSPACE),
            csc_xfer_func = @intCast(bindings.V4L2_FMT_FLAG_CSC_XFER_FUNC),
            csc_ycbcr_enc = @intCast(bindings.V4L2_FMT_FLAG_CSC_YCBCR_ENC),
            csc_quantization = @intCast(bindings.V4L2_FMT_FLAG_CSC_QUANTIZATION),
            meta_line_based = @intCast(bindings.V4L2_FMT_FLAG_META_LINE_BASED),

            pub const csc_hsv_enc: FlagSet = .csc_ycbcr_enc;
            pub const enum_all: u32 = @intCast(bindings.V4L2_FMT_FLAG_ENUM_ALL);
        };
    };
};

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
