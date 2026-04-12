const std = @import("std");
const z4l2 = @import("z4l2");

pub fn main(init: std.process.Init) !void {
    _ = init;
    std.debug.print("{d}", .{@intFromEnum(z4l2.format.Pixel.rgb332)});
}
