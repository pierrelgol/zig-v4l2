const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const header_path = b.option(
        []const u8,
        "header-path",
        "Path to target-specific v4l2 headers, relative to /usr/include (default: linux triple)",
    );

    const include_path = if (header_path) |some|
        std.mem.concat(b.allocator, u8, &.{ "/usr/include/", some }) catch @panic("OOM")
    else blk: {
        const triple = target.result.linuxTriple(b.allocator) catch @panic("OOM");
        break :blk std.mem.concat(b.allocator, u8, &.{ "/usr/include/", triple }) catch @panic("OOM");
    };

    const translate_c = b.addTranslateC(.{
        .root_source_file = b.path("src/v4l2/bindings.c"),
        .optimize = optimize,
        .target = target,
        .link_libc = false,
    });
    translate_c.addIncludePath(.{ .cwd_relative = "/usr/include" });
    translate_c.addIncludePath(.{ .cwd_relative = include_path });

    const module = b.addModule("z4l2", .{
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("src/root.zig"),
        .imports = &.{
            .{ .name = "bindings", .module = translate_c.createModule() },
        },
    });

    const library = b.addLibrary(.{
        .name = "z4l2",
        .root_module = module,
    });
    b.installArtifact(library);

    // --- demo ---

    const demo_mod = b.createModule(.{
        .root_source_file = b.path("src/demo.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "z4l2", .module = module },
        },
    });

    const demo = b.addExecutable(.{
        .name = "demo",
        .root_module = demo_mod,
    });
    b.installArtifact(demo);

    const run_step = b.step("run", "Run the demo (pass a device path as argument, default: /dev/video0)");
    const demo_run = b.addRunArtifact(demo);
    demo_run.step.dependOn(b.getInstallStep());
    if (b.args) |args| demo_run.addArgs(args);
    run_step.dependOn(&demo_run.step);

    // --- tests ---

    const test_step = b.step("test", "Run all tests");

    const lib_test = b.addTest(.{ .root_module = module, .name = "z4l2" });
    test_step.dependOn(&b.addRunArtifact(lib_test).step);

    const demo_test = b.addTest(.{ .root_module = demo_mod, .name = "demo" });
    test_step.dependOn(&b.addRunArtifact(demo_test).step);

    // --- check (used by ZLS) ---

    const check_step = b.step("check", "Check compilation without linking");
    const check_lib = b.addLibrary(.{ .name = "z4l2", .root_module = module });
    check_step.dependOn(&check_lib.step);
}
