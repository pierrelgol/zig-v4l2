const std = @import("std");
pub const bindings = @import("v4l2/bindings.zig");

comptime {
    std.testing.refAllDecls(bindings);
}
