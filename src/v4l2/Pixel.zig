const std = @import("std");
const builtin = @import("builtin");
pub const Pixel = @This();

pub fn fourcc(a: u8, b: u8, c: u8, d: u8) u32 {
    return (@as(u32, a)) | (@as(u32, b) << 8) | (@as(u32, c) << 16) | (@as(u32, d) << 24);
}

pub fn fourcc_be(a: u8, b: u8, c: u8, d: u8) u32 {
    return fourcc(a, b, c, d) | (@as(u32, 1) << 31);
}

pub const private_magic: u32 = 0xfeedcafe;

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

pub const max_planes: u32 = 8;

pub const Plane = extern struct {
    sizeimage: u32,
    bytesperline: u32,
    reserved: [6]u16,
};

pub const Mplane = extern struct {
    width: u32,
    height: u32,
    pixelformat: u32,
    field: u32,
    colorspace: u32,
    plane_fmt: [max_planes]Plane,
    num_planes: u8,
    flags: u8,
    encoding: u8,
    quantization: u8,
    xfer_func: u8,
    reserved: [7]u8,
};

pub const SdrFormat = extern struct {
    pixelformat: u32,
    buffersize: u32,
    reserved: [24]u8,
};

pub const MetaFormat = extern struct {
    dataformat: u32,
    buffersize: u32,
    width: u32,
    height: u32,
    bytesperline: u32,
};

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
