const std = @import("std");

const geometry = @import("v4l2/geometry.zig");
pub const Rectangle = geometry.Rectangle;
pub const Fraction = geometry.Fraction;
pub const Area = geometry.Area;

pub const Pixel = @import("v4l2/Pixel.zig").Pixel;
pub const fourcc = Pixel.fourcc;
pub const fourcc_be = Pixel.fourcc_be;
pub const private_magic = Pixel.private_magic;
pub const Sdr = Pixel.Sdr;
pub const Touch = Pixel.Touch;
pub const Meta = Pixel.Meta;
pub const C3isp = Pixel.C3isp;
pub const Rkisp = Pixel.Rkisp;
pub const RaspberryPi = Pixel.RaspberryPi;

pub const Buffer = @import("v4l2/Buffer.zig").Buffer;
pub const CreateBuffer = Buffer.Create;
pub const RequestBuffer = Buffer.Request;
pub const RemoveBuffer = Buffer.Remove;
pub const Priority = Buffer.Priority;
pub const Timecode = Buffer.Timecode;

pub const Capability = @import("v4l2/Capability.zig").Capability;

pub const Frame = @import("v4l2/Frame.zig").Frame;
pub const Clip = Frame.Clip;
pub const Window = Frame.Window;

pub const Stream = @import("v4l2/stream.zig");

pub const Standard = @import("v4l2/Standard.zig").Standard;
pub const StandardId = Standard.Id;
pub const StandardSet = Standard.Set;

pub const Timings = @import("v4l2/timings.zig");

pub const Input = @import("v4l2/Input.zig").Input;
pub const Output = @import("v4l2/Output.zig").Output;
pub const Control = @import("v4l2/Control.zig").Control;

const tuner = @import("v4l2/tuner.zig");
pub const Tuner = tuner.Tuner;
pub const TunerKind = tuner.Type;
pub const Modulator = tuner.Modulator;
pub const Frequency = tuner.Frequency;
pub const FrequencyBand = tuner.Band;
pub const HardwareFrequencySeek = tuner.HardwareFrequencySeek;

pub const Audio = @import("v4l2/Audio.zig").Audio;
pub const Encoder = @import("v4l2/Encoder.zig").Encoder;
pub const Decoder = @import("v4l2/Decoder.zig").Decoder;
pub const Vbi = @import("v4l2/vbi.zig");
pub const Event = @import("v4l2/Event.zig");

pub const Debug = @import("v4l2/debug.zig");

const ioctl = @import("v4l2/ioctl.zig");
pub const base_vidioc_private = ioctl.base_vidioc_private;
pub const io = ioctl.io;
pub const ior = ioctl.ior;
pub const iow = ioctl.iow;
pub const iowr = ioctl.iowr;
pub const Ioctl = ioctl.Ioctl;

comptime {
    std.testing.refAllDecls(@This());
}
