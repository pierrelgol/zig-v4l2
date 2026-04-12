const std = @import("std");
const builtin = @import("builtin");

pub fn fourcc(a: u8, b: u8, c: u8, d: u8) u32 {
    return (@as(u32, a)) | (@as(u32, b) << 8) | (@as(u32, c) << 16) | (@as(u32, d) << 24);
}

pub fn fourcc_be(a: u8, b: u8, c: u8, d: u8) u32 {
    return fourcc(a, b, c, d) | (@as(u32, 1) << 31);
}

pub const Pixel = struct {
    width: u32,
    height: u32,
    pixel_format: Format,
    field: Field,
    bytes_per_line: u32,
    size_image: u32,
    colorspace: Colorspace,
    priv: u32,
    flags: Flag,
    encoding: Encoding,
    quantization: Quantization,
    xfer_func: TransferFunction,

    pub const Format = enum(u32) {
        rgb332 = fourcc('R', 'G', 'B', '1'),
        rgb444 = fourcc('R', '4', '4', '4'),
        argb444 = fourcc('A', 'R', '1', '2'),
        xrgb444 = fourcc('X', 'R', '1', '2'),
        rgba444 = fourcc('R', 'A', '1', '2'),
        rgbx444 = fourcc('R', 'X', '1', '2'),
        abgr444 = fourcc('A', 'B', '1', '2'),
        xbgr444 = fourcc('X', 'B', '1', '2'),
        bgra444 = fourcc('G', 'A', '1', '2'),
        bgrx444 = fourcc('B', 'X', '1', '2'),
        rgb555 = fourcc('R', 'G', 'B', 'O'),
        argb555 = fourcc('A', 'R', '1', '5'),
        xrgb555 = fourcc('X', 'R', '1', '5'),
        rgba555 = fourcc('R', 'A', '1', '5'),
        rgbx555 = fourcc('R', 'X', '1', '5'),
        abgr555 = fourcc('A', 'B', '1', '5'),
        xbgr555 = fourcc('X', 'B', '1', '5'),
        bgra555 = fourcc('B', 'A', '1', '5'),
        bgrx555 = fourcc('B', 'X', '1', '5'),
        rgb565 = fourcc('R', 'G', 'B', 'P'),
        rgb555x = fourcc('R', 'G', 'B', 'Q'),
        argb555x = fourcc_be('A', 'R', '1', '5'),
        xrgb555x = fourcc_be('X', 'R', '1', '5'),
        rgb565x = fourcc('R', 'G', 'B', 'R'),
        bgr666 = fourcc('B', 'G', 'R', 'H'),
        bgr24 = fourcc('B', 'G', 'R', '3'),
        rgb24 = fourcc('R', 'G', 'B', '3'),
        bgr32 = fourcc('B', 'G', 'R', '4'),
        abgr32 = fourcc('A', 'R', '2', '4'),
        xbgr32 = fourcc('X', 'R', '2', '4'),
        bgra32 = fourcc('R', 'A', '2', '4'),
        bgrx32 = fourcc('R', 'X', '2', '4'),
        rgb32 = fourcc('R', 'G', 'B', '4'),
        rgba32 = fourcc('A', 'B', '2', '4'),
        rgbx32 = fourcc('X', 'B', '2', '4'),
        argb32 = fourcc('B', 'A', '2', '4'),
        xrgb32 = fourcc('B', 'X', '2', '4'),
        rgbx1010102 = fourcc('R', 'X', '3', '0'),
        rgba1010102 = fourcc('R', 'A', '3', '0'),
        argb2101010 = fourcc('A', 'R', '3', '0'),
        bgr48_12 = fourcc('B', '3', '1', '2'),
        bgr48 = fourcc('B', 'G', 'R', '6'),
        rgb48 = fourcc('R', 'G', 'B', '6'),
        abgr64_12 = fourcc('B', '4', '1', '2'),
        grey = fourcc('G', 'R', 'E', 'Y'),
        y4 = fourcc('Y', '0', '4', ' '),
        y6 = fourcc('Y', '0', '6', ' '),
        y10 = fourcc('Y', '1', '0', ' '),
        y12 = fourcc('Y', '1', '2', ' '),
        y012 = fourcc('Y', '0', '1', '2'),
        y14 = fourcc('Y', '1', '4', ' '),
        y16 = fourcc('Y', '1', '6', ' '),
        y16_be = fourcc_be('Y', '1', '6', ' '),
        y10bpack = fourcc('Y', '1', '0', 'B'),
        y10p = fourcc('Y', '1', '0', 'P'),
        ipu3_y10 = fourcc('i', 'p', '3', 'y'),
        y12p = fourcc('Y', '1', '2', 'P'),
        y14p = fourcc('Y', '1', '4', 'P'),
        pal8 = fourcc('P', 'A', 'L', '8'),
        uv8 = fourcc('U', 'V', '8', ' '),
        yuyv = fourcc('Y', 'U', 'Y', 'V'),
        yyuv = fourcc('Y', 'Y', 'U', 'V'),
        yvyu = fourcc('Y', 'V', 'Y', 'U'),
        uyvy = fourcc('U', 'Y', 'V', 'Y'),
        vyuy = fourcc('V', 'Y', 'U', 'Y'),
        y41p = fourcc('Y', '4', '1', 'P'),
        yuv444 = fourcc('Y', '4', '4', '4'),
        yuv555 = fourcc('Y', 'U', 'V', 'O'),
        yuv565 = fourcc('Y', 'U', 'V', 'P'),
        yuv24 = fourcc('Y', 'U', 'V', '3'),
        yuv32 = fourcc('Y', 'U', 'V', '4'),
        ayuv32 = fourcc('A', 'Y', 'U', 'V'),
        xyuv32 = fourcc('X', 'Y', 'U', 'V'),
        vuya32 = fourcc('V', 'U', 'Y', 'A'),
        vuyx32 = fourcc('V', 'U', 'Y', 'X'),
        yuva32 = fourcc('Y', 'U', 'V', 'A'),
        yuvx32 = fourcc('Y', 'U', 'V', 'X'),
        m420 = fourcc('M', '4', '2', '0'),
        yuv48_12 = fourcc('Y', '3', '1', '2'),
        y210 = fourcc('Y', '2', '1', '0'),
        y212 = fourcc('Y', '2', '1', '2'),
        y216 = fourcc('Y', '2', '1', '6'),
        nv12 = fourcc('N', 'V', '1', '2'),
        nv21 = fourcc('N', 'V', '2', '1'),
        nv15 = fourcc('N', 'V', '1', '5'),
        nv16 = fourcc('N', 'V', '1', '6'),
        nv61 = fourcc('N', 'V', '6', '1'),
        nv20 = fourcc('N', 'V', '2', '0'),
        nv24 = fourcc('N', 'V', '2', '4'),
        nv42 = fourcc('N', 'V', '4', '2'),
        p010 = fourcc('P', '0', '1', '0'),
        p012 = fourcc('P', '0', '1', '2'),
        nv12m = fourcc('N', 'M', '1', '2'),
        nv21m = fourcc('N', 'M', '2', '1'),
        nv16m = fourcc('N', 'M', '1', '6'),
        nv61m = fourcc('N', 'M', '6', '1'),
        p012m = fourcc('P', 'M', '1', '2'),
        yuv410 = fourcc('Y', 'U', 'V', '9'),
        yvu410 = fourcc('Y', 'V', 'U', '9'),
        yuv411p = fourcc('4', '1', '1', 'P'),
        yuv420 = fourcc('Y', 'U', '1', '2'),
        yvu420 = fourcc('Y', 'V', '1', '2'),
        yuv422p = fourcc('4', '2', '2', 'P'),
        yuv420m = fourcc('Y', 'M', '1', '2'),
        yvu420m = fourcc('Y', 'M', '2', '1'),
        yuv422m = fourcc('Y', 'M', '1', '6'),
        yvu422m = fourcc('Y', 'M', '6', '1'),
        yuv444m = fourcc('Y', 'M', '2', '4'),
        yvu444m = fourcc('Y', 'M', '4', '2'),
        nv12_4l4 = fourcc('V', 'T', '1', '2'),
        nv12_16l16 = fourcc('H', 'M', '1', '2'),
        nv12_32l32 = fourcc('S', 'T', '1', '2'),
        nv15_4l4 = fourcc('V', 'T', '1', '5'),
        p010_4l4 = fourcc('T', '0', '1', '0'),
        nv12_8l128 = fourcc('A', 'T', '1', '2'),
        nv12_10be_8l128 = fourcc_be('A', 'X', '1', '2'),
        nv12mt = fourcc('T', 'M', '1', '2'),
        nv12mt_16x16 = fourcc('V', 'M', '1', '2'),
        nv12m_8l128 = fourcc('N', 'A', '1', '2'),
        nv12m_10be_8l128 = fourcc_be('N', 'T', '1', '2'),
        sbggr8 = fourcc('B', 'A', '8', '1'),
        sgbrg8 = fourcc('G', 'B', 'R', 'G'),
        sgrbg8 = fourcc('G', 'R', 'B', 'G'),
        srggb8 = fourcc('R', 'G', 'G', 'B'),
        sbggr10 = fourcc('B', 'G', '1', '0'),
        sgbrg10 = fourcc('G', 'B', '1', '0'),
        sgrbg10 = fourcc('B', 'A', '1', '0'),
        srggb10 = fourcc('R', 'G', '1', '0'),
        sbggr10p = fourcc('p', 'B', 'A', 'A'),
        sgbrg10p = fourcc('p', 'G', 'A', 'A'),
        sgrbg10p = fourcc('p', 'g', 'A', 'A'),
        srggb10p = fourcc('p', 'R', 'A', 'A'),
        sbggr10alaw8 = fourcc('a', 'B', 'A', '8'),
        sgbrg10alaw8 = fourcc('a', 'G', 'A', '8'),
        sgrbg10alaw8 = fourcc('a', 'g', 'A', '8'),
        srggb10alaw8 = fourcc('a', 'R', 'A', '8'),
        sbggr10dpcm8 = fourcc('b', 'B', 'A', '8'),
        sgbrg10dpcm8 = fourcc('b', 'G', 'A', '8'),
        sgrbg10dpcm8 = fourcc('B', 'D', '1', '0'),
        srggb10dpcm8 = fourcc('b', 'R', 'A', '8'),
        sbggr12 = fourcc('B', 'G', '1', '2'),
        sgbrg12 = fourcc('G', 'B', '1', '2'),
        sgrbg12 = fourcc('B', 'A', '1', '2'),
        srggb12 = fourcc('R', 'G', '1', '2'),
        sbggr12p = fourcc('p', 'B', 'C', 'C'),
        sgbrg12p = fourcc('p', 'G', 'C', 'C'),
        sgrbg12p = fourcc('p', 'g', 'C', 'C'),
        srggb12p = fourcc('p', 'R', 'C', 'C'),
        sbggr14 = fourcc('B', 'G', '1', '4'),
        sgbrg14 = fourcc('G', 'B', '1', '4'),
        sgrbg14 = fourcc('G', 'R', '1', '4'),
        srggb14 = fourcc('R', 'G', '1', '4'),
        sbggr14p = fourcc('p', 'B', 'E', 'E'),
        sgbrg14p = fourcc('p', 'G', 'E', 'E'),
        sgrbg14p = fourcc('p', 'g', 'E', 'E'),
        srggb14p = fourcc('p', 'R', 'E', 'E'),
        sbggr16 = fourcc('B', 'Y', 'R', '2'),
        sgbrg16 = fourcc('G', 'B', '1', '6'),
        sgrbg16 = fourcc('G', 'R', '1', '6'),
        srggb16 = fourcc('R', 'G', '1', '6'),
        hsv24 = fourcc('H', 'S', 'V', '3'),
        hsv32 = fourcc('H', 'S', 'V', '4'),
        mjpeg = fourcc('M', 'J', 'P', 'G'),
        jpeg = fourcc('J', 'P', 'E', 'G'),
        dv = fourcc('d', 'v', 's', 'd'),
        mpeg = fourcc('M', 'P', 'E', 'G'),
        h264 = fourcc('H', '2', '6', '4'),
        h264_no_sc = fourcc('A', 'V', 'C', '1'),
        h264_mvc = fourcc('M', '2', '6', '4'),
        h263 = fourcc('H', '2', '6', '3'),
        mpeg1 = fourcc('M', 'P', 'G', '1'),
        mpeg2 = fourcc('M', 'P', 'G', '2'),
        mpeg2_slice = fourcc('M', 'G', '2', 'S'),
        mpeg4 = fourcc('M', 'P', 'G', '4'),
        xvid = fourcc('X', 'V', 'I', 'D'),
        vc1_annex_g = fourcc('V', 'C', '1', 'G'),
        vc1_annex_l = fourcc('V', 'C', '1', 'L'),
        vp8 = fourcc('V', 'P', '8', '0'),
        vp8_frame = fourcc('V', 'P', '8', 'F'),
        vp9 = fourcc('V', 'P', '9', '0'),
        vp9_frame = fourcc('V', 'P', '9', 'F'),
        hevc = fourcc('H', 'E', 'V', 'C'),
        fwht = fourcc('F', 'W', 'H', 'T'),
        fwht_stateless = fourcc('S', 'F', 'W', 'H'),
        h264_slice = fourcc('S', '2', '6', '4'),
        hevc_slice = fourcc('S', '2', '6', '5'),
        av1_frame = fourcc('A', 'V', '1', 'F'),
        spk = fourcc('S', 'P', 'K', '0'),
        rv30 = fourcc('R', 'V', '3', '0'),
        rv40 = fourcc('R', 'V', '4', '0'),
        cpia1 = fourcc('C', 'P', 'I', 'A'),
        wnva = fourcc('W', 'N', 'V', 'A'),
        sn9c10x = fourcc('S', '9', '1', '0'),
        sn9c20x_i420 = fourcc('S', '9', '2', '0'),
        pwc1 = fourcc('P', 'W', 'C', '1'),
        pwc2 = fourcc('P', 'W', 'C', '2'),
        et61x251 = fourcc('E', '6', '2', '5'),
        spca501 = fourcc('S', '5', '0', '1'),
        spca505 = fourcc('S', '5', '0', '5'),
        spca508 = fourcc('S', '5', '0', '8'),
        spca561 = fourcc('S', '5', '6', '1'),
        pac207 = fourcc('P', '2', '0', '7'),
        mr97310a = fourcc('M', '3', '1', '0'),
        jl2005bcd = fourcc('J', 'L', '2', '0'),
        sn9c2028 = fourcc('S', 'O', 'N', 'X'),
        sq905c = fourcc('9', '0', '5', 'C'),
        pjpg = fourcc('P', 'J', 'P', 'G'),
        ov511 = fourcc('O', '5', '1', '1'),
        ov518 = fourcc('O', '5', '1', '8'),
        stv0680 = fourcc('S', '6', '8', '0'),
        tm6000 = fourcc('T', 'M', '6', '0'),
        cit_yyvyuy = fourcc('C', 'I', 'T', 'V'),
        konica420 = fourcc('K', 'O', 'N', 'I'),
        jpgl = fourcc('J', 'P', 'G', 'L'),
        se401 = fourcc('S', '4', '0', '1'),
        s5c_uyvy_jpg = fourcc('S', '5', 'C', 'I'),
        y8i = fourcc('Y', '8', 'I', ' '),
        y12i = fourcc('Y', '1', '2', 'I'),
        y16i = fourcc('Y', '1', '6', 'I'),
        z16 = fourcc('Z', '1', '6', ' '),
        mt21c = fourcc('M', 'T', '2', '1'),
        mm21 = fourcc('M', 'M', '2', '1'),
        mt2110t = fourcc('M', 'T', '2', 'T'),
        mt2110r = fourcc('M', 'T', '2', 'R'),
        inzi = fourcc('I', 'N', 'Z', 'I'),
        cnf4 = fourcc('C', 'N', 'F', '4'),
        hi240 = fourcc('H', 'I', '2', '4'),
        qc08c = fourcc('Q', '0', '8', 'C'),
        qc10c = fourcc('Q', '1', '0', 'C'),
        ajpg = fourcc('A', 'J', 'P', 'G'),
        hextile = fourcc('H', 'X', 'T', 'L'),
        ipu3_sbggr10 = fourcc('i', 'p', '3', 'b'),
        ipu3_sgbrg10 = fourcc('i', 'p', '3', 'g'),
        ipu3_sgrbg10 = fourcc('i', 'p', '3', 'G'),
        ipu3_srggb10 = fourcc('i', 'p', '3', 'r'),
        pisp_comp1_rggb = fourcc('P', 'C', '1', 'R'),
        pisp_comp1_grbg = fourcc('P', 'C', '1', 'G'),
        pisp_comp1_gbrg = fourcc('P', 'C', '1', 'g'),
        pisp_comp1_bggr = fourcc('P', 'C', '1', 'B'),
        pisp_comp1_mono = fourcc('P', 'C', '1', 'M'),
        pisp_comp2_rggb = fourcc('P', 'C', '2', 'R'),
        pisp_comp2_grbg = fourcc('P', 'C', '2', 'G'),
        pisp_comp2_gbrg = fourcc('P', 'C', '2', 'g'),
        pisp_comp2_bggr = fourcc('P', 'C', '2', 'B'),
        pisp_comp2_mono = fourcc('P', 'C', '2', 'M'),
        raw_cru10 = fourcc('C', 'R', '1', '0'),
        raw_cru12 = fourcc('C', 'R', '1', '2'),
        raw_cru14 = fourcc('C', 'R', '1', '4'),
        raw_cru20 = fourcc('C', 'R', '2', '0'),
    };

    // @TODO
    //     /* SDR formats - used only for Software Defined Radio devices */
    // #define V4L2_SDR_FMT_CU8          v4l2_fourcc('C', 'U', '0', '8') /* IQ u8 */
    // #define V4L2_SDR_FMT_CU16LE       v4l2_fourcc('C', 'U', '1', '6') /* IQ u16le */
    // #define V4L2_SDR_FMT_CS8          v4l2_fourcc('C', 'S', '0', '8') /* complex s8 */
    // #define V4L2_SDR_FMT_CS14LE       v4l2_fourcc('C', 'S', '1', '4') /* complex s14le */
    // #define V4L2_SDR_FMT_RU12LE       v4l2_fourcc('R', 'U', '1', '2') /* real u12le */
    // #define V4L2_SDR_FMT_PCU16BE   v4l2_fourcc('P', 'C', '1', '6') /* planar complex u16be */
    // #define V4L2_SDR_FMT_PCU18BE   v4l2_fourcc('P', 'C', '1', '8') /* planar complex u18be */
    // #define V4L2_SDR_FMT_PCU20BE   v4l2_fourcc('P', 'C', '2', '0') /* planar complex u20be */
    // /* Touch formats - used for Touch devices */
    // #define V4L2_TCH_FMT_DELTA_TD16 v4l2_fourcc('T', 'D', '1', '6') /* 16-bit signed deltas */
    // #define V4L2_TCH_FMT_DELTA_TD08 v4l2_fourcc('T', 'D', '0', '8') /* 8-bit signed deltas */
    // #define V4L2_TCH_FMT_TU16 v4l2_fourcc('T', 'U', '1', '6') /* 16-bit unsigned touch data */
    // #define V4L2_TCH_FMT_TU08 v4l2_fourcc('T', 'U', '0', '8') /* 8-bit unsigned touch data */
    // /* Meta-data formats */
    // #define V4L2_META_FMT_VSP1_HGO    v4l2_fourcc('V', 'S', 'P', 'H') /* R-Car VSP1 1-D Histogram */
    // #define V4L2_META_FMT_VSP1_HGT    v4l2_fourcc('V', 'S', 'P', 'T') /* R-Car VSP1 2-D Histogram */
    // #define V4L2_META_FMT_UVC         v4l2_fourcc('U', 'V', 'C', 'H') /* UVC Payload Header metadata */
    // #define V4L2_META_FMT_D4XX        v4l2_fourcc('D', '4', 'X', 'X') /* D4XX Payload Header metadata */
    // #define V4L2_META_FMT_UVC_MSXU_1_5  v4l2_fourcc('U', 'V', 'C', 'M') /* UVC MSXU metadata */
    // #define V4L2_META_FMT_VIVID   v4l2_fourcc('V', 'I', 'V', 'D') /* Vivid Metadata */
    // /* Vendor specific - used for RK_ISP1 camera sub-system */
    // #define V4L2_META_FMT_RK_ISP1_PARAMS v4l2_fourcc('R', 'K', '1', 'P') /* Rockchip ISP1 3A Parameters */
    // #define V4L2_META_FMT_RK_ISP1_STAT_3A v4l2_fourcc('R', 'K', '1', 'S') /* Rockchip ISP1 3A Statistics */
    // #define V4L2_META_FMT_RK_ISP1_EXT_PARAMS v4l2_fourcc('R', 'K', '1', 'E') /* Rockchip ISP1 3a Extensible Parameters */
    // /* Vendor specific - used for C3_ISP */
    // #define V4L2_META_FMT_C3ISP_PARAMS v4l2_fourcc('C', '3', 'P', 'M') /* Amlogic C3 ISP Parameters */
    // #define V4L2_META_FMT_C3ISP_STATS v4l2_fourcc('C', '3', 'S', 'T') /* Amlogic C3 ISP Statistics */
    // /* Vendor specific - used for RaspberryPi PiSP */
    // #define V4L2_META_FMT_RPI_BE_CFG v4l2_fourcc('R', 'P', 'B', 'C') /* PiSP BE configuration */
    // #define V4L2_META_FMT_RPI_FE_CFG v4l2_fourcc('R', 'P', 'F', 'C') /* PiSP FE configuration */
    // #define V4L2_META_FMT_RPI_FE_STATS v4l2_fourcc('R', 'P', 'F', 'S') /* PiSP FE stats */

    // /* priv field value to indicates that subsequent fields are valid. */
    // #define V4L2_PIX_FMT_PRIV_MAGIC  0xfeedcafe

    pub const Field = enum(u32) {
        any = 0,
        none = 1,
        top = 2,
        bottom = 3,
        interlaced = 4,
        seq_tb = 5,
        seq_bt = 6,
        alternate = 7,
        interlaced_tb = 8,
        interlaced_bt = 9,

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

    pub const Encoding = union(enum) {
        ycbr: enum(u32) {
            default = 0,
            _601 = 1,
            _709 = 2,
            xv601 = 3,
            xv709 = 4,
            sycc = 5,
            bt2020 = 6,
            bt2020_const_lum = 7,
            smpte240m = 8,

            pub fn getDefault(cs: Colorspace) Encoding {
                return switch (cs) {
                    .rec709, .dci_p3 => ._709,
                    .bt2020 => .bt2020,
                    .smpte240m => .smpte240m,
                    else => ._601,
                };
            }
        },
        hsv: enum(u32) {
            _180 = 128,
            _256 = 129,
        },
    };

    pub const Flag = enum(u32) {
        premul_alpha = 0x00000001,
        set_csc = 0x00000002,
    };

    pub const Colorspace = enum(u32) {
        default = 0,
        smpte170m = 1,
        smpte240m = 2,
        rec709 = 3,
        bt878 = 4,
        system_m470 = 5,
        system_bg470 = 6,
        jpeg = 7,
        srgb = 8,
        oprgb = 9,
        bt2020 = 10,
        raw = 11,
        dci_p3 = 12,

        pub fn getDefault(is_sdtv: bool, is_hdtv: bool) Colorspace {
            return if (is_sdtv) .smpte170m else if (is_hdtv) .rec709 else .srgb;
        }
    };

    pub const TransferFunction = enum(u32) {
        default = 0,
        _709 = 1,
        srgb = 2,
        oprgb = 3,
        smpte240m = 4,
        none = 5,
        dci_p3 = 6,
        smpte2084 = 7,

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
        default = 0,
        full_range = 1,
        limited_range = 2,

        pub fn getDefault(is_rgb_or_hsv: bool, cs: Colorspace) Quantization {
            return if (is_rgb_or_hsv or cs == .jpeg) .full_range else .limited_range;
        }
    };
};

pub const Buffer = struct {
    index: u32,
    tag: Buffer.Type,
    bytes_used: u32,
    flags: Flag,
    field: Pixel.Field,
    timestamp: std.os.linux.timeval,
    timecode: Timecode,
    sequence: u32,
    memory: Memory,
    m: union {
        offset: u32,
        user_ptr: usize,
        planes: ?[*]Buffer.Plane,
        fd: i32,
    },
    length: u32,
    reserved2: u32,
    r: union {
        request_fd: i32,
        reserved: u32,
    },

    pub const Type = enum(u32) {
        video_capture = 1,
        video_output = 2,
        video_overlay = 3,
        vbi_capture = 4,
        vbi_output = 5,
        sliced_vbi_capture = 6,
        sliced_vbi_output = 7,
        video_output_overlay = 8,
        video_capture_mplane = 9,
        video_output_mplane = 10,
        sdr_capture = 11,
        sdr_output = 12,
        meta_capture = 13,
        meta_output = 14,
        private = 0x80, // do not use
        _,

        pub fn isValid(b: Type) bool {
            return switch (@intFromEnum(b)) {
                0...14 => true,
                else => false,
            };
        }

        pub fn isMultiPlanar(b: Type) bool {
            return switch (b) {
                .video_capture_mplane, .video_output_mplane => true,
                else => false,
            };
        }

        pub fn isOutput(b: Type) bool {
            return switch (b) {
                .video_output, .video_output_mplane, .video_output_overlay, .vbi_output, .sliced_vbi_output, .sdr_output, .meta_output => true,
                else => false,
            };
        }

        pub fn isCapture(b: Type) bool {
            return b.isValid() and !b.isOutput();
        }
    };

    pub const Memory = enum(u32) {
        mmap,
        user_ptr,
        overlay,
        dmabuf,
    };

    pub const Plane = struct {
        bytes_used: u32,
        length: u32,
        m: union(enum) {
            mem_offset: u32,
            userptr: usize,
            fd: i32,
        },
        data_offset: u32,
        reserved: [11]u32,
    };

    pub const Flag = enum(u32) {
        mapped = 0x00000001,
        queued = 0x00000002,
        done = 0x00000004,
        keyframe = 0x00000008,
        pframe = 0x00000010,
        bframe = 0x00000020,
        err = 0x00000040,
        in_request = 0x00000080,
        timecode = 0x00000100,
        m2m_hold_capture_buf = 0x00000200,
        prepared = 0x00000400,
        no_cache_invalidate = 0x00000800,
        no_cache_clean = 0x00001000,
        timestamp_mask = 0x0000e000,
        timestamp_unknown = 0x00000000,
        timestamp_monotonic = 0x00002000,
        timestamp_copy = 0x00004000,
        tstamp_src_mask = 0x00070000,
        tstamp_src_eof = 0x00000000,
        tstamp_src_soe = 0x00010000,
        last = 0x00100000,
        request_fd = 0x00800000,
    };

    pub const Request = struct {
        count: u32,
        kind: Buffer.Type,
        memory: Buffer.Memory,
        capabilities: Request.Capbilities,
        flags: Request.Flag,
        reserved: [3]u8,

        pub const Flag = enum(u8) {
            non_coherent = (@as(u8, 1) << 0),
        };

        pub const Capbilities = enum(u8) {
            mmap = (@as(u8, 1) << 0),
            userptr = (@as(u8, 1) << 1),
            dmabuf = (@as(u8, 1) << 2),
            requests = (@as(u8, 1) << 3),
            orphaned_bufs = (@as(u8, 1) << 4),
            m2m_hold_capture_buf = (@as(u8, 1) << 5),
            mmap_cache_hints = (@as(u8, 1) << 6),
            max_num_buffers = (@as(u8, 1) << 7),
            remove_bufs = (@as(u8, 1) << 8),
        };
    };

    pub const Export = struct {
        tag: Buffer.Type,
        index: u32,
        place: u32,
        flags: std.os.linux.FD_CLOEXEC,
        fd: i32,
        reserved: [11]u32,
    };
};

pub const Priority = enum(u32) {
    unset = 0,
    background = 1,
    interactive = 2,
    record = 3,
    default = .interactive,
};

pub const Rectangle = struct {
    left: i32,
    top: i32,
    width: u32,
    height: u32,
};

pub const Fraction = struct {
    numerator: u32,
    denominator: u32,
};

pub const Area = struct {
    width: u32,
    height: u32,
};

pub const Sdr = enum(u32) {
    cu8 = fourcc('C', 'U', '0', '8'),
    cu16le = fourcc('C', 'U', '1', '6'),
    cs8 = fourcc('C', 'S', '0', '8'),
    cs14le = fourcc('C', 'S', '1', '4'),
    ru12le = fourcc('R', 'U', '1', '2'),
    pcu16be = fourcc('P', 'C', '1', '6'),
    pcu18be = fourcc('P', 'C', '1', '8'),
    pcu20be = fourcc('P', 'C', '2', '0'),
};

pub const Touch = enum(u32) {
    delta_td16 = fourcc('T', 'D', '1', '6'),
    delta_td08 = fourcc('T', 'D', '0', '8'),
    tu16 = fourcc('T', 'U', '1', '6'),
    tu08 = fourcc('T', 'U', '0', '8'),
};

pub const Meta = enum(u32) {
    vsp1_hgo = fourcc('V', 'S', 'P', 'H'),
    vsp1_hgt = fourcc('V', 'S', 'P', 'T'),
    uvc = fourcc('U', 'V', 'C', 'H'),
    d4xx = fourcc('D', '4', 'X', 'X'),
    uvc_msxu_1_5 = fourcc('U', 'V', 'C', 'M'),
    vivid = fourcc('V', 'I', 'V', 'D'),
};

pub const C3isp = enum(u32) {
    params = fourcc('C', '3', 'P', 'M'),
    stats = fourcc('C', '3', 'S', 'T'),
};

pub const Rkisp = enum(u32) {
    isp1_params = fourcc('R', 'K', '1', 'P'),
    isp1_stat_3a = fourcc('R', 'K', '1', 'S'),
    isp1_ext_params = fourcc('R', 'K', '1', 'E'),
};

pub const RaspberryPi = enum(u32) {
    be_cfg = fourcc('R', 'P', 'B', 'C'),
    fe_cfg = fourcc('R', 'P', 'F', 'C'),
    fe_stats = fourcc('R', 'P', 'F', 'S'),
};

pub const private_magic: u32 = 0xfeedcafe;

pub const Capability = struct {
    driver: [16]u8,
    card: [32]u8,
    bus_info: [32]u8,
    version: u32,
    capabilities: u32,

    pub const Capabilities = enum(u32) {
        video_capture = 0x00000001,
        video_output = 0x00000002,
        video_overlay = 0x00000004,
        vbi_capture = 0x00000010,
        vbi_output = 0x00000020,
        sliced_vbi_capture = 0x00000040,
        sliced_vbi_output = 0x00000080,
        rds_capture = 0x00000100,
        video_output_overlay = 0x00000200,
        hw_freq_seek = 0x00000400,
        rds_output = 0x00000800,
        video_capture_mplane = 0x00001000,
        video_output_mplane = 0x00002000,
        video_m2m_mplane = 0x00004000,
        video_m2m = 0x00008000,
        tuner = 0x00010000,
        audio = 0x00020000,
        radio = 0x00040000,
        modulator = 0x00080000,
        sdr_capture = 0x00100000,
        ext_pix_format = 0x00200000,
        sdr_output = 0x00400000,
        meta_capture = 0x00800000,
        readwrite = 0x01000000,
        edid = 0x02000000,
        streaming = 0x04000000,
        meta_output = 0x08000000,
        touch = 0x10000000,
        io_mc = 0x20000000,
        device_caps = 0x80000000,
    };
};

pub const Description = struct {
    index: u32,
    type: Buffer.Type,
    flags: Flag,

    pub const Flag = enum(u32) {
        compressed = 0x0001,
        emulated = 0x0002,
        continuous_bytestream = 0x0004,
        dyn_resolution = 0x0008,
        enc_cap_frame_interval = 0x0010,
        csc_colorspace = 0x0020,
        csc_xfer_func = 0x0040,
        csc_ycbcr_enc = 0x0080,
        csc_hsv_enc = .csc_ycbcr_enc,
        csc_quantization = 0x0100,
        meta_line_based = 0x0200,

        pub const enum_all: u32 = 0x80000000;
    };
};

pub const Frame = struct {
    pub const Buffer = struct {
        capability: Frame.Buffer.Capability,
        flags: Frame.Buffer.Flag,
        base: ?[*]anyopaque,
        fmt: Format,

        pub const Capability = enum(u32) {
            externoverlay = 0x0001,
            chromakey = 0x0002,
            list_clipping = 0x0004,
            bitmap_clipping = 0x0008,
            local_alpha = 0x0010,
            global_alpha = 0x0020,
            local_inv_alpha = 0x0040,
            src_chromakey = 0x0080,
        };

        pub const Flag = enum(u32) {
            primary = 0x0001,
            overlay = 0x0002,
            chromakey = 0x0004,
            local_alpha = 0x0008,
            global_alpha = 0x0010,
            local_inv_alpha = 0x0020,
            src_chromakey = 0x0040,
        };

        pub const Format = struct {
            width: u32,
            height: u32,
            pixel_format: Pixel.Format,
            field: Pixel.Field,
            bytes_per_line: u32,
            size_image: u32,
            colorspace: Pixel.Colorspace,
            priv: u32,
        };
    };

    pub const Size = struct {
        index: u32,
        pixel_format: Pixel.Format,
        tag: Size.Type,
        size: union(Type) {
            discrete: Discrete,
            step_wise: StepWise,
        },
        reserved: [2]u32,

        pub const Type = enum(u32) {
            discrete = 1,
            continuous = 2,
            stepwise = 3,
        };

        pub const Discrete = struct {
            width: u32,
            height: u32,
        };

        pub const StepWise = struct {
            min_width: u32,
            max_width: u32,
            step_width: u32,
            min_height: u32,
            max_height: u32,
            step_height: u32,
        };
    };

    pub const Interval = struct {
        index: u32,
        pixel_format: Pixel.Format,
        width: u32,
        height: u32,
        tag: Interval.Type,
        ival: union(Interval.Type) {
            discrete: Fraction,
            step_wise: StepWise,
        },

        pub const Type = enum(u32) {
            discrete = 1,
            continuous = 2,
            step_wise = 3,
            _,
        };

        pub const StepWise = struct {
            min: Fraction,
            max: Fraction,
            step: Fraction,
        };
    };
};

pub const Timecode = struct {
    pub const Type = enum(u32) {
        fps_24 = 1,
        fps_25 = 2,
        fps_30 = 3,
        fps_50 = 4,
        fps_60 = 5,
        _,
    };

    pub const Flag = enum(u32) {
        dropframe = 0x0001,
        colorframe = 0x0002,
        userbits_field = 0x000C,
        userbits_defined = 0x0000,
        userbits_8bitchars = 0x0008,
        _,
    };
};

pub const Clip = struct {
    c: Rectangle,
    next: ?*Clip,
};

pub const Window = struct {
    w: Rectangle,
    field: Pixel.Field,
    chromakey: u32,
    clips: ?*Clip,
    clipcount: u32,
    bitmap: ?[*]anyopaque,
    global_alpha: u8,
};

pub const Parameters = struct {
    pub const Capture = struct {
        capability: Parameters.Capability,
        outputmode: u32,
        time_per_frame: Fraction,
        extended_mode: u32,
        read_buffers: u32,
        reserved: [4]u32,
    };

    pub const Output = struct {
        capability: Parameters.Capability,
        outputmode: u32,
        time_per_frame: Fraction,
        extended_mode: u32,
        write_buffers: u32,
        reserved: [4]u32,
    };

    pub const Capability = enum(u32) {
        time_per_frame = 0x1000,
        _,
    };

    pub const Mode = enum(u32) {
        high_quality = 0x0001,
        _,
    };
};

pub const Crop = struct {
    tag: Buffer.Type,
    c: Rectangle,

    pub const Capabilities = struct {
        tag: Buffer.Type,
        bounds: Rectangle,
        defrec: Rectangle,
        pixel_aspect: Fraction,
    };

    pub const Target = enum(u32) {
        crop = 0x0000,
        crop_default = 0x0001,
        crop_bounds = 0x0002,
        native_size = 0x0003,
        compose = 0x0100,
        compose_default = 0x0101,
        compose_bounds = 0x0102,
        compose_padded = 0x0103,
    };
};

pub const Selection = struct {
    tag: Buffer.Type,
    target: Crop.Target,
    flags: Selection.Flag,
    r: Rectangle,
    reserved: [9]u32,

    pub const Flag = enum(u32) {
        ge = (@as(u8, 1) << 0),
        le = (@as(u8, 1) << 1),
        keep_config = (@as(u8, 1) << 2),
    };
};

pub const Edid = struct {
    pad: u32,
    start_block: u32,
    blocks: u32,
    reserved: [5]u32,
    edid: ?[*]u8,
};

// /*
//  *      A N A L O G   V I D E O   S T A N D A R D
//  */

// typedef __u64 v4l2_std_id;
// #include <linux/v4l2-common.h>

// /*
//  * Attention: Keep the V4L2_STD_* bit definitions in sync with
//  * include/dt-bindings/display/sdtv-standards.h SDTV_STD_* bit definitions.
//  */
// /* one bit for each */
// #define V4L2_STD_PAL_B          ((v4l2_std_id)0x00000001)
// #define V4L2_STD_PAL_B1         ((v4l2_std_id)0x00000002)
// #define V4L2_STD_PAL_G          ((v4l2_std_id)0x00000004)
// #define V4L2_STD_PAL_H          ((v4l2_std_id)0x00000008)
// #define V4L2_STD_PAL_I          ((v4l2_std_id)0x00000010)
// #define V4L2_STD_PAL_D          ((v4l2_std_id)0x00000020)
// #define V4L2_STD_PAL_D1         ((v4l2_std_id)0x00000040)
// #define V4L2_STD_PAL_K          ((v4l2_std_id)0x00000080)

// #define V4L2_STD_PAL_M          ((v4l2_std_id)0x00000100)
// #define V4L2_STD_PAL_N          ((v4l2_std_id)0x00000200)
// #define V4L2_STD_PAL_Nc         ((v4l2_std_id)0x00000400)
// #define V4L2_STD_PAL_60         ((v4l2_std_id)0x00000800)

// #define V4L2_STD_NTSC_M         ((v4l2_std_id)0x00001000) /* BTSC */
// #define V4L2_STD_NTSC_M_JP      ((v4l2_std_id)0x00002000) /* EIA-J */
// #define V4L2_STD_NTSC_443       ((v4l2_std_id)0x00004000)
// #define V4L2_STD_NTSC_M_KR      ((v4l2_std_id)0x00008000) /* FM A2 */

// #define V4L2_STD_SECAM_B        ((v4l2_std_id)0x00010000)
// #define V4L2_STD_SECAM_D        ((v4l2_std_id)0x00020000)
// #define V4L2_STD_SECAM_G        ((v4l2_std_id)0x00040000)
// #define V4L2_STD_SECAM_H        ((v4l2_std_id)0x00080000)
// #define V4L2_STD_SECAM_K        ((v4l2_std_id)0x00100000)
// #define V4L2_STD_SECAM_K1       ((v4l2_std_id)0x00200000)
// #define V4L2_STD_SECAM_L        ((v4l2_std_id)0x00400000)
// #define V4L2_STD_SECAM_LC       ((v4l2_std_id)0x00800000)

// /* ATSC/HDTV */
// #define V4L2_STD_ATSC_8_VSB     ((v4l2_std_id)0x01000000)
// #define V4L2_STD_ATSC_16_VSB    ((v4l2_std_id)0x02000000)

// /* FIXME:
//    Although std_id is 64 bits, there is an issue on PPC32 architecture that
//    makes switch(__u64) to break. So, there's a hack on v4l2-common.c rounding
//    this value to 32 bits.
//    As, currently, the max value is for V4L2_STD_ATSC_16_VSB (30 bits wide),
//    it should work fine. However, if needed to add more than two standards,
//    v4l2-common.c should be fixed.
//  */

// /*
//  * Some macros to merge video standards in order to make live easier for the
//  * drivers and V4L2 applications
//  */

// /*
//  * "Common" NTSC/M - It should be noticed that V4L2_STD_NTSC_443 is
//  * Missing here.
//  */
// #define V4L2_STD_NTSC           (V4L2_STD_NTSC_M |\
//      V4L2_STD_NTSC_M_JP     |\
//      V4L2_STD_NTSC_M_KR)
// /* Secam macros */
// #define V4L2_STD_SECAM_DK (V4L2_STD_SECAM_D |\
//      V4L2_STD_SECAM_K |\
//      V4L2_STD_SECAM_K1)
// /* All Secam Standards */
// #define V4L2_STD_SECAM  (V4L2_STD_SECAM_B |\
//      V4L2_STD_SECAM_G |\
//      V4L2_STD_SECAM_H |\
//      V4L2_STD_SECAM_DK |\
//      V4L2_STD_SECAM_L       |\
//      V4L2_STD_SECAM_LC)
// /* PAL macros */
// #define V4L2_STD_PAL_BG  (V4L2_STD_PAL_B  |\
//      V4L2_STD_PAL_B1 |\
//      V4L2_STD_PAL_G)
// #define V4L2_STD_PAL_DK  (V4L2_STD_PAL_D  |\
//      V4L2_STD_PAL_D1 |\
//      V4L2_STD_PAL_K)
// /*
//  * "Common" PAL - This macro is there to be compatible with the old
//  * V4L1 concept of "PAL": /BGDKHI.
//  * Several PAL standards are missing here: /M, /N and /Nc
//  */
// #define V4L2_STD_PAL  (V4L2_STD_PAL_BG |\
//      V4L2_STD_PAL_DK |\
//      V4L2_STD_PAL_H  |\
//      V4L2_STD_PAL_I)
// /* Chroma "agnostic" standards */
// #define V4L2_STD_B  (V4L2_STD_PAL_B  |\
//      V4L2_STD_PAL_B1 |\
//      V4L2_STD_SECAM_B)
// #define V4L2_STD_G  (V4L2_STD_PAL_G  |\
//      V4L2_STD_SECAM_G)
// #define V4L2_STD_H  (V4L2_STD_PAL_H  |\
//      V4L2_STD_SECAM_H)
// #define V4L2_STD_L  (V4L2_STD_SECAM_L |\
//      V4L2_STD_SECAM_LC)
// #define V4L2_STD_GH  (V4L2_STD_G  |\
//      V4L2_STD_H)
// #define V4L2_STD_DK  (V4L2_STD_PAL_DK |\
//      V4L2_STD_SECAM_DK)
// #define V4L2_STD_BG  (V4L2_STD_B  |\
//      V4L2_STD_G)
// #define V4L2_STD_MN  (V4L2_STD_PAL_M  |\
//      V4L2_STD_PAL_N  |\
//      V4L2_STD_PAL_Nc |\
//      V4L2_STD_NTSC)

// /* Standards where MTS/BTSC stereo could be found */
// #define V4L2_STD_MTS  (V4L2_STD_NTSC_M |\
//      V4L2_STD_PAL_M  |\
//      V4L2_STD_PAL_N  |\
//      V4L2_STD_PAL_Nc)

// /* Standards for Countries with 60Hz Line frequency */
// #define V4L2_STD_525_60  (V4L2_STD_PAL_M  |\
//      V4L2_STD_PAL_60 |\
//      V4L2_STD_NTSC  |\
//      V4L2_STD_NTSC_443)
// /* Standards for Countries with 50Hz Line frequency */
// #define V4L2_STD_625_50  (V4L2_STD_PAL  |\
//      V4L2_STD_PAL_N  |\
//      V4L2_STD_PAL_Nc |\
//      V4L2_STD_SECAM)

// #define V4L2_STD_ATSC           (V4L2_STD_ATSC_8_VSB    |\
//      V4L2_STD_ATSC_16_VSB)
// /* Macros with none and all analog standards */
// #define V4L2_STD_UNKNOWN        0
// #define V4L2_STD_ALL            (V4L2_STD_525_60 |\
//      V4L2_STD_625_50)

// struct v4l2_standard {
//  __u32       index;
//  v4l2_std_id          id;
//  __u8       name[24];
//  struct v4l2_fract    frameperiod; /* Frames, not fields */
//  __u32       framelines;
//  __u32       reserved[4];
// };

// /*
//  * D V B T T I M I N G S
//  */

// /** struct v4l2_bt_timings - BT.656/BT.1120 timing data
//  * @width: total width of the active video in pixels
//  * @height: total height of the active video in lines
//  * @interlaced: Interlaced or progressive
//  * @polarities: Positive or negative polarities
//  * @pixelclock: Pixel clock in HZ. Ex. 74.25MHz->74250000
//  * @hfrontporch:Horizontal front porch in pixels
//  * @hsync: Horizontal Sync length in pixels
//  * @hbackporch: Horizontal back porch in pixels
//  * @vfrontporch:Vertical front porch in lines
//  * @vsync: Vertical Sync length in lines
//  * @vbackporch: Vertical back porch in lines
//  * @il_vfrontporch:Vertical front porch for the even field
//  *  (aka field 2) of interlaced field formats
//  * @il_vsync: Vertical Sync length for the even field
//  *  (aka field 2) of interlaced field formats
//  * @il_vbackporch:Vertical back porch for the even field
//  *  (aka field 2) of interlaced field formats
//  * @standards: Standards the timing belongs to
//  * @flags: Flags
//  * @picture_aspect: The picture aspect ratio (hor/vert).
//  * @cea861_vic: VIC code as per the CEA-861 standard.
//  * @hdmi_vic: VIC code as per the HDMI standard.
//  * @reserved: Reserved fields, must be zeroed.
//  *
//  * A note regarding vertical interlaced timings: height refers to the total
//  * height of the active video frame (= two fields). The blanking timings refer
//  * to the blanking of each field. So the height of the total frame is
//  * calculated as follows:
//  *
//  * tot_height = height + vfrontporch + vsync + vbackporch +
//  *                       il_vfrontporch + il_vsync + il_vbackporch
//  *
//  * The active height of each field is height / 2.
//  */
// struct v4l2_bt_timings {
//  __u32 width;
//  __u32 height;
//  __u32 interlaced;
//  __u32 polarities;
//  __u64 pixelclock;
//  __u32 hfrontporch;
//  __u32 hsync;
//  __u32 hbackporch;
//  __u32 vfrontporch;
//  __u32 vsync;
//  __u32 vbackporch;
//  __u32 il_vfrontporch;
//  __u32 il_vsync;
//  __u32 il_vbackporch;
//  __u32 standards;
//  __u32 flags;
//  struct v4l2_fract picture_aspect;
//  __u8 cea861_vic;
//  __u8 hdmi_vic;
//  __u8 reserved[46];
// } __attribute__ ((packed));

// /* Interlaced or progressive format */
// #define V4L2_DV_PROGRESSIVE 0
// #define V4L2_DV_INTERLACED 1

// /* Polarities. If bit is not set, it is assumed to be negative polarity */
// #define V4L2_DV_VSYNC_POS_POL 0x00000001
// #define V4L2_DV_HSYNC_POS_POL 0x00000002

// /* Timings standards */
// #define V4L2_DV_BT_STD_CEA861 (1 << 0)  /* CEA-861 Digital TV Profile */
// #define V4L2_DV_BT_STD_DMT (1 << 1)  /* VESA Discrete Monitor Timings */
// #define V4L2_DV_BT_STD_CVT (1 << 2)  /* VESA Coordinated Video Timings */
// #define V4L2_DV_BT_STD_GTF (1 << 3)  /* VESA Generalized Timings Formula */
// #define V4L2_DV_BT_STD_SDI (1 << 4)  /* SDI Timings */

// /* Flags */

// /*
//  * CVT/GTF specific: timing uses reduced blanking (CVT) or the 'Secondary
//  * GTF' curve (GTF). In both cases the horizontal and/or vertical blanking
//  * intervals are reduced, allowing a higher resolution over the same
//  * bandwidth. This is a read-only flag.
//  */
// #define V4L2_DV_FL_REDUCED_BLANKING  (1 << 0)
// /*
//  * CEA-861 specific: set for CEA-861 formats with a framerate of a multiple
//  * of six. These formats can be optionally played at 1 / 1.001 speed.
//  * This is a read-only flag.
//  */
// #define V4L2_DV_FL_CAN_REDUCE_FPS  (1 << 1)
// /*
//  * CEA-861 specific: only valid for video transmitters, the flag is cleared
//  * by receivers.
//  * If the framerate of the format is a multiple of six, then the pixelclock
//  * used to set up the transmitter is divided by 1.001 to make it compatible
//  * with 60 Hz based standards such as NTSC and PAL-M that use a framerate of
//  * 29.97 Hz. Otherwise this flag is cleared. If the transmitter can't generate
//  * such frequencies, then the flag will also be cleared.
//  */
// #define V4L2_DV_FL_REDUCED_FPS   (1 << 2)
// /*
//  * Specific to interlaced formats: if set, then field 1 is really one half-line
//  * longer and field 2 is really one half-line shorter, so each field has
//  * exactly the same number of half-lines. Whether half-lines can be detected
//  * or used depends on the hardware.
//  */
// #define V4L2_DV_FL_HALF_LINE   (1 << 3)
// /*
//  * If set, then this is a Consumer Electronics (CE) video format. Such formats
//  * differ from other formats (commonly called IT formats) in that if RGB
//  * encoding is used then by default the RGB values use limited range (i.e.
//  * use the range 16-235) as opposed to 0-255. All formats defined in CEA-861
//  * except for the 640x480 format are CE formats.
//  */
// #define V4L2_DV_FL_IS_CE_VIDEO   (1 << 4)
// /* Some formats like SMPTE-125M have an interlaced signal with a odd
//  * total height. For these formats, if this flag is set, the first
//  * field has the extra line. If not, it is the second field.
//  */
// #define V4L2_DV_FL_FIRST_FIELD_EXTRA_LINE (1 << 5)
// /*
//  * If set, then the picture_aspect field is valid. Otherwise assume that the
//  * pixels are square, so the picture aspect ratio is the same as the width to
//  * height ratio.
//  */
// #define V4L2_DV_FL_HAS_PICTURE_ASPECT  (1 << 6)
// /*
//  * If set, then the cea861_vic field is valid and contains the Video
//  * Identification Code as per the CEA-861 standard.
//  */
// #define V4L2_DV_FL_HAS_CEA861_VIC  (1 << 7)
// /*
//  * If set, then the hdmi_vic field is valid and contains the Video
//  * Identification Code as per the HDMI standard (HDMI Vendor Specific
//  * InfoFrame).
//  */
// #define V4L2_DV_FL_HAS_HDMI_VIC   (1 << 8)
// /*
//  * CEA-861 specific: only valid for video receivers.
//  * If set, then HW can detect the difference between regular FPS and
//  * 1000/1001 FPS. Note: This flag is only valid for HDMI VIC codes with
//  * the V4L2_DV_FL_CAN_REDUCE_FPS flag set.
//  */
// #define V4L2_DV_FL_CAN_DETECT_REDUCED_FPS (1 << 9)

// /* A few useful defines to calculate the total blanking and frame sizes */
// #define V4L2_DV_BT_BLANKING_WIDTH(bt) \
//  ((bt)->hfrontporch + (bt)->hsync + (bt)->hbackporch)
// #define V4L2_DV_BT_FRAME_WIDTH(bt) \
//  ((bt)->width + V4L2_DV_BT_BLANKING_WIDTH(bt))
// #define V4L2_DV_BT_BLANKING_HEIGHT(bt) \
//  ((bt)->vfrontporch + (bt)->vsync + (bt)->vbackporch + \
//   ((bt)->interlaced ? \
//    ((bt)->il_vfrontporch + (bt)->il_vsync + (bt)->il_vbackporch) : 0))
// #define V4L2_DV_BT_FRAME_HEIGHT(bt) \
//  ((bt)->height + V4L2_DV_BT_BLANKING_HEIGHT(bt))

// /** struct v4l2_dv_timings - DV timings
//  * @type: the type of the timings
//  * @bt: BT656/1120 timings
//  */
// struct v4l2_dv_timings {
//  __u32 type;
//  union {
//   struct v4l2_bt_timings bt;
//   __u32 reserved[32];
//  };
// } __attribute__ ((packed));

// /* Values for the type field */
// #define V4L2_DV_BT_656_1120 0 /* BT.656/1120 timing type */

// /** struct v4l2_enum_dv_timings - DV timings enumeration
//  * @index: enumeration index
//  * @pad: the pad number for which to enumerate timings (used with
//  *  v4l-subdev nodes only)
//  * @reserved: must be zeroed
//  * @timings: the timings for the given index
//  */
// struct v4l2_enum_dv_timings {
//  __u32 index;
//  __u32 pad;
//  __u32 reserved[2];
//  struct v4l2_dv_timings timings;
// };

// /** struct v4l2_bt_timings_cap - BT.656/BT.1120 timing capabilities
//  * @min_width:  width in pixels
//  * @max_width:  width in pixels
//  * @min_height:  height in lines
//  * @max_height:  height in lines
//  * @min_pixelclock: Pixel clock in HZ. Ex. 74.25MHz->74250000
//  * @max_pixelclock: Pixel clock in HZ. Ex. 74.25MHz->74250000
//  * @standards:  Supported standards
//  * @capabilities: Supported capabilities
//  * @reserved:  Must be zeroed
//  */
// struct v4l2_bt_timings_cap {
//  __u32 min_width;
//  __u32 max_width;
//  __u32 min_height;
//  __u32 max_height;
//  __u64 min_pixelclock;
//  __u64 max_pixelclock;
//  __u32 standards;
//  __u32 capabilities;
//  __u32 reserved[16];
// } __attribute__ ((packed));

// /* Supports interlaced formats */
// #define V4L2_DV_BT_CAP_INTERLACED (1 << 0)
// /* Supports progressive formats */
// #define V4L2_DV_BT_CAP_PROGRESSIVE (1 << 1)
// /* Supports CVT/GTF reduced blanking */
// #define V4L2_DV_BT_CAP_REDUCED_BLANKING (1 << 2)
// /* Supports custom formats */
// #define V4L2_DV_BT_CAP_CUSTOM  (1 << 3)

// /** struct v4l2_dv_timings_cap - DV timings capabilities
//  * @type: the type of the timings (same as in struct v4l2_dv_timings)
//  * @pad: the pad number for which to query capabilities (used with
//  *  v4l-subdev nodes only)
//  * @bt:  the BT656/1120 timings capabilities
//  */
// struct v4l2_dv_timings_cap {
//  __u32 type;
//  __u32 pad;
//  __u32 reserved[2];
//  union {
//   struct v4l2_bt_timings_cap bt;
//   __u32 raw_data[32];
//  };
// };

// /*
//  * V I D E O   I N P U T S
//  */
// struct v4l2_input {
//  __u32      index;  /*  Which input */
//  __u8      name[32];  /*  Label */
//  __u32      type;  /*  Type of input */
//  __u32      audioset;  /*  Associated audios (bitfield) */
//  __u32        tuner;             /*  Tuner index */
//  v4l2_std_id  std;
//  __u32      status;
//  __u32      capabilities;
//  __u32      reserved[3];
// };

// /*  Values for the 'type' field */
// #define V4L2_INPUT_TYPE_TUNER  1
// #define V4L2_INPUT_TYPE_CAMERA  2
// #define V4L2_INPUT_TYPE_TOUCH  3

// /* field 'status' - general */
// #define V4L2_IN_ST_NO_POWER    0x00000001  /* Attached device is off */
// #define V4L2_IN_ST_NO_SIGNAL   0x00000002
// #define V4L2_IN_ST_NO_COLOR    0x00000004

// /* field 'status' - sensor orientation */
// /* If sensor is mounted upside down set both bits */
// #define V4L2_IN_ST_HFLIP       0x00000010 /* Frames are flipped horizontally */
// #define V4L2_IN_ST_VFLIP       0x00000020 /* Frames are flipped vertically */

// /* field 'status' - analog */
// #define V4L2_IN_ST_NO_H_LOCK   0x00000100  /* No horizontal sync lock */
// #define V4L2_IN_ST_COLOR_KILL  0x00000200  /* Color killer is active */
// #define V4L2_IN_ST_NO_V_LOCK   0x00000400  /* No vertical sync lock */
// #define V4L2_IN_ST_NO_STD_LOCK 0x00000800  /* No standard format lock */

// /* field 'status' - digital */
// #define V4L2_IN_ST_NO_SYNC     0x00010000  /* No synchronization lock */
// #define V4L2_IN_ST_NO_EQU      0x00020000  /* No equalizer lock */
// #define V4L2_IN_ST_NO_CARRIER  0x00040000  /* Carrier recovery failed */

// /* field 'status' - VCR and set-top box */
// #define V4L2_IN_ST_MACROVISION 0x01000000  /* Macrovision detected */
// #define V4L2_IN_ST_NO_ACCESS   0x02000000  /* Conditional access denied */
// #define V4L2_IN_ST_VTR         0x04000000  /* VTR time constant */

// /* capabilities flags */
// #define V4L2_IN_CAP_DV_TIMINGS  0x00000002 /* Supports S_DV_TIMINGS */
// #define V4L2_IN_CAP_CUSTOM_TIMINGS V4L2_IN_CAP_DV_TIMINGS /* For compatibility */
// #define V4L2_IN_CAP_STD   0x00000004 /* Supports S_STD */
// #define V4L2_IN_CAP_NATIVE_SIZE  0x00000008 /* Supports setting native size */

// /*
//  * V I D E O   O U T P U T S
//  */
// struct v4l2_output {
//  __u32      index;  /*  Which output */
//  __u8      name[32];  /*  Label */
//  __u32      type;  /*  Type of output */
//  __u32      audioset;  /*  Associated audios (bitfield) */
//  __u32      modulator;         /*  Associated modulator */
//  v4l2_std_id  std;
//  __u32      capabilities;
//  __u32      reserved[3];
// };
// /*  Values for the 'type' field */
// #define V4L2_OUTPUT_TYPE_MODULATOR  1
// #define V4L2_OUTPUT_TYPE_ANALOG   2
// #define V4L2_OUTPUT_TYPE_ANALOGVGAOVERLAY 3

// /* capabilities flags */
// #define V4L2_OUT_CAP_DV_TIMINGS  0x00000002 /* Supports S_DV_TIMINGS */
// #define V4L2_OUT_CAP_CUSTOM_TIMINGS V4L2_OUT_CAP_DV_TIMINGS /* For compatibility */
// #define V4L2_OUT_CAP_STD  0x00000004 /* Supports S_STD */
// #define V4L2_OUT_CAP_NATIVE_SIZE 0x00000008 /* Supports setting native size */

// /*
//  * C O N T R O L S
//  */
// struct v4l2_control {
//  __u32       id;
//  __s32       value;
// };

// struct v4l2_ext_control {
//  __u32 id;
//  __u32 size;
//  __u32 reserved2[1];
//  union {
//   __s32 value;
//   __s64 value64;
//   char *string;
//   __u8 *p_u8;
//   __u16 *p_u16;
//   __u32 *p_u32;
//   __s32 *p_s32;
//   __s64 *p_s64;
//   struct v4l2_area *p_area;
//   struct v4l2_rect *p_rect;
//   struct v4l2_ctrl_h264_sps *p_h264_sps;
//   struct v4l2_ctrl_h264_pps *p_h264_pps;
//   struct v4l2_ctrl_h264_scaling_matrix *p_h264_scaling_matrix;
//   struct v4l2_ctrl_h264_pred_weights *p_h264_pred_weights;
//   struct v4l2_ctrl_h264_slice_params *p_h264_slice_params;
//   struct v4l2_ctrl_h264_decode_params *p_h264_decode_params;
//   struct v4l2_ctrl_fwht_params *p_fwht_params;
//   struct v4l2_ctrl_vp8_frame *p_vp8_frame;
//   struct v4l2_ctrl_mpeg2_sequence *p_mpeg2_sequence;
//   struct v4l2_ctrl_mpeg2_picture *p_mpeg2_picture;
//   struct v4l2_ctrl_mpeg2_quantisation *p_mpeg2_quantisation;
//   struct v4l2_ctrl_vp9_compressed_hdr *p_vp9_compressed_hdr_probs;
//   struct v4l2_ctrl_vp9_frame *p_vp9_frame;
//   struct v4l2_ctrl_hevc_sps *p_hevc_sps;
//   struct v4l2_ctrl_hevc_pps *p_hevc_pps;
//   struct v4l2_ctrl_hevc_slice_params *p_hevc_slice_params;
//   struct v4l2_ctrl_hevc_scaling_matrix *p_hevc_scaling_matrix;
//   struct v4l2_ctrl_hevc_decode_params *p_hevc_decode_params;
//   struct v4l2_ctrl_av1_sequence *p_av1_sequence;
//   struct v4l2_ctrl_av1_tile_group_entry *p_av1_tile_group_entry;
//   struct v4l2_ctrl_av1_frame *p_av1_frame;
//   struct v4l2_ctrl_av1_film_grain *p_av1_film_grain;
//   struct v4l2_ctrl_hdr10_cll_info *p_hdr10_cll_info;
//   struct v4l2_ctrl_hdr10_mastering_display *p_hdr10_mastering_display;
//   void *ptr;
//  } __attribute__ ((packed));
// } __attribute__ ((packed));

// struct v4l2_ext_controls {
//  union {
//   __u32 ctrl_class;
//   __u32 which;
//  };
//  __u32 count;
//  __u32 error_idx;
//  __s32 request_fd;
//  __u32 reserved[1];
//  struct v4l2_ext_control *controls;
// };

// #define V4L2_CTRL_ID_MASK   (0x0fffffff)
// #define V4L2_CTRL_ID2CLASS(id)    ((id) & 0x0fff0000UL)
// #define V4L2_CTRL_ID2WHICH(id)    ((id) & 0x0fff0000UL)
// #define V4L2_CTRL_DRIVER_PRIV(id) (((id) & 0xffff) >= 0x1000)
// #define V4L2_CTRL_MAX_DIMS   (4)
// #define V4L2_CTRL_WHICH_CUR_VAL   0
// #define V4L2_CTRL_WHICH_DEF_VAL   0x0f000000
// #define V4L2_CTRL_WHICH_REQUEST_VAL 0x0f010000
// #define V4L2_CTRL_WHICH_MIN_VAL   0x0f020000
// #define V4L2_CTRL_WHICH_MAX_VAL   0x0f030000

// enum v4l2_ctrl_type {
//  V4L2_CTRL_TYPE_INTEGER      = 1,
//  V4L2_CTRL_TYPE_BOOLEAN      = 2,
//  V4L2_CTRL_TYPE_MENU      = 3,
//  V4L2_CTRL_TYPE_BUTTON      = 4,
//  V4L2_CTRL_TYPE_INTEGER64     = 5,
//  V4L2_CTRL_TYPE_CTRL_CLASS    = 6,
//  V4L2_CTRL_TYPE_STRING        = 7,
//  V4L2_CTRL_TYPE_BITMASK       = 8,
//  V4L2_CTRL_TYPE_INTEGER_MENU  = 9,

//  /* Compound types are >= 0x0100 */
//  V4L2_CTRL_COMPOUND_TYPES     = 0x0100,
//  V4L2_CTRL_TYPE_U8      = 0x0100,
//  V4L2_CTRL_TYPE_U16      = 0x0101,
//  V4L2_CTRL_TYPE_U32      = 0x0102,
//  V4L2_CTRL_TYPE_AREA          = 0x0106,
//  V4L2_CTRL_TYPE_RECT      = 0x0107,

//  V4L2_CTRL_TYPE_HDR10_CLL_INFO  = 0x0110,
//  V4L2_CTRL_TYPE_HDR10_MASTERING_DISPLAY = 0x0111,

//  V4L2_CTRL_TYPE_H264_SPS             = 0x0200,
//  V4L2_CTRL_TYPE_H264_PPS      = 0x0201,
//  V4L2_CTRL_TYPE_H264_SCALING_MATRIX  = 0x0202,
//  V4L2_CTRL_TYPE_H264_SLICE_PARAMS    = 0x0203,
//  V4L2_CTRL_TYPE_H264_DECODE_PARAMS   = 0x0204,
//  V4L2_CTRL_TYPE_H264_PRED_WEIGHTS    = 0x0205,

//  V4L2_CTRL_TYPE_FWHT_PARAMS     = 0x0220,

//  V4L2_CTRL_TYPE_VP8_FRAME            = 0x0240,

//  V4L2_CTRL_TYPE_MPEG2_QUANTISATION   = 0x0250,
//  V4L2_CTRL_TYPE_MPEG2_SEQUENCE       = 0x0251,
//  V4L2_CTRL_TYPE_MPEG2_PICTURE        = 0x0252,

//  V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR = 0x0260,
//  V4L2_CTRL_TYPE_VP9_FRAME  = 0x0261,

//  V4L2_CTRL_TYPE_HEVC_SPS   = 0x0270,
//  V4L2_CTRL_TYPE_HEVC_PPS   = 0x0271,
//  V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS = 0x0272,
//  V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX = 0x0273,
//  V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS = 0x0274,

//  V4L2_CTRL_TYPE_AV1_SEQUENCE     = 0x280,
//  V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY = 0x281,
//  V4L2_CTRL_TYPE_AV1_FRAME     = 0x282,
//  V4L2_CTRL_TYPE_AV1_FILM_GRAIN     = 0x283,
// };

// /*  Used in the VIDIOC_QUERYCTRL ioctl for querying controls */
// struct v4l2_queryctrl {
//  __u32       id;
//  __u32       type; /* enum v4l2_ctrl_type */
//  __u8       name[32]; /* Whatever */
//  __s32       minimum; /* Note signedness */
//  __s32       maximum;
//  __s32       step;
//  __s32       default_value;
//  __u32                flags;
//  __u32       reserved[2];
// };

// /*  Used in the VIDIOC_QUERY_EXT_CTRL ioctl for querying extended controls */
// struct v4l2_query_ext_ctrl {
//  __u32       id;
//  __u32       type;
//  char       name[32];
//  __s64       minimum;
//  __s64       maximum;
//  __u64       step;
//  __s64       default_value;
//  __u32                flags;
//  __u32                elem_size;
//  __u32                elems;
//  __u32                nr_of_dims;
//  __u32                dims[V4L2_CTRL_MAX_DIMS];
//  __u32       reserved[32];
// };

// /*  Used in the VIDIOC_QUERYMENU ioctl for querying menu items */
// struct v4l2_querymenu {
//  __u32  id;
//  __u32  index;
//  union {
//   __u8 name[32]; /* Whatever */
//   __s64 value;
//  };
//  __u32  reserved;
// } __attribute__ ((packed));

// /*  Control flags  */
// #define V4L2_CTRL_FLAG_DISABLED  0x0001
// #define V4L2_CTRL_FLAG_GRABBED  0x0002
// #define V4L2_CTRL_FLAG_READ_ONLY 0x0004
// #define V4L2_CTRL_FLAG_UPDATE  0x0008
// #define V4L2_CTRL_FLAG_INACTIVE  0x0010
// #define V4L2_CTRL_FLAG_SLIDER  0x0020
// #define V4L2_CTRL_FLAG_WRITE_ONLY 0x0040
// #define V4L2_CTRL_FLAG_VOLATILE  0x0080
// #define V4L2_CTRL_FLAG_HAS_PAYLOAD 0x0100
// #define V4L2_CTRL_FLAG_EXECUTE_ON_WRITE 0x0200
// #define V4L2_CTRL_FLAG_MODIFY_LAYOUT 0x0400
// #define V4L2_CTRL_FLAG_DYNAMIC_ARRAY 0x0800
// #define V4L2_CTRL_FLAG_HAS_WHICH_MIN_MAX 0x1000

// /*  Query flags, to be ORed with the control ID */
// #define V4L2_CTRL_FLAG_NEXT_CTRL 0x80000000
// #define V4L2_CTRL_FLAG_NEXT_COMPOUND 0x40000000

// /*  User-class control IDs defined by V4L2 */
// #define V4L2_CID_MAX_CTRLS  1024
// /*  IDs reserved for driver specific controls */
// #define V4L2_CID_PRIVATE_BASE  0x08000000

// /*
//  * T U N I N G
//  */
// struct v4l2_tuner {
//  __u32                   index;
//  __u8   name[32];
//  __u32   type; /* enum v4l2_tuner_type */
//  __u32   capability;
//  __u32   rangelow;
//  __u32   rangehigh;
//  __u32   rxsubchans;
//  __u32   audmode;
//  __s32   signal;
//  __s32   afc;
//  __u32   reserved[4];
// };

// struct v4l2_modulator {
//  __u32   index;
//  __u8   name[32];
//  __u32   capability;
//  __u32   rangelow;
//  __u32   rangehigh;
//  __u32   txsubchans;
//  __u32   type; /* enum v4l2_tuner_type */
//  __u32   reserved[3];
// };

// /*  Flags for the 'capability' field */
// #define V4L2_TUNER_CAP_LOW  0x0001
// #define V4L2_TUNER_CAP_NORM  0x0002
// #define V4L2_TUNER_CAP_HWSEEK_BOUNDED 0x0004
// #define V4L2_TUNER_CAP_HWSEEK_WRAP 0x0008
// #define V4L2_TUNER_CAP_STEREO  0x0010
// #define V4L2_TUNER_CAP_LANG2  0x0020
// #define V4L2_TUNER_CAP_SAP  0x0020
// #define V4L2_TUNER_CAP_LANG1  0x0040
// #define V4L2_TUNER_CAP_RDS  0x0080
// #define V4L2_TUNER_CAP_RDS_BLOCK_IO 0x0100
// #define V4L2_TUNER_CAP_RDS_CONTROLS 0x0200
// #define V4L2_TUNER_CAP_FREQ_BANDS 0x0400
// #define V4L2_TUNER_CAP_HWSEEK_PROG_LIM 0x0800
// #define V4L2_TUNER_CAP_1HZ  0x1000

// /*  Flags for the 'rxsubchans' field */
// #define V4L2_TUNER_SUB_MONO  0x0001
// #define V4L2_TUNER_SUB_STEREO  0x0002
// #define V4L2_TUNER_SUB_LANG2  0x0004
// #define V4L2_TUNER_SUB_SAP  0x0004
// #define V4L2_TUNER_SUB_LANG1  0x0008
// #define V4L2_TUNER_SUB_RDS  0x0010

// /*  Values for the 'audmode' field */
// #define V4L2_TUNER_MODE_MONO  0x0000
// #define V4L2_TUNER_MODE_STEREO  0x0001
// #define V4L2_TUNER_MODE_LANG2  0x0002
// #define V4L2_TUNER_MODE_SAP  0x0002
// #define V4L2_TUNER_MODE_LANG1  0x0003
// #define V4L2_TUNER_MODE_LANG1_LANG2 0x0004

// struct v4l2_frequency {
//  __u32 tuner;
//  __u32 type; /* enum v4l2_tuner_type */
//  __u32 frequency;
//  __u32 reserved[8];
// };

// #define V4L2_BAND_MODULATION_VSB (1 << 1)
// #define V4L2_BAND_MODULATION_FM  (1 << 2)
// #define V4L2_BAND_MODULATION_AM  (1 << 3)

// struct v4l2_frequency_band {
//  __u32 tuner;
//  __u32 type; /* enum v4l2_tuner_type */
//  __u32 index;
//  __u32 capability;
//  __u32 rangelow;
//  __u32 rangehigh;
//  __u32 modulation;
//  __u32 reserved[9];
// };

// struct v4l2_hw_freq_seek {
//  __u32 tuner;
//  __u32 type; /* enum v4l2_tuner_type */
//  __u32 seek_upward;
//  __u32 wrap_around;
//  __u32 spacing;
//  __u32 rangelow;
//  __u32 rangehigh;
//  __u32 reserved[5];
// };

// /*
//  * R D S
//  */

// struct v4l2_rds_data {
//  __u8 lsb;
//  __u8 msb;
//  __u8 block;
// } __attribute__ ((packed));

// #define V4L2_RDS_BLOCK_MSK  0x7
// #define V4L2_RDS_BLOCK_A  0
// #define V4L2_RDS_BLOCK_B  1
// #define V4L2_RDS_BLOCK_C  2
// #define V4L2_RDS_BLOCK_D  3
// #define V4L2_RDS_BLOCK_C_ALT  4
// #define V4L2_RDS_BLOCK_INVALID  7

// #define V4L2_RDS_BLOCK_CORRECTED 0x40
// #define V4L2_RDS_BLOCK_ERROR  0x80

// /*
//  * A U D I O
//  */
// struct v4l2_audio {
//  __u32 index;
//  __u8 name[32];
//  __u32 capability;
//  __u32 mode;
//  __u32 reserved[2];
// };

// /*  Flags for the 'capability' field */
// #define V4L2_AUDCAP_STEREO  0x00001
// #define V4L2_AUDCAP_AVL   0x00002

// /*  Flags for the 'mode' field */
// #define V4L2_AUDMODE_AVL  0x00001

// struct v4l2_audioout {
//  __u32 index;
//  __u8 name[32];
//  __u32 capability;
//  __u32 mode;
//  __u32 reserved[2];
// };

// /*
//  * M P E G   S E R V I C E S
//  */
// #if 1
// #define V4L2_ENC_IDX_FRAME_I    (0)
// #define V4L2_ENC_IDX_FRAME_P    (1)
// #define V4L2_ENC_IDX_FRAME_B    (2)
// #define V4L2_ENC_IDX_FRAME_MASK (0xf)

// struct v4l2_enc_idx_entry {
//  __u64 offset;
//  __u64 pts;
//  __u32 length;
//  __u32 flags;
//  __u32 reserved[2];
// };

// #define V4L2_ENC_IDX_ENTRIES (64)
// struct v4l2_enc_idx {
//  __u32 entries;
//  __u32 entries_cap;
//  __u32 reserved[4];
//  struct v4l2_enc_idx_entry entry[V4L2_ENC_IDX_ENTRIES];
// };

// #define V4L2_ENC_CMD_START      (0)
// #define V4L2_ENC_CMD_STOP       (1)
// #define V4L2_ENC_CMD_PAUSE      (2)
// #define V4L2_ENC_CMD_RESUME     (3)

// /* Flags for V4L2_ENC_CMD_STOP */
// #define V4L2_ENC_CMD_STOP_AT_GOP_END    (1 << 0)

// struct v4l2_encoder_cmd {
//  __u32 cmd;
//  __u32 flags;
//  union {
//   struct {
//    __u32 data[8];
//   } raw;
//  };
// };

// /* Decoder commands */
// #define V4L2_DEC_CMD_START       (0)
// #define V4L2_DEC_CMD_STOP        (1)
// #define V4L2_DEC_CMD_PAUSE       (2)
// #define V4L2_DEC_CMD_RESUME      (3)
// #define V4L2_DEC_CMD_FLUSH       (4)

// /* Flags for V4L2_DEC_CMD_START */
// #define V4L2_DEC_CMD_START_MUTE_AUDIO (1 << 0)

// /* Flags for V4L2_DEC_CMD_PAUSE */
// #define V4L2_DEC_CMD_PAUSE_TO_BLACK (1 << 0)

// /* Flags for V4L2_DEC_CMD_STOP */
// #define V4L2_DEC_CMD_STOP_TO_BLACK (1 << 0)
// #define V4L2_DEC_CMD_STOP_IMMEDIATELY (1 << 1)

// /* Play format requirements (returned by the driver): */

// /* The decoder has no special format requirements */
// #define V4L2_DEC_START_FMT_NONE  (0)
// /* The decoder requires full GOPs */
// #define V4L2_DEC_START_FMT_GOP  (1)

// /* The structure must be zeroed before use by the application
//    This ensures it can be extended safely in the future. */
// struct v4l2_decoder_cmd {
//  __u32 cmd;
//  __u32 flags;
//  union {
//   struct {
//    __u64 pts;
//   } stop;

//   struct {
//    /* 0 or 1000 specifies normal speed,
//       1 specifies forward single stepping,
//       -1 specifies backward single stepping,
//       >1: playback at speed/1000 of the normal speed,
//       <-1: reverse playback at (-speed/1000) of the normal speed. */
//    __s32 speed;
//    __u32 format;
//   } start;

//   struct {
//    __u32 data[16];
//   } raw;
//  };
// };
// #endif

// /*
//  * D A T A   S E R V I C E S   ( V B I )
//  *
//  * Data services API by Michael Schimek
//  */

// /* Raw VBI */
// struct v4l2_vbi_format {
//  __u32 sampling_rate;  /* in 1 Hz */
//  __u32 offset;
//  __u32 samples_per_line;
//  __u32 sample_format;  /* V4L2_PIX_FMT_* */
//  __s32 start[2];
//  __u32 count[2];
//  __u32 flags;   /* V4L2_VBI_* */
//  __u32 reserved[2];  /* must be zero */
// };

// /*  VBI flags  */
// #define V4L2_VBI_UNSYNC  (1 << 0)
// #define V4L2_VBI_INTERLACED (1 << 1)

// /* ITU-R start lines for each field */
// #define V4L2_VBI_ITU_525_F1_START (1)
// #define V4L2_VBI_ITU_525_F2_START (264)
// #define V4L2_VBI_ITU_625_F1_START (1)
// #define V4L2_VBI_ITU_625_F2_START (314)

// /* Sliced VBI
//  *
//  *    This implements is a proposal V4L2 API to allow SLICED VBI
//  * required for some hardware encoders. It should change without
//  * notice in the definitive implementation.
//  */

// struct v4l2_sliced_vbi_format {
//  __u16   service_set;
//  /* service_lines[0][...] specifies lines 0-23 (1-23 used) of the first field
//     service_lines[1][...] specifies lines 0-23 (1-23 used) of the second field
//      (equals frame lines 313-336 for 625 line video
//       standards, 263-286 for 525 line standards) */
//  __u16   service_lines[2][24];
//  __u32   io_size;
//  __u32   reserved[2];            /* must be zero */
// };

// /* Teletext World System Teletext
//    (WST), defined on ITU-R BT.653-2 */
// #define V4L2_SLICED_TELETEXT_B          (0x0001)
// /* Video Program System, defined on ETS 300 231*/
// #define V4L2_SLICED_VPS                 (0x0400)
// /* Closed Caption, defined on EIA-608 */
// #define V4L2_SLICED_CAPTION_525         (0x1000)
// /* Wide Screen System, defined on ITU-R BT1119.1 */
// #define V4L2_SLICED_WSS_625             (0x4000)

// #define V4L2_SLICED_VBI_525             (V4L2_SLICED_CAPTION_525)
// #define V4L2_SLICED_VBI_625             (V4L2_SLICED_TELETEXT_B | V4L2_SLICED_VPS | V4L2_SLICED_WSS_625)

// struct v4l2_sliced_vbi_cap {
//  __u16   service_set;
//  /* service_lines[0][...] specifies lines 0-23 (1-23 used) of the first field
//     service_lines[1][...] specifies lines 0-23 (1-23 used) of the second field
//      (equals frame lines 313-336 for 625 line video
//       standards, 263-286 for 525 line standards) */
//  __u16   service_lines[2][24];
//  __u32 type;  /* enum v4l2_buf_type */
//  __u32   reserved[3];    /* must be 0 */
// };

// struct v4l2_sliced_vbi_data {
//  __u32   id;
//  __u32   field;          /* 0: first field, 1: second field */
//  __u32   line;           /* 1-23 */
//  __u32   reserved;       /* must be 0 */
//  __u8    data[48];
// };

// /*
//  * Sliced VBI data inserted into MPEG Streams
//  */

// /*
//  * V4L2_MPEG_STREAM_VBI_FMT_IVTV:
//  *
//  * Structure of payload contained in an MPEG 2 Private Stream 1 PES Packet in an
//  * MPEG-2 Program Pack that contains V4L2_MPEG_STREAM_VBI_FMT_IVTV Sliced VBI
//  * data
//  *
//  * Note, the MPEG-2 Program Pack and Private Stream 1 PES packet header
//  * definitions are not included here.  See the MPEG-2 specifications for details
//  * on these headers.
//  */

// /* Line type IDs */
// #define V4L2_MPEG_VBI_IVTV_TELETEXT_B     (1)
// #define V4L2_MPEG_VBI_IVTV_CAPTION_525    (4)
// #define V4L2_MPEG_VBI_IVTV_WSS_625        (5)
// #define V4L2_MPEG_VBI_IVTV_VPS            (7)

// struct v4l2_mpeg_vbi_itv0_line {
//  __u8 id; /* One of V4L2_MPEG_VBI_IVTV_* above */
//  __u8 data[42]; /* Sliced VBI data for the line */
// } __attribute__ ((packed));

// struct v4l2_mpeg_vbi_itv0 {
//  __le32 linemask[2]; /* Bitmasks of VBI service lines present */
//  struct v4l2_mpeg_vbi_itv0_line line[35];
// } __attribute__ ((packed));

// struct v4l2_mpeg_vbi_ITV0 {
//  struct v4l2_mpeg_vbi_itv0_line line[36];
// } __attribute__ ((packed));

// #define V4L2_MPEG_VBI_IVTV_MAGIC0 "itv0"
// #define V4L2_MPEG_VBI_IVTV_MAGIC1 "ITV0"

// struct v4l2_mpeg_vbi_fmt_ivtv {
//  __u8 magic[4];
//  union {
//   struct v4l2_mpeg_vbi_itv0 itv0;
//   struct v4l2_mpeg_vbi_ITV0 ITV0;
//  };
// } __attribute__ ((packed));

// /*
//  * A G G R E G A T E   S T R U C T U R E S
//  */

// /**
//  * struct v4l2_plane_pix_format - additional, per-plane format definition
//  * @sizeimage:  maximum size in bytes required for data, for which
//  *   this plane will be used
//  * @bytesperline: distance in bytes between the leftmost pixels in two
//  *   adjacent lines
//  * @reserved:  drivers and applications must zero this array
//  */
// struct v4l2_plane_pix_format {
//  __u32  sizeimage;
//  __u32  bytesperline;
//  __u16  reserved[6];
// } __attribute__ ((packed));

// /**
//  * struct v4l2_pix_format_mplane - multiplanar format definition
//  * @width:  image width in pixels
//  * @height:  image height in pixels
//  * @pixelformat: little endian four character code (fourcc)
//  * @field:  enum v4l2_field; field order (for interlaced video)
//  * @colorspace:  enum v4l2_colorspace; supplemental to pixelformat
//  * @plane_fmt:  per-plane information
//  * @num_planes:  number of planes for this format
//  * @flags:  format flags (V4L2_PIX_FMT_FLAG_*)
//  * @ycbcr_enc:  enum v4l2_ycbcr_encoding, Y'CbCr encoding
//  * @hsv_enc:  enum v4l2_hsv_encoding, HSV encoding
//  * @quantization: enum v4l2_quantization, colorspace quantization
//  * @xfer_func:  enum v4l2_xfer_func, colorspace transfer function
//  * @reserved:  drivers and applications must zero this array
//  */
// struct v4l2_pix_format_mplane {
//  __u32    width;
//  __u32    height;
//  __u32    pixelformat;
//  __u32    field;
//  __u32    colorspace;

//  struct v4l2_plane_pix_format plane_fmt[VIDEO_MAX_PLANES];
//  __u8    num_planes;
//  __u8    flags;
//   union {
//   __u8    ycbcr_enc;
//   __u8    hsv_enc;
//  };
//  __u8    quantization;
//  __u8    xfer_func;
//  __u8    reserved[7];
// } __attribute__ ((packed));

// /**
//  * struct v4l2_sdr_format - SDR format definition
//  * @pixelformat: little endian four character code (fourcc)
//  * @buffersize:  maximum size in bytes required for data
//  * @reserved:  drivers and applications must zero this array
//  */
// struct v4l2_sdr_format {
//  __u32    pixelformat;
//  __u32    buffersize;
//  __u8    reserved[24];
// } __attribute__ ((packed));

// /**
//  * struct v4l2_meta_format - metadata format definition
//  * @dataformat:  little endian four character code (fourcc)
//  * @buffersize:  maximum size in bytes required for data
//  * @width:  number of data units of data per line (valid for line
//  *   based formats only, see format documentation)
//  * @height:  number of lines of data per buffer (valid for line based
//  *   formats only)
//  * @bytesperline: offset between the beginnings of two adjacent lines in
//  *   bytes (valid for line based formats only)
//  */
// struct v4l2_meta_format {
//  __u32    dataformat;
//  __u32    buffersize;
//  __u32    width;
//  __u32    height;
//  __u32    bytesperline;
// } __attribute__ ((packed));

// /**
//  * struct v4l2_format - stream data format
//  * @type:  enum v4l2_buf_type; type of the data stream
//  * @fmt.pix:  definition of an image format
//  * @fmt.pix_mp:  definition of a multiplanar image format
//  * @fmt.win:  definition of an overlaid image
//  * @fmt.vbi:  raw VBI capture or output parameters
//  * @fmt.sliced:  sliced VBI capture or output parameters
//  * @fmt.raw_data: placeholder for future extensions and custom formats
//  * @fmt:  union of @pix, @pix_mp, @win, @vbi, @sliced, @sdr,
//  *   @meta and @raw_data
//  */
// struct v4l2_format {
//  __u32  type;
//  union {
//   struct v4l2_pix_format  pix;     /* V4L2_BUF_TYPE_VIDEO_CAPTURE */
//   struct v4l2_pix_format_mplane pix_mp;  /* V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE */
//   struct v4l2_window  win;     /* V4L2_BUF_TYPE_VIDEO_OVERLAY */
//   struct v4l2_vbi_format  vbi;     /* V4L2_BUF_TYPE_VBI_CAPTURE */
//   struct v4l2_sliced_vbi_format sliced;  /* V4L2_BUF_TYPE_SLICED_VBI_CAPTURE */
//   struct v4l2_sdr_format  sdr;     /* V4L2_BUF_TYPE_SDR_CAPTURE */
//   struct v4l2_meta_format  meta;    /* V4L2_BUF_TYPE_META_CAPTURE */
//   __u8 raw_data[200];                   /* user-defined */
//  } fmt;
// };

// /* Stream type-dependent parameters
//  */
// struct v4l2_streamparm {
//  __u32  type;   /* enum v4l2_buf_type */
//  union {
//   struct v4l2_captureparm capture;
//   struct v4l2_outputparm output;
//   __u8 raw_data[200];  /* user-defined */
//  } parm;
// };

// /*
//  * E V E N T S
//  */

// #define V4L2_EVENT_ALL    0
// #define V4L2_EVENT_VSYNC   1
// #define V4L2_EVENT_EOS    2
// #define V4L2_EVENT_CTRL    3
// #define V4L2_EVENT_FRAME_SYNC   4
// #define V4L2_EVENT_SOURCE_CHANGE  5
// #define V4L2_EVENT_MOTION_DET   6
// #define V4L2_EVENT_PRIVATE_START  0x08000000

// /* Payload for V4L2_EVENT_VSYNC */
// struct v4l2_event_vsync {
//  /* Can be V4L2_FIELD_ANY, _NONE, _TOP or _BOTTOM */
//  __u8 field;
// } __attribute__ ((packed));

// /* Payload for V4L2_EVENT_CTRL */
// #define V4L2_EVENT_CTRL_CH_VALUE  (1 << 0)
// #define V4L2_EVENT_CTRL_CH_FLAGS  (1 << 1)
// #define V4L2_EVENT_CTRL_CH_RANGE  (1 << 2)
// #define V4L2_EVENT_CTRL_CH_DIMENSIONS  (1 << 3)

// struct v4l2_event_ctrl {
//  __u32 changes;
//  __u32 type;
//  union {
//   __s32 value;
//   __s64 value64;
//  };
//  __u32 flags;
//  __s32 minimum;
//  __s32 maximum;
//  __s32 step;
//  __s32 default_value;
// };

// struct v4l2_event_frame_sync {
//  __u32 frame_sequence;
// };

// #define V4L2_EVENT_SRC_CH_RESOLUTION  (1 << 0)

// struct v4l2_event_src_change {
//  __u32 changes;
// };

// #define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ (1 << 0)

// /**
//  * struct v4l2_event_motion_det - motion detection event
//  * @flags:             if V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ is set, then the
//  *                     frame_sequence field is valid.
//  * @frame_sequence:    the frame sequence number associated with this event.
//  * @region_mask:       which regions detected motion.
//  */
// struct v4l2_event_motion_det {
//  __u32 flags;
//  __u32 frame_sequence;
//  __u32 region_mask;
// };

// struct v4l2_event {
//  __u32    type;
//  union {
//   struct v4l2_event_vsync  vsync;
//   struct v4l2_event_ctrl  ctrl;
//   struct v4l2_event_frame_sync frame_sync;
//   struct v4l2_event_src_change src_change;
//   struct v4l2_event_motion_det motion_det;
//   __u8    data[64];
//  } u;
//  __u32    pending;
//  __u32    sequence;
//  struct timespec   timestamp;
//  __u32    id;
//  __u32    reserved[8];
// };

// #define V4L2_EVENT_SUB_FL_SEND_INITIAL  (1 << 0)
// #define V4L2_EVENT_SUB_FL_ALLOW_FEEDBACK (1 << 1)

// struct v4l2_event_subscription {
//  __u32    type;
//  __u32    id;
//  __u32    flags;
//  __u32    reserved[5];
// };

// /*
//  * A D V A N C E D   D E B U G G I N G
//  *
//  * NOTE: EXPERIMENTAL API, NEVER RELY ON THIS IN APPLICATIONS!
//  * FOR DEBUGGING, TESTING AND INTERNAL USE ONLY!
//  */

// /* VIDIOC_DBG_G_REGISTER and VIDIOC_DBG_S_REGISTER */

// #define V4L2_CHIP_MATCH_BRIDGE      0  /* Match against chip ID on the bridge (0 for the bridge) */
// #define V4L2_CHIP_MATCH_SUBDEV      4  /* Match against subdev index */

// /* The following four defines are no longer in use */
// #define V4L2_CHIP_MATCH_HOST V4L2_CHIP_MATCH_BRIDGE
// #define V4L2_CHIP_MATCH_I2C_DRIVER  1  /* Match against I2C driver name */
// #define V4L2_CHIP_MATCH_I2C_ADDR    2  /* Match against I2C 7-bit address */
// #define V4L2_CHIP_MATCH_AC97        3  /* Match against ancillary AC97 chip */

// struct v4l2_dbg_match {
//  __u32 type; /* Match type */
//  union {     /* Match this chip, meaning determined by type */
//   __u32 addr;
//   char name[32];
//  };
// } __attribute__ ((packed));

// struct v4l2_dbg_register {
//  struct v4l2_dbg_match match;
//  __u32 size; /* register size in bytes */
//  __u64 reg;
//  __u64 val;
// } __attribute__ ((packed));

// #define V4L2_CHIP_FL_READABLE (1 << 0)
// #define V4L2_CHIP_FL_WRITABLE (1 << 1)

// /* VIDIOC_DBG_G_CHIP_INFO */
// struct v4l2_dbg_chip_info {
//  struct v4l2_dbg_match match;
//  char name[32];
//  __u32 flags;
//  __u32 reserved[32];
// } __attribute__ ((packed));

// /**
//  * struct v4l2_create_buffers - VIDIOC_CREATE_BUFS argument
//  * @index: on return, index of the first created buffer
//  * @count: entry: number of requested buffers,
//  *  return: number of created buffers
//  * @memory: enum v4l2_memory; buffer memory type
//  * @format: frame format, for which buffers are requested
//  * @capabilities: capabilities of this buffer type.
//  * @flags: additional buffer management attributes (ignored unless the
//  *  queue has V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS capability
//  *  and configured for MMAP streaming I/O).
//  * @max_num_buffers: if V4L2_BUF_CAP_SUPPORTS_MAX_NUM_BUFFERS capability flag is set
//  *  this field indicate the maximum possible number of buffers
//  *  for this queue.
//  * @reserved: future extensions
//  */
// struct v4l2_create_buffers {
//  __u32   index;
//  __u32   count;
//  __u32   memory;
//  struct v4l2_format format;
//  __u32   capabilities;
//  __u32   flags;
//  __u32   max_num_buffers;
//  __u32   reserved[5];
// };

// /**
//  * struct v4l2_remove_buffers - VIDIOC_REMOVE_BUFS argument
//  * @index: the first buffer to be removed
//  * @count: number of buffers to removed
//  * @type: enum v4l2_buf_type
//  * @reserved: future extensions
//  */
// struct v4l2_remove_buffers {
//  __u32   index;
//  __u32   count;
//  __u32   type;
//  __u32   reserved[13];
// };

// /*
//  * I O C T L   C O D E S   F O R   V I D E O   D E V I C E S
//  *
//  */
// #define VIDIOC_QUERYCAP   _IOR('V',  0, struct v4l2_capability)
// #define VIDIOC_ENUM_FMT         _IOWR('V',  2, struct v4l2_fmtdesc)
// #define VIDIOC_G_FMT  _IOWR('V',  4, struct v4l2_format)
// #define VIDIOC_S_FMT  _IOWR('V',  5, struct v4l2_format)
// #define VIDIOC_REQBUFS  _IOWR('V',  8, struct v4l2_requestbuffers)
// #define VIDIOC_QUERYBUF  _IOWR('V',  9, struct v4l2_buffer)
// #define VIDIOC_G_FBUF   _IOR('V', 10, struct v4l2_framebuffer)
// #define VIDIOC_S_FBUF   _IOW('V', 11, struct v4l2_framebuffer)
// #define VIDIOC_OVERLAY   _IOW('V', 14, int)
// #define VIDIOC_QBUF  _IOWR('V', 15, struct v4l2_buffer)
// #define VIDIOC_EXPBUF  _IOWR('V', 16, struct v4l2_exportbuffer)
// #define VIDIOC_DQBUF  _IOWR('V', 17, struct v4l2_buffer)
// #define VIDIOC_STREAMON   _IOW('V', 18, int)
// #define VIDIOC_STREAMOFF  _IOW('V', 19, int)
// #define VIDIOC_G_PARM  _IOWR('V', 21, struct v4l2_streamparm)
// #define VIDIOC_S_PARM  _IOWR('V', 22, struct v4l2_streamparm)
// #define VIDIOC_G_STD   _IOR('V', 23, v4l2_std_id)
// #define VIDIOC_S_STD   _IOW('V', 24, v4l2_std_id)
// #define VIDIOC_ENUMSTD  _IOWR('V', 25, struct v4l2_standard)
// #define VIDIOC_ENUMINPUT _IOWR('V', 26, struct v4l2_input)
// #define VIDIOC_G_CTRL  _IOWR('V', 27, struct v4l2_control)
// #define VIDIOC_S_CTRL  _IOWR('V', 28, struct v4l2_control)
// #define VIDIOC_G_TUNER  _IOWR('V', 29, struct v4l2_tuner)
// #define VIDIOC_S_TUNER   _IOW('V', 30, struct v4l2_tuner)
// #define VIDIOC_G_AUDIO   _IOR('V', 33, struct v4l2_audio)
// #define VIDIOC_S_AUDIO   _IOW('V', 34, struct v4l2_audio)
// #define VIDIOC_QUERYCTRL _IOWR('V', 36, struct v4l2_queryctrl)
// #define VIDIOC_QUERYMENU _IOWR('V', 37, struct v4l2_querymenu)
// #define VIDIOC_G_INPUT   _IOR('V', 38, int)
// #define VIDIOC_S_INPUT  _IOWR('V', 39, int)
// #define VIDIOC_G_EDID  _IOWR('V', 40, struct v4l2_edid)
// #define VIDIOC_S_EDID  _IOWR('V', 41, struct v4l2_edid)
// #define VIDIOC_G_OUTPUT   _IOR('V', 46, int)
// #define VIDIOC_S_OUTPUT  _IOWR('V', 47, int)
// #define VIDIOC_ENUMOUTPUT _IOWR('V', 48, struct v4l2_output)
// #define VIDIOC_G_AUDOUT   _IOR('V', 49, struct v4l2_audioout)
// #define VIDIOC_S_AUDOUT   _IOW('V', 50, struct v4l2_audioout)
// #define VIDIOC_G_MODULATOR _IOWR('V', 54, struct v4l2_modulator)
// #define VIDIOC_S_MODULATOR  _IOW('V', 55, struct v4l2_modulator)
// #define VIDIOC_G_FREQUENCY _IOWR('V', 56, struct v4l2_frequency)
// #define VIDIOC_S_FREQUENCY  _IOW('V', 57, struct v4l2_frequency)
// #define VIDIOC_CROPCAP  _IOWR('V', 58, struct v4l2_cropcap)
// #define VIDIOC_G_CROP  _IOWR('V', 59, struct v4l2_crop)
// #define VIDIOC_S_CROP   _IOW('V', 60, struct v4l2_crop)
// #define VIDIOC_G_JPEGCOMP  _IOR('V', 61, struct v4l2_jpegcompression)
// #define VIDIOC_S_JPEGCOMP  _IOW('V', 62, struct v4l2_jpegcompression)
// #define VIDIOC_QUERYSTD   _IOR('V', 63, v4l2_std_id)
// #define VIDIOC_TRY_FMT  _IOWR('V', 64, struct v4l2_format)
// #define VIDIOC_ENUMAUDIO _IOWR('V', 65, struct v4l2_audio)
// #define VIDIOC_ENUMAUDOUT _IOWR('V', 66, struct v4l2_audioout)
// #define VIDIOC_G_PRIORITY  _IOR('V', 67, __u32) /* enum v4l2_priority */
// #define VIDIOC_S_PRIORITY  _IOW('V', 68, __u32) /* enum v4l2_priority */
// #define VIDIOC_G_SLICED_VBI_CAP _IOWR('V', 69, struct v4l2_sliced_vbi_cap)
// #define VIDIOC_LOG_STATUS         _IO('V', 70)
// #define VIDIOC_G_EXT_CTRLS _IOWR('V', 71, struct v4l2_ext_controls)
// #define VIDIOC_S_EXT_CTRLS _IOWR('V', 72, struct v4l2_ext_controls)
// #define VIDIOC_TRY_EXT_CTRLS _IOWR('V', 73, struct v4l2_ext_controls)
// #define VIDIOC_ENUM_FRAMESIZES _IOWR('V', 74, struct v4l2_frmsizeenum)
// #define VIDIOC_ENUM_FRAMEINTERVALS _IOWR('V', 75, struct v4l2_frmivalenum)
// #define VIDIOC_G_ENC_INDEX       _IOR('V', 76, struct v4l2_enc_idx)
// #define VIDIOC_ENCODER_CMD      _IOWR('V', 77, struct v4l2_encoder_cmd)
// #define VIDIOC_TRY_ENCODER_CMD  _IOWR('V', 78, struct v4l2_encoder_cmd)

// /*
//  * Experimental, meant for debugging, testing and internal use.
//  * Only implemented if CONFIG_VIDEO_ADV_DEBUG is defined.
//  * You must be root to use these ioctls. Never use these in applications!
//  */
// #define VIDIOC_DBG_S_REGISTER  _IOW('V', 79, struct v4l2_dbg_register)
// #define VIDIOC_DBG_G_REGISTER _IOWR('V', 80, struct v4l2_dbg_register)

// #define VIDIOC_S_HW_FREQ_SEEK  _IOW('V', 82, struct v4l2_hw_freq_seek)
// #define VIDIOC_S_DV_TIMINGS _IOWR('V', 87, struct v4l2_dv_timings)
// #define VIDIOC_G_DV_TIMINGS _IOWR('V', 88, struct v4l2_dv_timings)
// #define VIDIOC_DQEVENT   _IOR('V', 89, struct v4l2_event)
// #define VIDIOC_SUBSCRIBE_EVENT  _IOW('V', 90, struct v4l2_event_subscription)
// #define VIDIOC_UNSUBSCRIBE_EVENT _IOW('V', 91, struct v4l2_event_subscription)
// #define VIDIOC_CREATE_BUFS _IOWR('V', 92, struct v4l2_create_buffers)
// #define VIDIOC_PREPARE_BUF _IOWR('V', 93, struct v4l2_buffer)
// #define VIDIOC_G_SELECTION _IOWR('V', 94, struct v4l2_selection)
// #define VIDIOC_S_SELECTION _IOWR('V', 95, struct v4l2_selection)
// #define VIDIOC_DECODER_CMD _IOWR('V', 96, struct v4l2_decoder_cmd)
// #define VIDIOC_TRY_DECODER_CMD _IOWR('V', 97, struct v4l2_decoder_cmd)
// #define VIDIOC_ENUM_DV_TIMINGS  _IOWR('V', 98, struct v4l2_enum_dv_timings)
// #define VIDIOC_QUERY_DV_TIMINGS  _IOR('V', 99, struct v4l2_dv_timings)
// #define VIDIOC_DV_TIMINGS_CAP   _IOWR('V', 100, struct v4l2_dv_timings_cap)
// #define VIDIOC_ENUM_FREQ_BANDS _IOWR('V', 101, struct v4l2_frequency_band)

// /*
//  * Experimental, meant for debugging, testing and internal use.
//  * Never use this in applications!
//  */
// #define VIDIOC_DBG_G_CHIP_INFO  _IOWR('V', 102, struct v4l2_dbg_chip_info)

// #define VIDIOC_QUERY_EXT_CTRL _IOWR('V', 103, struct v4l2_query_ext_ctrl)
// #define VIDIOC_REMOVE_BUFS _IOWR('V', 104, struct v4l2_remove_buffers)

// /* Reminder: when adding new ioctls please add support for them to
//    drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */

// #define BASE_VIDIOC_PRIVATE 192  /* 192-255 are private */

// /* Deprecated definitions kept for backwards compatibility */
// #define V4L2_PIX_FMT_HM12 V4L2_PIX_FMT_NV12_16L16
// #define V4L2_PIX_FMT_SUNXI_TILED_NV12 V4L2_PIX_FMT_NV12_32L32
// /*
//  * This capability was never implemented, anyone using this cap should drop it
//  * from their code.
//  */
// #define V4L2_CAP_ASYNCIO 0x02000000

// #endif /* __LINUX_VIDEODEV2_H */
