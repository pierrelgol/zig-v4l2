const std = @import("std");
const bindings = @import("bindings");
const abi = @import("abi.zig");
const ioctl = @import("ioctl.zig");

comptime {
    std.testing.refAllDecls(@This());
}

pub const DeviceInfo = extern struct {
    driver: [16]u8,
    model: [32]u8,
    serial: [40]u8,
    bus_info: [32]u8,
    media_version: u32,
    hw_revision: u32,
    driver_version: u32,
    reserved: [31]u32,
};

pub const Version = struct {
    pub const api: u32 = @intCast(bindings.MEDIA_API_VERSION);
    pub const v4_19_0: u32 = (4 << 16) | (19 << 8) | 0;

    pub fn make(major: u8, minor: u8, patch: u8) u32 {
        return (@as(u32, major) << 16) | (@as(u32, minor) << 8) | @as(u32, patch);
    }

    pub fn hasV2EntityFlags(media_version: u32) bool {
        return bindings.MEDIA_V2_ENTITY_HAS_FLAGS(media_version);
    }

    pub fn hasV2PadIndex(media_version: u32) bool {
        return bindings.MEDIA_V2_PAD_HAS_INDEX(media_version);
    }
};

pub const Entity = extern struct {
    id: u32,
    name: [32]u8,
    type: u32,
    revision: u32,
    flags: u32,
    group_id: u32,
    pads: u16,
    links: u16,
    reserved: [4]u32,
    info: extern union {
        dev: extern struct {
            major: u32,
            minor: u32,
        },
        alsa: extern struct {
            card: u32,
            device: u32,
            subdevice: u32,
        },
        v4l: extern struct {
            major: u32,
            minor: u32,
        },
        fb: extern struct {
            major: u32,
            minor: u32,
        },
        dvb: i32,
        raw: [184]u8,
    },

    pub const Range = struct {
        pub const base: u32 = @intCast(bindings.MEDIA_ENT_F_BASE);
        pub const old_base: u32 = @intCast(bindings.MEDIA_ENT_F_OLD_BASE);
        pub const old_subdev_base: u32 = @intCast(bindings.MEDIA_ENT_F_OLD_SUBDEV_BASE);
    };

    pub const Function = enum(u32) {
        unknown = @intCast(bindings.MEDIA_ENT_F_UNKNOWN),
        v4l2_subdev_unknown = @intCast(bindings.MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN),
        dtv_demod = @intCast(bindings.MEDIA_ENT_F_DTV_DEMOD),
        ts_demux = @intCast(bindings.MEDIA_ENT_F_TS_DEMUX),
        dtv_ca = @intCast(bindings.MEDIA_ENT_F_DTV_CA),
        dtv_net_decap = @intCast(bindings.MEDIA_ENT_F_DTV_NET_DECAP),
        io_v4l = @intCast(bindings.MEDIA_ENT_F_IO_V4L),
        io_dtv = @intCast(bindings.MEDIA_ENT_F_IO_DTV),
        io_vbi = @intCast(bindings.MEDIA_ENT_F_IO_VBI),
        io_swradio = @intCast(bindings.MEDIA_ENT_F_IO_SWRADIO),
        cam_sensor = @intCast(bindings.MEDIA_ENT_F_CAM_SENSOR),
        flash = @intCast(bindings.MEDIA_ENT_F_FLASH),
        lens = @intCast(bindings.MEDIA_ENT_F_LENS),
        tuner = @intCast(bindings.MEDIA_ENT_F_TUNER),
        if_vid_decoder = @intCast(bindings.MEDIA_ENT_F_IF_VID_DECODER),
        if_aud_decoder = @intCast(bindings.MEDIA_ENT_F_IF_AUD_DECODER),
        audio_capture = @intCast(bindings.MEDIA_ENT_F_AUDIO_CAPTURE),
        audio_playback = @intCast(bindings.MEDIA_ENT_F_AUDIO_PLAYBACK),
        audio_mixer = @intCast(bindings.MEDIA_ENT_F_AUDIO_MIXER),
        proc_video_composer = @intCast(bindings.MEDIA_ENT_F_PROC_VIDEO_COMPOSER),
        proc_video_pixel_formatter = @intCast(bindings.MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER),
        proc_video_pixel_enc_conv = @intCast(bindings.MEDIA_ENT_F_PROC_VIDEO_PIXEL_ENC_CONV),
        proc_video_lut = @intCast(bindings.MEDIA_ENT_F_PROC_VIDEO_LUT),
        proc_video_scaler = @intCast(bindings.MEDIA_ENT_F_PROC_VIDEO_SCALER),
        proc_video_statistics = @intCast(bindings.MEDIA_ENT_F_PROC_VIDEO_STATISTICS),
        proc_video_encoder = @intCast(bindings.MEDIA_ENT_F_PROC_VIDEO_ENCODER),
        proc_video_decoder = @intCast(bindings.MEDIA_ENT_F_PROC_VIDEO_DECODER),
        proc_video_isp = @intCast(bindings.MEDIA_ENT_F_PROC_VIDEO_ISP),
        vid_mux = @intCast(bindings.MEDIA_ENT_F_VID_MUX),
        vid_if_bridge = @intCast(bindings.MEDIA_ENT_F_VID_IF_BRIDGE),
        atv_decoder = @intCast(bindings.MEDIA_ENT_F_ATV_DECODER),
        dv_decoder = @intCast(bindings.MEDIA_ENT_F_DV_DECODER),
        dv_encoder = @intCast(bindings.MEDIA_ENT_F_DV_ENCODER),
    };

    pub const Flag = enum(u32) {
        default = @intCast(bindings.MEDIA_ENT_FL_DEFAULT),
        connector = @intCast(bindings.MEDIA_ENT_FL_CONNECTOR),
        id_flag_next = @intCast(bindings.MEDIA_ENT_ID_FLAG_NEXT),
    };

    pub const Legacy = struct {
        pub const type_shift: u32 = @intCast(bindings.MEDIA_ENT_TYPE_SHIFT);
        pub const type_mask: u32 = @intCast(bindings.MEDIA_ENT_TYPE_MASK);
        pub const subtype_mask: u32 = @intCast(bindings.MEDIA_ENT_SUBTYPE_MASK);

        pub const Type = struct {
            pub const devnode_unknown: u32 = @intCast(bindings.MEDIA_ENT_T_DEVNODE_UNKNOWN);
            pub const devnode: u32 = @intCast(bindings.MEDIA_ENT_T_DEVNODE);
            pub const devnode_v4l: u32 = @intCast(bindings.MEDIA_ENT_T_DEVNODE_V4L);
            pub const devnode_fb: u32 = @intCast(bindings.MEDIA_ENT_T_DEVNODE_FB);
            pub const devnode_alsa: u32 = @intCast(bindings.MEDIA_ENT_T_DEVNODE_ALSA);
            pub const devnode_dvb: u32 = @intCast(bindings.MEDIA_ENT_T_DEVNODE_DVB);
            pub const unknown: u32 = @intCast(bindings.MEDIA_ENT_T_UNKNOWN);
            pub const v4l2_video: u32 = @intCast(bindings.MEDIA_ENT_T_V4L2_VIDEO);
            pub const v4l2_subdev: u32 = @intCast(bindings.MEDIA_ENT_T_V4L2_SUBDEV);
            pub const v4l2_subdev_sensor: u32 = @intCast(bindings.MEDIA_ENT_T_V4L2_SUBDEV_SENSOR);
            pub const v4l2_subdev_flash: u32 = @intCast(bindings.MEDIA_ENT_T_V4L2_SUBDEV_FLASH);
            pub const v4l2_subdev_lens: u32 = @intCast(bindings.MEDIA_ENT_T_V4L2_SUBDEV_LENS);
            pub const v4l2_subdev_decoder: u32 = @intCast(bindings.MEDIA_ENT_T_V4L2_SUBDEV_DECODER);
            pub const v4l2_subdev_tuner: u32 = @intCast(bindings.MEDIA_ENT_T_V4L2_SUBDEV_TUNER);
        };

        pub const Function = struct {
            pub const dtv_decoder: Entity.Function = .dv_decoder;
        };
    };
};

