const bindings = @import("bindings");
const std = @import("std");
const builtin = @import("builtin");

comptime {
    std.testing.refAllDecls(@This());
}

pub const Pixel = extern struct {
    width: u32,
    height: u32,
    pixel_format: u32,
    field: u32,
    bytes_per_line: u32,
    size_image: u32,
    colorspace: u32,
    priv: u32,
    flags: u32,
    encoding: Encoding,
    quantization: u32,
    xfer_func: u32,

    pub fn fourcc(a: u8, b: u8, c: u8, d: u8) u32 {
        return (@as(u32, a)) | (@as(u32, b) << 8) | (@as(u32, c) << 16) | (@as(u32, d) << 24);
    }

    pub fn fourcc_be(a: u8, b: u8, c: u8, d: u8) u32 {
        return fourcc(a, b, c, d) | (@as(u32, 1) << 31);
    }

    pub const private_magic: u32 = 0xfeedcafe;
    pub const max_planes: u32 = 8;

    pub const Plane = extern struct {
        sizeimage: u32 align(1),
        bytesperline: u32 align(1),
        reserved: [6]u16 align(1),
    };

    pub const Mplane = extern struct {
        width: u32 align(1),
        height: u32 align(1),
        pixelformat: u32 align(1),
        field: u32 align(1),
        colorspace: u32 align(1),
        plane_fmt: [max_planes]Plane,
        num_planes: u8,
        flags: u8,
        encoding: u8,
        quantization: u8,
        xfer_func: u8,
        reserved: [7]u8,
    };

    pub const SdrFormat = extern struct {
        pixelformat: u32 align(1),
        buffersize: u32 align(1),
        reserved: [24]u8,
    };

    pub const MetaFormat = extern struct {
        dataformat: u32 align(1),
        buffersize: u32 align(1),
        width: u32 align(1),
        height: u32 align(1),
        bytesperline: u32 align(1),
    };

    pub const Encoding = extern union {
        ycbcr: u32,
        hsv: u32,
    };

    pub const YCbCrEncoding = enum(u32) {
        default = @intCast(bindings.V4L2_YCBCR_ENC_DEFAULT),
        _601 = @intCast(bindings.V4L2_YCBCR_ENC_601),
        _709 = @intCast(bindings.V4L2_YCBCR_ENC_709),
        xv601 = @intCast(bindings.V4L2_YCBCR_ENC_XV601),
        xv709 = @intCast(bindings.V4L2_YCBCR_ENC_XV709),
        sycc = @intCast(bindings.V4L2_YCBCR_ENC_SYCC),
        bt2020 = @intCast(bindings.V4L2_YCBCR_ENC_BT2020),
        bt2020_const_lum = @intCast(bindings.V4L2_YCBCR_ENC_BT2020_CONST_LUM),
        smpte240m = @intCast(bindings.V4L2_YCBCR_ENC_SMPTE240M),

        pub fn getDefault(cs: Colorspace) YCbCrEncoding {
            return switch (cs) {
                .rec709, .dci_p3 => ._709,
                .bt2020 => .bt2020,
                .smpte240m => .smpte240m,
                else => ._601,
            };
        }
    };

    pub const HsvEncoding = enum(u32) {
        _180 = @intCast(bindings.V4L2_HSV_ENC_180),
        _256 = @intCast(bindings.V4L2_HSV_ENC_256),
    };

    pub const Format = enum(u32) {
        rgb332 = bindings.V4L2_PIX_FMT_RGB332,
        rgb444 = bindings.V4L2_PIX_FMT_RGB444,
        argb444 = bindings.V4L2_PIX_FMT_ARGB444,
        xrgb444 = bindings.V4L2_PIX_FMT_XRGB444,
        rgba444 = bindings.V4L2_PIX_FMT_RGBA444,
        rgbx444 = bindings.V4L2_PIX_FMT_RGBX444,
        abgr444 = bindings.V4L2_PIX_FMT_ABGR444,
        xbgr444 = bindings.V4L2_PIX_FMT_XBGR444,
        bgra444 = bindings.V4L2_PIX_FMT_BGRA444,
        bgrx444 = bindings.V4L2_PIX_FMT_BGRX444,
        rgb555 = bindings.V4L2_PIX_FMT_RGB555,
        argb555 = bindings.V4L2_PIX_FMT_ARGB555,
        xrgb555 = bindings.V4L2_PIX_FMT_XRGB555,
        rgba555 = bindings.V4L2_PIX_FMT_RGBA555,
        rgbx555 = bindings.V4L2_PIX_FMT_RGBX555,
        abgr555 = bindings.V4L2_PIX_FMT_ABGR555,
        xbgr555 = bindings.V4L2_PIX_FMT_XBGR555,
        bgra555 = bindings.V4L2_PIX_FMT_BGRA555,
        bgrx555 = bindings.V4L2_PIX_FMT_BGRX555,
        rgb565 = bindings.V4L2_PIX_FMT_RGB565,
        rgb555x = bindings.V4L2_PIX_FMT_RGB555X,
        argb555x = bindings.V4L2_PIX_FMT_ARGB555X,
        xrgb555x = bindings.V4L2_PIX_FMT_XRGB555X,
        rgb565x = bindings.V4L2_PIX_FMT_RGB565X,
        bgr666 = bindings.V4L2_PIX_FMT_BGR666,
        bgr24 = bindings.V4L2_PIX_FMT_BGR24,
        rgb24 = bindings.V4L2_PIX_FMT_RGB24,
        bgr32 = bindings.V4L2_PIX_FMT_BGR32,
        abgr32 = bindings.V4L2_PIX_FMT_ABGR32,
        xbgr32 = bindings.V4L2_PIX_FMT_XBGR32,
        bgra32 = bindings.V4L2_PIX_FMT_BGRA32,
        bgrx32 = bindings.V4L2_PIX_FMT_BGRX32,
        rgb32 = bindings.V4L2_PIX_FMT_RGB32,
        rgba32 = bindings.V4L2_PIX_FMT_RGBA32,
        rgbx32 = bindings.V4L2_PIX_FMT_RGBX32,
        argb32 = bindings.V4L2_PIX_FMT_ARGB32,
        xrgb32 = bindings.V4L2_PIX_FMT_XRGB32,
        rgbx1010102 = bindings.V4L2_PIX_FMT_RGBX1010102,
        rgba1010102 = bindings.V4L2_PIX_FMT_RGBA1010102,
        argb2101010 = bindings.V4L2_PIX_FMT_ARGB2101010,
        bgr48_12 = bindings.V4L2_PIX_FMT_BGR48_12,
        bgr48 = bindings.V4L2_PIX_FMT_BGR48,
        rgb48 = bindings.V4L2_PIX_FMT_RGB48,
        abgr64_12 = bindings.V4L2_PIX_FMT_ABGR64_12,
        grey = bindings.V4L2_PIX_FMT_GREY,
        y4 = bindings.V4L2_PIX_FMT_Y4,
        y6 = bindings.V4L2_PIX_FMT_Y6,
        y10 = bindings.V4L2_PIX_FMT_Y10,
        y12 = bindings.V4L2_PIX_FMT_Y12,
        y012 = bindings.V4L2_PIX_FMT_Y012,
        y14 = bindings.V4L2_PIX_FMT_Y14,
        y16 = bindings.V4L2_PIX_FMT_Y16,
        y16_be = bindings.V4L2_PIX_FMT_Y16_BE,
        y10bpack = bindings.V4L2_PIX_FMT_Y10BPACK,
        y10p = bindings.V4L2_PIX_FMT_Y10P,
        ipu3_y10 = bindings.V4L2_PIX_FMT_IPU3_Y10,
        y12p = bindings.V4L2_PIX_FMT_Y12P,
        y14p = bindings.V4L2_PIX_FMT_Y14P,
        pal8 = bindings.V4L2_PIX_FMT_PAL8,
        uv8 = bindings.V4L2_PIX_FMT_UV8,
        yuyv = bindings.V4L2_PIX_FMT_YUYV,
        yyuv = bindings.V4L2_PIX_FMT_YYUV,
        yvyu = bindings.V4L2_PIX_FMT_YVYU,
        uyvy = bindings.V4L2_PIX_FMT_UYVY,
        vyuy = bindings.V4L2_PIX_FMT_VYUY,
        y41p = bindings.V4L2_PIX_FMT_Y41P,
        yuv444 = bindings.V4L2_PIX_FMT_YUV444,
        yuv555 = bindings.V4L2_PIX_FMT_YUV555,
        yuv565 = bindings.V4L2_PIX_FMT_YUV565,
        yuv24 = bindings.V4L2_PIX_FMT_YUV24,
        yuv32 = bindings.V4L2_PIX_FMT_YUV32,
        ayuv32 = bindings.V4L2_PIX_FMT_AYUV32,
        xyuv32 = bindings.V4L2_PIX_FMT_XYUV32,
        vuya32 = bindings.V4L2_PIX_FMT_VUYA32,
        vuyx32 = bindings.V4L2_PIX_FMT_VUYX32,
        yuva32 = bindings.V4L2_PIX_FMT_YUVA32,
        yuvx32 = bindings.V4L2_PIX_FMT_YUVX32,
        m420 = bindings.V4L2_PIX_FMT_M420,
        yuv48_12 = bindings.V4L2_PIX_FMT_YUV48_12,
        y210 = bindings.V4L2_PIX_FMT_Y210,
        y212 = bindings.V4L2_PIX_FMT_Y212,
        y216 = bindings.V4L2_PIX_FMT_Y216,
        nv12 = bindings.V4L2_PIX_FMT_NV12,
        nv21 = bindings.V4L2_PIX_FMT_NV21,
        nv15 = bindings.V4L2_PIX_FMT_NV15,
        nv16 = bindings.V4L2_PIX_FMT_NV16,
        nv61 = bindings.V4L2_PIX_FMT_NV61,
        nv20 = bindings.V4L2_PIX_FMT_NV20,
        nv24 = bindings.V4L2_PIX_FMT_NV24,
        nv42 = bindings.V4L2_PIX_FMT_NV42,
        p010 = bindings.V4L2_PIX_FMT_P010,
        p012 = bindings.V4L2_PIX_FMT_P012,
        nv12m = bindings.V4L2_PIX_FMT_NV12M,
        nv21m = bindings.V4L2_PIX_FMT_NV21M,
        nv16m = bindings.V4L2_PIX_FMT_NV16M,
        nv61m = bindings.V4L2_PIX_FMT_NV61M,
        p012m = bindings.V4L2_PIX_FMT_P012M,
        yuv410 = bindings.V4L2_PIX_FMT_YUV410,
        yvu410 = bindings.V4L2_PIX_FMT_YVU410,
        yuv411p = bindings.V4L2_PIX_FMT_YUV411P,
        yuv420 = bindings.V4L2_PIX_FMT_YUV420,
        yvu420 = bindings.V4L2_PIX_FMT_YVU420,
        yuv422p = bindings.V4L2_PIX_FMT_YUV422P,
        yuv420m = bindings.V4L2_PIX_FMT_YUV420M,
        yvu420m = bindings.V4L2_PIX_FMT_YVU420M,
        yuv422m = bindings.V4L2_PIX_FMT_YUV422M,
        yvu422m = bindings.V4L2_PIX_FMT_YVU422M,
        yuv444m = bindings.V4L2_PIX_FMT_YUV444M,
        yvu444m = bindings.V4L2_PIX_FMT_YVU444M,
        nv12_4l4 = bindings.V4L2_PIX_FMT_NV12_4L4,
        nv12_16l16 = bindings.V4L2_PIX_FMT_NV12_16L16,
        nv12_32l32 = bindings.V4L2_PIX_FMT_NV12_32L32,
        nv15_4l4 = bindings.V4L2_PIX_FMT_NV15_4L4,
        p010_4l4 = bindings.V4L2_PIX_FMT_P010_4L4,
        nv12_8l128 = bindings.V4L2_PIX_FMT_NV12_8L128,
        nv12_10be_8l128 = bindings.V4L2_PIX_FMT_NV12_10BE_8L128,
        nv12mt = bindings.V4L2_PIX_FMT_NV12MT,
        nv12mt_16x16 = bindings.V4L2_PIX_FMT_NV12MT_16X16,
        nv12m_8l128 = bindings.V4L2_PIX_FMT_NV12M_8L128,
        nv12m_10be_8l128 = bindings.V4L2_PIX_FMT_NV12M_10BE_8L128,
        sbggr8 = bindings.V4L2_PIX_FMT_SBGGR8,
        sgbrg8 = bindings.V4L2_PIX_FMT_SGBRG8,
        sgrbg8 = bindings.V4L2_PIX_FMT_SGRBG8,
        srggb8 = bindings.V4L2_PIX_FMT_SRGGB8,
        sbggr10 = bindings.V4L2_PIX_FMT_SBGGR10,
        sgbrg10 = bindings.V4L2_PIX_FMT_SGBRG10,
        sgrbg10 = bindings.V4L2_PIX_FMT_SGRBG10,
        srggb10 = bindings.V4L2_PIX_FMT_SRGGB10,
        sbggr10p = bindings.V4L2_PIX_FMT_SBGGR10P,
        sgbrg10p = bindings.V4L2_PIX_FMT_SGBRG10P,
        sgrbg10p = bindings.V4L2_PIX_FMT_SGRBG10P,
        srggb10p = bindings.V4L2_PIX_FMT_SRGGB10P,
        sbggr10alaw8 = bindings.V4L2_PIX_FMT_SBGGR10ALAW8,
        sgbrg10alaw8 = bindings.V4L2_PIX_FMT_SGBRG10ALAW8,
        sgrbg10alaw8 = bindings.V4L2_PIX_FMT_SGRBG10ALAW8,
        srggb10alaw8 = bindings.V4L2_PIX_FMT_SRGGB10ALAW8,
        sbggr10dpcm8 = bindings.V4L2_PIX_FMT_SBGGR10DPCM8,
        sgbrg10dpcm8 = bindings.V4L2_PIX_FMT_SGBRG10DPCM8,
        sgrbg10dpcm8 = bindings.V4L2_PIX_FMT_SGRBG10DPCM8,
        srggb10dpcm8 = bindings.V4L2_PIX_FMT_SRGGB10DPCM8,
        sbggr12 = bindings.V4L2_PIX_FMT_SBGGR12,
        sgbrg12 = bindings.V4L2_PIX_FMT_SGBRG12,
        sgrbg12 = bindings.V4L2_PIX_FMT_SGRBG12,
        srggb12 = bindings.V4L2_PIX_FMT_SRGGB12,
        sbggr12p = bindings.V4L2_PIX_FMT_SBGGR12P,
        sgbrg12p = bindings.V4L2_PIX_FMT_SGBRG12P,
        sgrbg12p = bindings.V4L2_PIX_FMT_SGRBG12P,
        srggb12p = bindings.V4L2_PIX_FMT_SRGGB12P,
        sbggr14 = bindings.V4L2_PIX_FMT_SBGGR14,
        sgbrg14 = bindings.V4L2_PIX_FMT_SGBRG14,
        sgrbg14 = bindings.V4L2_PIX_FMT_SGRBG14,
        srggb14 = bindings.V4L2_PIX_FMT_SRGGB14,
        sbggr14p = bindings.V4L2_PIX_FMT_SBGGR14P,
        sgbrg14p = bindings.V4L2_PIX_FMT_SGBRG14P,
        sgrbg14p = bindings.V4L2_PIX_FMT_SGRBG14P,
        srggb14p = bindings.V4L2_PIX_FMT_SRGGB14P,
        sbggr16 = bindings.V4L2_PIX_FMT_SBGGR16,
        sgbrg16 = bindings.V4L2_PIX_FMT_SGBRG16,
        sgrbg16 = bindings.V4L2_PIX_FMT_SGRBG16,
        srggb16 = bindings.V4L2_PIX_FMT_SRGGB16,
        hsv24 = bindings.V4L2_PIX_FMT_HSV24,
        hsv32 = bindings.V4L2_PIX_FMT_HSV32,
        mjpeg = bindings.V4L2_PIX_FMT_MJPEG,
        jpeg = bindings.V4L2_PIX_FMT_JPEG,
        dv = bindings.V4L2_PIX_FMT_DV,
        mpeg = bindings.V4L2_PIX_FMT_MPEG,
        h264 = bindings.V4L2_PIX_FMT_H264,
        h264_no_sc = bindings.V4L2_PIX_FMT_H264_NO_SC,
        h264_mvc = bindings.V4L2_PIX_FMT_H264_MVC,
        h263 = bindings.V4L2_PIX_FMT_H263,
        mpeg1 = bindings.V4L2_PIX_FMT_MPEG1,
        mpeg2 = bindings.V4L2_PIX_FMT_MPEG2,
        mpeg2_slice = bindings.V4L2_PIX_FMT_MPEG2_SLICE,
        mpeg4 = bindings.V4L2_PIX_FMT_MPEG4,
        xvid = bindings.V4L2_PIX_FMT_XVID,
        vc1_annex_g = bindings.V4L2_PIX_FMT_VC1_ANNEX_G,
        vc1_annex_l = bindings.V4L2_PIX_FMT_VC1_ANNEX_L,
        vp8 = bindings.V4L2_PIX_FMT_VP8,
        vp8_frame = bindings.V4L2_PIX_FMT_VP8_FRAME,
        vp9 = bindings.V4L2_PIX_FMT_VP9,
        vp9_frame = bindings.V4L2_PIX_FMT_VP9_FRAME,
        hevc = bindings.V4L2_PIX_FMT_HEVC,
        fwht = bindings.V4L2_PIX_FMT_FWHT,
        fwht_stateless = bindings.V4L2_PIX_FMT_FWHT_STATELESS,
        h264_slice = bindings.V4L2_PIX_FMT_H264_SLICE,
        hevc_slice = bindings.V4L2_PIX_FMT_HEVC_SLICE,
        av1_frame = bindings.V4L2_PIX_FMT_AV1_FRAME,
        spk = bindings.V4L2_PIX_FMT_SPK,
        rv30 = bindings.V4L2_PIX_FMT_RV30,
        rv40 = bindings.V4L2_PIX_FMT_RV40,
        cpia1 = bindings.V4L2_PIX_FMT_CPIA1,
        wnva = bindings.V4L2_PIX_FMT_WNVA,
        sn9c10x = bindings.V4L2_PIX_FMT_SN9C10X,
        sn9c20x_i420 = bindings.V4L2_PIX_FMT_SN9C20X_I420,
        pwc1 = bindings.V4L2_PIX_FMT_PWC1,
        pwc2 = bindings.V4L2_PIX_FMT_PWC2,
        et61x251 = bindings.V4L2_PIX_FMT_ET61X251,
        spca501 = bindings.V4L2_PIX_FMT_SPCA501,
        spca505 = bindings.V4L2_PIX_FMT_SPCA505,
        spca508 = bindings.V4L2_PIX_FMT_SPCA508,
        spca561 = bindings.V4L2_PIX_FMT_SPCA561,
        pac207 = bindings.V4L2_PIX_FMT_PAC207,
        mr97310a = bindings.V4L2_PIX_FMT_MR97310A,
        jl2005bcd = bindings.V4L2_PIX_FMT_JL2005BCD,
        sn9c2028 = bindings.V4L2_PIX_FMT_SN9C2028,
        sq905c = bindings.V4L2_PIX_FMT_SQ905C,
        pjpg = bindings.V4L2_PIX_FMT_PJPG,
        ov511 = bindings.V4L2_PIX_FMT_OV511,
        ov518 = bindings.V4L2_PIX_FMT_OV518,
        stv0680 = bindings.V4L2_PIX_FMT_STV0680,
        tm6000 = bindings.V4L2_PIX_FMT_TM6000,
        cit_yyvyuy = bindings.V4L2_PIX_FMT_CIT_YYVYUY,
        konica420 = bindings.V4L2_PIX_FMT_KONICA420,
        jpgl = bindings.V4L2_PIX_FMT_JPGL,
        se401 = bindings.V4L2_PIX_FMT_SE401,
        s5c_uyvy_jpg = bindings.V4L2_PIX_FMT_S5C_UYVY_JPG,
        y8i = bindings.V4L2_PIX_FMT_Y8I,
        y12i = bindings.V4L2_PIX_FMT_Y12I,
        y16i = bindings.V4L2_PIX_FMT_Y16I,
        z16 = bindings.V4L2_PIX_FMT_Z16,
        mt21c = bindings.V4L2_PIX_FMT_MT21C,
        mm21 = bindings.V4L2_PIX_FMT_MM21,
        mt2110t = bindings.V4L2_PIX_FMT_MT2110T,
        mt2110r = bindings.V4L2_PIX_FMT_MT2110R,
        inzi = bindings.V4L2_PIX_FMT_INZI,
        cnf4 = bindings.V4L2_PIX_FMT_CNF4,
        hi240 = bindings.V4L2_PIX_FMT_HI240,
        qc08c = bindings.V4L2_PIX_FMT_QC08C,
        qc10c = bindings.V4L2_PIX_FMT_QC10C,
        ajpg = bindings.V4L2_PIX_FMT_AJPG,
        hextile = bindings.V4L2_PIX_FMT_HEXTILE,
        ipu3_sbggr10 = bindings.V4L2_PIX_FMT_IPU3_SBGGR10,
        ipu3_sgbrg10 = bindings.V4L2_PIX_FMT_IPU3_SGBRG10,
        ipu3_sgrbg10 = bindings.V4L2_PIX_FMT_IPU3_SGRBG10,
        ipu3_srggb10 = bindings.V4L2_PIX_FMT_IPU3_SRGGB10,
        pisp_comp1_rggb = bindings.V4L2_PIX_FMT_PISP_COMP1_RGGB,
        pisp_comp1_grbg = bindings.V4L2_PIX_FMT_PISP_COMP1_GRBG,
        pisp_comp1_gbrg = bindings.V4L2_PIX_FMT_PISP_COMP1_GBRG,
        pisp_comp1_bggr = bindings.V4L2_PIX_FMT_PISP_COMP1_BGGR,
        pisp_comp1_mono = bindings.V4L2_PIX_FMT_PISP_COMP1_MONO,
        pisp_comp2_rggb = bindings.V4L2_PIX_FMT_PISP_COMP2_RGGB,
        pisp_comp2_grbg = bindings.V4L2_PIX_FMT_PISP_COMP2_GRBG,
        pisp_comp2_gbrg = bindings.V4L2_PIX_FMT_PISP_COMP2_GBRG,
        pisp_comp2_bggr = bindings.V4L2_PIX_FMT_PISP_COMP2_BGGR,
        pisp_comp2_mono = bindings.V4L2_PIX_FMT_PISP_COMP2_MONO,
        raw_cru10 = bindings.V4L2_PIX_FMT_RAW_CRU10,
        raw_cru12 = bindings.V4L2_PIX_FMT_RAW_CRU12,
        raw_cru14 = bindings.V4L2_PIX_FMT_RAW_CRU14,
        raw_cru20 = bindings.V4L2_PIX_FMT_RAW_CRU20,
    };

    pub const Field = enum(u32) {
        any = @intCast(bindings.V4L2_FIELD_ANY),
        none = @intCast(bindings.V4L2_FIELD_NONE),
        top = @intCast(bindings.V4L2_FIELD_TOP),
        bottom = @intCast(bindings.V4L2_FIELD_BOTTOM),
        interlaced = @intCast(bindings.V4L2_FIELD_INTERLACED),
        seq_tb = @intCast(bindings.V4L2_FIELD_SEQ_TB),
        seq_bt = @intCast(bindings.V4L2_FIELD_SEQ_BT),
        alternate = @intCast(bindings.V4L2_FIELD_ALTERNATE),
        interlaced_tb = @intCast(bindings.V4L2_FIELD_INTERLACED_TB),
        interlaced_bt = @intCast(bindings.V4L2_FIELD_INTERLACED_BT),

        pub fn hasTop(field: Field) bool {
            return switch (field) {
                .top, .interlaced, .interlaced_bt, .interlaced_tb, .seq_tb, .seq_bt => true,
                else => false,
            };
        }

        pub fn hasBottom(field: Field) bool {
            return switch (field) {
                .bottom, .interlaced, .interlaced_bt, .interlaced_tb, .seq_tb, .seq_bt => true,
                else => false,
            };
        }

        pub fn hasBoth(field: Field) bool {
            return switch (field) {
                .interlaced, .interlaced_bt, .interlaced_tb, .seq_tb, .seq_bt => true,
                else => false,
            };
        }

        pub fn hasTopOrBottom(field: Field) bool {
            return switch (field) {
                .bottom, .top, .alternate => true,
                else => false,
            };
        }

        pub fn isInterlaced(field: Field) bool {
            return switch (field) {
                .interlaced, .interlaced_bt, .interlaced_tb => true,
                else => false,
            };
        }

        pub fn isSequential(field: Field) bool {
            return switch (field) {
                .seq_bt, .seq_tb => true,
                else => false,
            };
        }
    };

    pub const Flag = enum(u32) {
        premul_alpha = @intCast(bindings.V4L2_PIX_FMT_FLAG_PREMUL_ALPHA),
        set_csc = @intCast(bindings.V4L2_PIX_FMT_FLAG_SET_CSC),
    };

    pub const Colorspace = enum(u32) {
        default = @intCast(bindings.V4L2_COLORSPACE_DEFAULT),
        smpte170m = @intCast(bindings.V4L2_COLORSPACE_SMPTE170M),
        smpte240m = @intCast(bindings.V4L2_COLORSPACE_SMPTE240M),
        rec709 = @intCast(bindings.V4L2_COLORSPACE_REC709),
        bt878 = @intCast(bindings.V4L2_COLORSPACE_BT878),
        system_m470 = @intCast(bindings.V4L2_COLORSPACE_470_SYSTEM_M),
        system_bg470 = @intCast(bindings.V4L2_COLORSPACE_470_SYSTEM_BG),
        jpeg = @intCast(bindings.V4L2_COLORSPACE_JPEG),
        srgb = @intCast(bindings.V4L2_COLORSPACE_SRGB),
        oprgb = @intCast(bindings.V4L2_COLORSPACE_OPRGB),
        bt2020 = @intCast(bindings.V4L2_COLORSPACE_BT2020),
        raw = @intCast(bindings.V4L2_COLORSPACE_RAW),
        dci_p3 = @intCast(bindings.V4L2_COLORSPACE_DCI_P3),

        pub fn getDefault(is_sdtv: bool, is_hdtv: bool) Colorspace {
            return if (is_sdtv) .smpte170m else if (is_hdtv) .rec709 else .srgb;
        }
    };

    pub const TransferFunction = enum(u32) {
        default = @intCast(bindings.V4L2_XFER_FUNC_DEFAULT),
        _709 = @intCast(bindings.V4L2_XFER_FUNC_709),
        srgb = @intCast(bindings.V4L2_XFER_FUNC_SRGB),
        oprgb = @intCast(bindings.V4L2_XFER_FUNC_OPRGB),
        smpte240m = @intCast(bindings.V4L2_XFER_FUNC_SMPTE240M),
        none = @intCast(bindings.V4L2_XFER_FUNC_NONE),
        dci_p3 = @intCast(bindings.V4L2_XFER_FUNC_DCI_P3),
        smpte2084 = @intCast(bindings.V4L2_XFER_FUNC_SMPTE2084),

        pub fn getDefault(cs: Colorspace) TransferFunction {
            return switch (cs) {
                .oprgb => .oprgb,
                .smpte240m => .smpte240m,
                .dci_p3 => .dci_p3,
                .raw => .none,
                .srgb, .jpeg => .srgb,
                else => ._709,
            };
        }
    };

    pub const Quantization = enum(u32) {
        default = @intCast(bindings.V4L2_QUANTIZATION_DEFAULT),
        full_range = @intCast(bindings.V4L2_QUANTIZATION_FULL_RANGE),
        limited_range = @intCast(bindings.V4L2_QUANTIZATION_LIM_RANGE),

        pub fn getDefault(is_rgb_or_hsv: bool, cs: Colorspace) Quantization {
            return if (is_rgb_or_hsv or cs == .jpeg) .full_range else .limited_range;
        }
    };

    pub const Sdr = enum(u32) {
        cu8 = bindings.V4L2_SDR_FMT_CU8,
        cu16le = bindings.V4L2_SDR_FMT_CU16LE,
        cs8 = bindings.V4L2_SDR_FMT_CS8,
        cs14le = bindings.V4L2_SDR_FMT_CS14LE,
        ru12le = bindings.V4L2_SDR_FMT_RU12LE,
        pcu16be = bindings.V4L2_SDR_FMT_PCU16BE,
        pcu18be = bindings.V4L2_SDR_FMT_PCU18BE,
        pcu20be = bindings.V4L2_SDR_FMT_PCU20BE,
    };

    pub const Touch = enum(u32) {
        delta_td16 = bindings.V4L2_TCH_FMT_DELTA_TD16,
        delta_td08 = bindings.V4L2_TCH_FMT_DELTA_TD08,
        tu16 = bindings.V4L2_TCH_FMT_TU16,
        tu08 = bindings.V4L2_TCH_FMT_TU08,
    };

    pub const Meta = enum(u32) {
        vsp1_hgo = bindings.V4L2_META_FMT_VSP1_HGO,
        vsp1_hgt = bindings.V4L2_META_FMT_VSP1_HGT,
        uvc = bindings.V4L2_META_FMT_UVC,
        d4xx = bindings.V4L2_META_FMT_D4XX,
        uvc_msxu_1_5 = bindings.V4L2_META_FMT_UVC_MSXU_1_5,
        vivid = bindings.V4L2_META_FMT_VIVID,
    };

    pub const C3isp = enum(u32) {
        params = bindings.V4L2_META_FMT_C3ISP_PARAMS,
        stats = bindings.V4L2_META_FMT_C3ISP_STATS,
    };

    pub const Rkisp = enum(u32) {
        isp1_params = bindings.V4L2_META_FMT_RK_ISP1_PARAMS,
        isp1_stat_3a = bindings.V4L2_META_FMT_RK_ISP1_STAT_3A,
        isp1_ext_params = bindings.V4L2_META_FMT_RK_ISP1_EXT_PARAMS,
    };

    pub const RaspberryPi = enum(u32) {
        be_cfg = bindings.V4L2_META_FMT_RPI_BE_CFG,
        fe_cfg = bindings.V4L2_META_FMT_RPI_FE_CFG,
        fe_stats = bindings.V4L2_META_FMT_RPI_FE_STATS,
    };
};

