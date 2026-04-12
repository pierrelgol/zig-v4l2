const Audio = @import("Audio.zig").Audio;
const Buffer = @import("Buffer.zig").Buffer;
const Capability = @import("Capability.zig").Capability;
const Control = @import("Control.zig").Control;
const Debug = @import("debug.zig");
const Decoder = @import("Decoder.zig").Decoder;
const Encoder = @import("Encoder.zig").Encoder;
const Event = @import("Event.zig");
const Frame = @import("Frame.zig").Frame;
const Input = @import("Input.zig").Input;
const Output = @import("Output.zig").Output;
const Standard = @import("Standard.zig").Standard;
const StdId = Standard.Id;
const Stream = @import("stream.zig");
const Timings = @import("timings.zig");
const tuner = @import("tuner.zig");
const Vbi = @import("vbi.zig");

pub const base_vidioc_private: u32 = 192;

fn ioc(dir: u32, ioc_type: u8, nr: u8, size: u32) u32 {
    return (dir << 30) | (size << 16) | (@as(u32, ioc_type) << 8) | @as(u32, nr);
}

pub fn io(ioc_type: u8, nr: u8) u32 {
    return ioc(0, ioc_type, nr, 0);
}

pub fn ior(ioc_type: u8, nr: u8, comptime T: type) u32 {
    return ioc(2, ioc_type, nr, @sizeOf(T));
}

pub fn iow(ioc_type: u8, nr: u8, comptime T: type) u32 {
    return ioc(1, ioc_type, nr, @sizeOf(T));
}

pub fn iowr(ioc_type: u8, nr: u8, comptime T: type) u32 {
    return ioc(3, ioc_type, nr, @sizeOf(T));
}