pub const Pad = extern struct {
    entity: u32,
    index: u16,
    flags: u32,
    reserved: [2]u32,

    pub const Flag = enum(u32) {
        sink = @intCast(bindings.MEDIA_PAD_FL_SINK),
        source = @intCast(bindings.MEDIA_PAD_FL_SOURCE),
        must_connect = @intCast(bindings.MEDIA_PAD_FL_MUST_CONNECT),
    };
};

pub const Link = extern struct {
    source: Pad,
    sink: Pad,
    flags: u32,
    reserved: [2]u32,

    pub const Flag = enum(u32) {
        enabled = @intCast(bindings.MEDIA_LNK_FL_ENABLED),
        immutable = @intCast(bindings.MEDIA_LNK_FL_IMMUTABLE),
        dynamic = @intCast(bindings.MEDIA_LNK_FL_DYNAMIC),
        link_type = @intCast(bindings.MEDIA_LNK_FL_LINK_TYPE),
        data = @intCast(bindings.MEDIA_LNK_FL_DATA_LINK),
        interface = @intCast(bindings.MEDIA_LNK_FL_INTERFACE_LINK),
        ancillary = @intCast(bindings.MEDIA_LNK_FL_ANCILLARY_LINK),
    };
};

pub const LinksEnum = extern struct {
    entity: u32,
    pads: [*c]Pad,
    links: [*c]Link,
    reserved: [4]u32,
};