test "Pixel ABI matches struct_v4l2_pix_format" {
    const C = bindings.struct_v4l2_pix_format;
    const Z = Pixel;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "width"), @offsetOf(Z, "width"));
    try std.testing.expectEqual(@offsetOf(C, "height"), @offsetOf(Z, "height"));
    try std.testing.expectEqual(@offsetOf(C, "pixelformat"), @offsetOf(Z, "pixel_format"));
    try std.testing.expectEqual(@offsetOf(C, "field"), @offsetOf(Z, "field"));
    try std.testing.expectEqual(@offsetOf(C, "bytesperline"), @offsetOf(Z, "bytes_per_line"));
    try std.testing.expectEqual(@offsetOf(C, "sizeimage"), @offsetOf(Z, "size_image"));
    try std.testing.expectEqual(@offsetOf(C, "colorspace"), @offsetOf(Z, "colorspace"));
    try std.testing.expectEqual(@offsetOf(C, "priv"), @offsetOf(Z, "priv"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "unnamed_0"), @offsetOf(Z, "encoding"));
    try std.testing.expectEqual(@offsetOf(C, "quantization"), @offsetOf(Z, "quantization"));
    try std.testing.expectEqual(@offsetOf(C, "xfer_func"), @offsetOf(Z, "xfer_func"));
}