pub const Ioctl = struct {
    pub const querycap: u32 = ior('V', 0, Capability);
    pub const enum_fmt: u32 = iowr('V', 2, Capability.Description);
    pub const g_fmt: u32 = iowr('V', 4, Stream.Format);
    pub const s_fmt: u32 = iowr('V', 5, Stream.Format);
    pub const reqbufs: u32 = iowr('V', 8, Buffer.Request);
    pub const querybuf: u32 = iowr('V', 9, Buffer);
    pub const g_fbuf: u32 = ior('V', 10, Frame.Buffer);
    pub const s_fbuf: u32 = iow('V', 11, Frame.Buffer);
    pub const overlay: u32 = iow('V', 14, i32);
    pub const qbuf: u32 = iowr('V', 15, Buffer);
    pub const expbuf: u32 = iowr('V', 16, Buffer.Export);
    pub const dqbuf: u32 = iowr('V', 17, Buffer);
    pub const streamon: u32 = iow('V', 18, i32);
    pub const streamoff: u32 = iow('V', 19, i32);
    pub const g_parm: u32 = iowr('V', 21, Stream.Parameter);
    pub const s_parm: u32 = iowr('V', 22, Stream.Parameter);
    pub const g_std: u32 = ior('V', 23, StdId);
    pub const s_std: u32 = iow('V', 24, StdId);
    pub const enumstd: u32 = iowr('V', 25, Standard);
    pub const enuminput: u32 = iowr('V', 26, Input);
    pub const g_ctrl: u32 = iowr('V', 27, Control);
    pub const s_ctrl: u32 = iowr('V', 28, Control);
    pub const g_tuner: u32 = iowr('V', 29, tuner.Tuner);
    pub const s_tuner: u32 = iow('V', 30, tuner.Tuner);
    pub const g_audio: u32 = ior('V', 33, Audio);
    pub const s_audio: u32 = iow('V', 34, Audio);
    pub const queryctrl: u32 = iowr('V', 36, Control.Query);
    pub const querymenu: u32 = iowr('V', 37, Control.MenuQuery);
    pub const g_input: u32 = ior('V', 38, i32);
    pub const s_input: u32 = iowr('V', 39, i32);
    pub const g_edid: u32 = iowr('V', 40, Stream.Edid);
    pub const s_edid: u32 = iowr('V', 41, Stream.Edid);
    pub const g_output: u32 = ior('V', 46, i32);
    pub const s_output: u32 = iowr('V', 47, i32);
    pub const enumoutput: u32 = iowr('V', 48, Output);
    pub const g_audout: u32 = ior('V', 49, Audio.Output);
    pub const s_audout: u32 = iow('V', 50, Audio.Output);
    pub const g_modulator: u32 = iowr('V', 54, tuner.Modulator);
    pub const s_modulator: u32 = iow('V', 55, tuner.Modulator);
    pub const g_frequency: u32 = iowr('V', 56, tuner.Frequency);
    pub const s_frequency: u32 = iow('V', 57, tuner.Frequency);
    pub const cropcap: u32 = iowr('V', 58, Stream.Crop.Capabilities);
    pub const g_crop: u32 = iowr('V', 59, Stream.Crop);
    pub const s_crop: u32 = iow('V', 60, Stream.Crop);
    pub const querystd: u32 = ior('V', 63, StdId);
    pub const try_fmt: u32 = iowr('V', 64, Stream.Format);
    pub const enumaudio: u32 = iowr('V', 65, Audio);
    pub const enumaudout: u32 = iowr('V', 66, Audio.Output);
    pub const g_priority: u32 = ior('V', 67, u32);
    pub const s_priority: u32 = iow('V', 68, u32);
    pub const g_sliced_vbi_cap: u32 = iowr('V', 69, Vbi.SlicedCapabilities);
    pub const log_status: u32 = io('V', 70);
    pub const g_ext_ctrls: u32 = iowr('V', 71, Control.ExtSet);
    pub const s_ext_ctrls: u32 = iowr('V', 72, Control.ExtSet);
    pub const try_ext_ctrls: u32 = iowr('V', 73, Control.ExtSet);
    pub const enum_framesizes: u32 = iowr('V', 74, Frame.Size);
    pub const enum_frameintervals: u32 = iowr('V', 75, Frame.Interval);
    pub const g_enc_index: u32 = ior('V', 76, Encoder.Index);
    pub const encoder_cmd: u32 = iowr('V', 77, Encoder);
    pub const try_encoder_cmd: u32 = iowr('V', 78, Encoder);
    pub const dbg_s_register: u32 = iow('V', 79, Debug.Register);
    pub const dbg_g_register: u32 = iowr('V', 80, Debug.Register);
    pub const s_hw_freq_seek: u32 = iow('V', 82, tuner.HardwareFrequencySeek);
    pub const s_dv_timings: u32 = iowr('V', 87, Timings.DigitalVideo);
    pub const g_dv_timings: u32 = iowr('V', 88, Timings.DigitalVideo);
    pub const dqevent: u32 = ior('V', 89, Event);
    pub const subscribe_event: u32 = iow('V', 90, Event.Subscription);
    pub const unsubscribe_event: u32 = iow('V', 91, Event.Subscription);
    pub const create_bufs: u32 = iowr('V', 92, Buffer.Create);
    pub const prepare_buf: u32 = iowr('V', 93, Buffer);
    pub const g_selection: u32 = iowr('V', 94, Stream.Selection);
    pub const s_selection: u32 = iowr('V', 95, Stream.Selection);
    pub const decoder_cmd: u32 = iowr('V', 96, Decoder);
    pub const try_decoder_cmd: u32 = iowr('V', 97, Decoder);
    pub const enum_dv_timings: u32 = iowr('V', 98, Timings.Enumeration);
    pub const query_dv_timings: u32 = ior('V', 99, Timings.DigitalVideo);
    pub const dv_timings_cap: u32 = iowr('V', 100, Timings.DigitalVideoCapabilities);
    pub const enum_freq_bands: u32 = iowr('V', 101, tuner.Band);
    pub const dbg_g_chip_info: u32 = iowr('V', 102, Debug.ChipInfo);
    pub const query_ext_ctrl: u32 = iowr('V', 103, Control.ExtendedQuery);
    pub const remove_bufs: u32 = iowr('V', 104, Buffer.Remove);
};