pub const Interface = struct {
    pub const Range = struct {
        pub const dvb_base: u32 = @intCast(bindings.MEDIA_INTF_T_DVB_BASE);
        pub const v4l_base: u32 = @intCast(bindings.MEDIA_INTF_T_V4L_BASE);
        pub const alsa_base: u32 = @intCast(bindings.MEDIA_INTF_T_ALSA_BASE);
    };

    pub const Type = enum(u32) {
        dvb_fe = @intCast(bindings.MEDIA_INTF_T_DVB_FE),
        dvb_demux = @intCast(bindings.MEDIA_INTF_T_DVB_DEMUX),
        dvb_dvr = @intCast(bindings.MEDIA_INTF_T_DVB_DVR),
        dvb_ca = @intCast(bindings.MEDIA_INTF_T_DVB_CA),
        dvb_net = @intCast(bindings.MEDIA_INTF_T_DVB_NET),
        v4l_video = @intCast(bindings.MEDIA_INTF_T_V4L_VIDEO),
        v4l_vbi = @intCast(bindings.MEDIA_INTF_T_V4L_VBI),
        v4l_radio = @intCast(bindings.MEDIA_INTF_T_V4L_RADIO),
        v4l_subdev = @intCast(bindings.MEDIA_INTF_T_V4L_SUBDEV),
        v4l_swradio = @intCast(bindings.MEDIA_INTF_T_V4L_SWRADIO),
        v4l_touch = @intCast(bindings.MEDIA_INTF_T_V4L_TOUCH),
        alsa_pcm_capture = @intCast(bindings.MEDIA_INTF_T_ALSA_PCM_CAPTURE),
        alsa_pcm_playback = @intCast(bindings.MEDIA_INTF_T_ALSA_PCM_PLAYBACK),
        alsa_control = @intCast(bindings.MEDIA_INTF_T_ALSA_CONTROL),
        alsa_compress = @intCast(bindings.MEDIA_INTF_T_ALSA_COMPRESS),
        alsa_rawmidi = @intCast(bindings.MEDIA_INTF_T_ALSA_RAWMIDI),
        alsa_hwdep = @intCast(bindings.MEDIA_INTF_T_ALSA_HWDEP),
        alsa_sequencer = @intCast(bindings.MEDIA_INTF_T_ALSA_SEQUENCER),
        alsa_timer = @intCast(bindings.MEDIA_INTF_T_ALSA_TIMER),
    };
};

pub const InterfaceType = Interface.Type;

pub const V2Entity = extern struct {
    id: u32 align(1),
    name: [64]u8,
    function: u32 align(1),
    flags: u32 align(1),
    reserved: [5]u32 align(1),
};

pub const V2InterfaceDevnode = extern struct {
    major: u32 align(1),
    minor: u32 align(1),
};

pub const V2Interface = extern struct {
    id: u32 align(1),
    intf_type: u32 align(1),
    flags: u32 align(1),
    reserved: [9]u32 align(1),
    info: extern union {
        devnode: V2InterfaceDevnode align(1),
        raw: [16]u32 align(1),
    } align(1),
};

pub const V2Pad = extern struct {
    id: u32 align(1),
    entity_id: u32 align(1),
    flags: u32 align(1),
    index: u32 align(1),
    reserved: [4]u32 align(1),
};

pub const V2Link = extern struct {
    id: u32 align(1),
    source_id: u32 align(1),
    sink_id: u32 align(1),
    flags: u32 align(1),
    reserved: [6]u32 align(1),
};