test "Pixel.Plane ABI matches struct_v4l2_plane_pix_format" {
    const C = bindings.struct_v4l2_plane_pix_format;
    const Z = Pixel.Plane;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "sizeimage"), @offsetOf(Z, "sizeimage"));
    try std.testing.expectEqual(@offsetOf(C, "bytesperline"), @offsetOf(Z, "bytesperline"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Pixel.Mplane ABI matches struct_v4l2_pix_format_mplane" {
    const C = bindings.struct_v4l2_pix_format_mplane;
    const Z = Pixel.Mplane;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "width"), @offsetOf(Z, "width"));
    try std.testing.expectEqual(@offsetOf(C, "height"), @offsetOf(Z, "height"));
    try std.testing.expectEqual(@offsetOf(C, "pixelformat"), @offsetOf(Z, "pixelformat"));
    try std.testing.expectEqual(@offsetOf(C, "field"), @offsetOf(Z, "field"));
    try std.testing.expectEqual(@offsetOf(C, "colorspace"), @offsetOf(Z, "colorspace"));
    try std.testing.expectEqual(@offsetOf(C, "plane_fmt"), @offsetOf(Z, "plane_fmt"));
    try std.testing.expectEqual(@offsetOf(C, "num_planes"), @offsetOf(Z, "num_planes"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "quantization"), @offsetOf(Z, "quantization"));
    try std.testing.expectEqual(@offsetOf(C, "xfer_func"), @offsetOf(Z, "xfer_func"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Pixel.SdrFormat ABI matches struct_v4l2_sdr_format" {
    const C = bindings.struct_v4l2_sdr_format;
    const Z = Pixel.SdrFormat;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "pixelformat"), @offsetOf(Z, "pixelformat"));
    try std.testing.expectEqual(@offsetOf(C, "buffersize"), @offsetOf(Z, "buffersize"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
}

test "Pixel.MetaFormat ABI matches struct_v4l2_meta_format" {
    const C = bindings.struct_v4l2_meta_format;
    const Z = Pixel.MetaFormat;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "dataformat"), @offsetOf(Z, "dataformat"));
    try std.testing.expectEqual(@offsetOf(C, "buffersize"), @offsetOf(Z, "buffersize"));
    try std.testing.expectEqual(@offsetOf(C, "width"), @offsetOf(Z, "width"));
    try std.testing.expectEqual(@offsetOf(C, "height"), @offsetOf(Z, "height"));
    try std.testing.expectEqual(@offsetOf(C, "bytesperline"), @offsetOf(Z, "bytesperline"));
}