pub const Topology = extern struct {
    topology_version: u64 align(1),
    num_entities: u32 align(1),
    reserved1: u32 align(1),
    ptr_entities: u64 align(1),
    num_interfaces: u32 align(1),
    reserved2: u32 align(1),
    ptr_interfaces: u64 align(1),
    num_pads: u32 align(1),
    reserved3: u32 align(1),
    ptr_pads: u64 align(1),
    num_links: u32 align(1),
    reserved4: u32 align(1),
    ptr_links: u64 align(1),
};

pub const Ioctl = struct {
    pub const device_info: u32 = ioctl.iowr('|', 0x00, DeviceInfo);
    pub const enum_entities: u32 = ioctl.iowr('|', 0x01, Entity);
    pub const enum_links: u32 = ioctl.iowr('|', 0x02, LinksEnum);
    pub const setup_link: u32 = ioctl.iowr('|', 0x03, Link);
    pub const g_topology: u32 = ioctl.iowr('|', 0x04, Topology);
    pub const request_alloc: u32 = ioctl.ior('|', 0x05, i32);
};

pub const RequestIoctl = struct {
    pub const queue: u32 = ioctl.io('|', 0x80);
    pub const reinit: u32 = ioctl.io('|', 0x81);
};

test "Media.DeviceInfo ABI matches struct_media_device_info" {
    try abi.expectStruct(bindings.struct_media_device_info, DeviceInfo, &.{
        .{ .c_name = "driver", .z_name = "driver" },
        .{ .c_name = "model", .z_name = "model" },
        .{ .c_name = "serial", .z_name = "serial" },
        .{ .c_name = "bus_info", .z_name = "bus_info" },
        .{ .c_name = "media_version", .z_name = "media_version" },
        .{ .c_name = "hw_revision", .z_name = "hw_revision" },
        .{ .c_name = "driver_version", .z_name = "driver_version" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Media.Entity ABI matches struct_media_entity_desc" {
    const C = bindings.struct_media_entity_desc;
    const Z = Entity;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "id"), @offsetOf(Z, "id"));
    try std.testing.expectEqual(@offsetOf(C, "name"), @offsetOf(Z, "name"));
    try std.testing.expectEqual(@offsetOf(C, "type"), @offsetOf(Z, "type"));
    try std.testing.expectEqual(@offsetOf(C, "revision"), @offsetOf(Z, "revision"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "group_id"), @offsetOf(Z, "group_id"));
    try std.testing.expectEqual(@offsetOf(C, "pads"), @offsetOf(Z, "pads"));
    try std.testing.expectEqual(@offsetOf(C, "links"), @offsetOf(Z, "links"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
    try std.testing.expectEqual(@offsetOf(bindings.struct_media_entity_desc, "unnamed_0"), @offsetOf(Entity, "info"));
}

test "Media.Entity info ABI matches union_media_entity_desc_anon_0" {
    try abi.expectUnion(@FieldType(bindings.struct_media_entity_desc, "unnamed_0"), @FieldType(Entity, "info"), &.{
        .{ .c_name = "dev", .z_name = "dev" },
        .{ .c_name = "alsa", .z_name = "alsa" },
        .{ .c_name = "v4l", .z_name = "v4l" },
        .{ .c_name = "fb", .z_name = "fb" },
        .{ .c_name = "dvb", .z_name = "dvb" },
        .{ .c_name = "raw", .z_name = "raw" },
    });
}

test "Media.Pad ABI matches struct_media_pad_desc" {
    try abi.expectStruct(bindings.struct_media_pad_desc, Pad, &.{
        .{ .c_name = "entity", .z_name = "entity" },
        .{ .c_name = "index", .z_name = "index" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Media.Link ABI matches struct_media_link_desc" {
    try abi.expectStruct(bindings.struct_media_link_desc, Link, &.{
        .{ .c_name = "source", .z_name = "source" },
        .{ .c_name = "sink", .z_name = "sink" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Media.LinksEnum ABI matches struct_media_links_enum" {
    try abi.expectStruct(bindings.struct_media_links_enum, LinksEnum, &.{
        .{ .c_name = "entity", .z_name = "entity" },
        .{ .c_name = "pads", .z_name = "pads" },
        .{ .c_name = "links", .z_name = "links" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Media.V2Entity ABI matches struct_media_v2_entity" {
    try abi.expectStruct(bindings.struct_media_v2_entity, V2Entity, &.{
        .{ .c_name = "id", .z_name = "id" },
        .{ .c_name = "name", .z_name = "name" },
        .{ .c_name = "function", .z_name = "function" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Media.V2InterfaceDevnode ABI matches struct_media_v2_intf_devnode" {
    try abi.expectStruct(bindings.struct_media_v2_intf_devnode, V2InterfaceDevnode, &.{
        .{ .c_name = "major", .z_name = "major" },
        .{ .c_name = "minor", .z_name = "minor" },
    });
}

test "Media.V2Interface ABI matches struct_media_v2_interface" {
    const C = bindings.struct_media_v2_interface;
    const Z = V2Interface;
    try std.testing.expectEqual(@sizeOf(C), @sizeOf(Z));
    try std.testing.expectEqual(@alignOf(C), @alignOf(Z));
    try std.testing.expectEqual(@offsetOf(C, "id"), @offsetOf(Z, "id"));
    try std.testing.expectEqual(@offsetOf(C, "intf_type"), @offsetOf(Z, "intf_type"));
    try std.testing.expectEqual(@offsetOf(C, "flags"), @offsetOf(Z, "flags"));
    try std.testing.expectEqual(@offsetOf(C, "reserved"), @offsetOf(Z, "reserved"));
    try std.testing.expectEqual(@offsetOf(bindings.struct_media_v2_interface, "unnamed_0"), @offsetOf(V2Interface, "info"));
}

test "Media.V2Pad ABI matches struct_media_v2_pad" {
    try abi.expectStruct(bindings.struct_media_v2_pad, V2Pad, &.{
        .{ .c_name = "id", .z_name = "id" },
        .{ .c_name = "entity_id", .z_name = "entity_id" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "index", .z_name = "index" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Media.V2Link ABI matches struct_media_v2_link" {
    try abi.expectStruct(bindings.struct_media_v2_link, V2Link, &.{
        .{ .c_name = "id", .z_name = "id" },
        .{ .c_name = "source_id", .z_name = "source_id" },
        .{ .c_name = "sink_id", .z_name = "sink_id" },
        .{ .c_name = "flags", .z_name = "flags" },
        .{ .c_name = "reserved", .z_name = "reserved" },
    });
}

test "Media.Topology ABI matches struct_media_v2_topology" {
    try abi.expectStruct(bindings.struct_media_v2_topology, Topology, &.{
        .{ .c_name = "topology_version", .z_name = "topology_version" },
        .{ .c_name = "num_entities", .z_name = "num_entities" },
        .{ .c_name = "reserved1", .z_name = "reserved1" },
        .{ .c_name = "ptr_entities", .z_name = "ptr_entities" },
        .{ .c_name = "num_interfaces", .z_name = "num_interfaces" },
        .{ .c_name = "reserved2", .z_name = "reserved2" },
        .{ .c_name = "ptr_interfaces", .z_name = "ptr_interfaces" },
        .{ .c_name = "num_pads", .z_name = "num_pads" },
        .{ .c_name = "reserved3", .z_name = "reserved3" },
        .{ .c_name = "ptr_pads", .z_name = "ptr_pads" },
        .{ .c_name = "num_links", .z_name = "num_links" },
        .{ .c_name = "reserved4", .z_name = "reserved4" },
        .{ .c_name = "ptr_links", .z_name = "ptr_links" },
    });
}

test "Media ioctl constants match linux/media.h" {
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_IOC_DEVICE_INFO)), Ioctl.device_info);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_IOC_ENUM_ENTITIES)), Ioctl.enum_entities);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_IOC_ENUM_LINKS)), Ioctl.enum_links);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_IOC_SETUP_LINK)), Ioctl.setup_link);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_IOC_G_TOPOLOGY)), Ioctl.g_topology);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_IOC_REQUEST_ALLOC)), Ioctl.request_alloc);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_REQUEST_IOC_QUEUE)), RequestIoctl.queue);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_REQUEST_IOC_REINIT)), RequestIoctl.reinit);
}

test "Media version helpers match linux/media.h" {
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_API_VERSION)), Version.api);
    try std.testing.expectEqual(Version.v4_19_0, Version.make(4, 19, 0));
    try std.testing.expectEqual(@as(bool, bindings.MEDIA_V2_ENTITY_HAS_FLAGS(Version.v4_19_0)), Version.hasV2EntityFlags(Version.v4_19_0));
    try std.testing.expectEqual(@as(bool, bindings.MEDIA_V2_PAD_HAS_INDEX(Version.v4_19_0)), Version.hasV2PadIndex(Version.v4_19_0));
    try std.testing.expect(!Version.hasV2EntityFlags(Version.make(4, 18, 99)));
    try std.testing.expect(Version.hasV2EntityFlags(Version.make(4, 19, 0)));
    try std.testing.expect(!Version.hasV2PadIndex(Version.make(4, 18, 99)));
    try std.testing.expect(Version.hasV2PadIndex(Version.make(4, 19, 0)));
}

test "Media legacy entity constants match linux/media.h" {
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_F_BASE)), Entity.Range.base);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_F_OLD_BASE)), Entity.Range.old_base);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_F_OLD_SUBDEV_BASE)), Entity.Range.old_subdev_base);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_TYPE_SHIFT)), Entity.Legacy.type_shift);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_TYPE_MASK)), Entity.Legacy.type_mask);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_SUBTYPE_MASK)), Entity.Legacy.subtype_mask);

    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_T_DEVNODE_UNKNOWN)), Entity.Legacy.Type.devnode_unknown);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_T_DEVNODE)), Entity.Legacy.Type.devnode);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_T_DEVNODE_V4L)), Entity.Legacy.Type.devnode_v4l);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_T_DEVNODE_FB)), Entity.Legacy.Type.devnode_fb);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_T_DEVNODE_ALSA)), Entity.Legacy.Type.devnode_alsa);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_T_DEVNODE_DVB)), Entity.Legacy.Type.devnode_dvb);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_T_UNKNOWN)), Entity.Legacy.Type.unknown);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_T_V4L2_VIDEO)), Entity.Legacy.Type.v4l2_video);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_T_V4L2_SUBDEV)), Entity.Legacy.Type.v4l2_subdev);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_T_V4L2_SUBDEV_SENSOR)), Entity.Legacy.Type.v4l2_subdev_sensor);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_T_V4L2_SUBDEV_FLASH)), Entity.Legacy.Type.v4l2_subdev_flash);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_T_V4L2_SUBDEV_LENS)), Entity.Legacy.Type.v4l2_subdev_lens);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_T_V4L2_SUBDEV_DECODER)), Entity.Legacy.Type.v4l2_subdev_decoder);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_T_V4L2_SUBDEV_TUNER)), Entity.Legacy.Type.v4l2_subdev_tuner);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_ENT_F_DTV_DECODER)), @intFromEnum(Entity.Legacy.Function.dtv_decoder));
}

test "Media interface constants match linux/media.h" {
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_DVB_BASE)), Interface.Range.dvb_base);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_V4L_BASE)), Interface.Range.v4l_base);
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_ALSA_BASE)), Interface.Range.alsa_base);

    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_DVB_FE)), @intFromEnum(Interface.Type.dvb_fe));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_DVB_DEMUX)), @intFromEnum(Interface.Type.dvb_demux));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_DVB_DVR)), @intFromEnum(Interface.Type.dvb_dvr));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_DVB_CA)), @intFromEnum(Interface.Type.dvb_ca));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_DVB_NET)), @intFromEnum(Interface.Type.dvb_net));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_V4L_VIDEO)), @intFromEnum(Interface.Type.v4l_video));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_V4L_VBI)), @intFromEnum(Interface.Type.v4l_vbi));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_V4L_RADIO)), @intFromEnum(Interface.Type.v4l_radio));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_V4L_SUBDEV)), @intFromEnum(Interface.Type.v4l_subdev));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_V4L_SWRADIO)), @intFromEnum(Interface.Type.v4l_swradio));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_V4L_TOUCH)), @intFromEnum(Interface.Type.v4l_touch));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_ALSA_PCM_CAPTURE)), @intFromEnum(Interface.Type.alsa_pcm_capture));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_ALSA_PCM_PLAYBACK)), @intFromEnum(Interface.Type.alsa_pcm_playback));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_ALSA_CONTROL)), @intFromEnum(Interface.Type.alsa_control));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_ALSA_COMPRESS)), @intFromEnum(Interface.Type.alsa_compress));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_ALSA_RAWMIDI)), @intFromEnum(Interface.Type.alsa_rawmidi));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_ALSA_HWDEP)), @intFromEnum(Interface.Type.alsa_hwdep));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_ALSA_SEQUENCER)), @intFromEnum(Interface.Type.alsa_sequencer));
    try std.testing.expectEqual(@as(u32, @intCast(bindings.MEDIA_INTF_T_ALSA_TIMER)), @intFromEnum(Interface.Type.alsa_timer));
}
