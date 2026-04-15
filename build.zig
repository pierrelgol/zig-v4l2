const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const header_path = b.option([]const u8, "header-path", "path to v4l2 headers");

    var final: []const u8 = undefined;
    defer b.allocator.free(final);

    if (header_path) |some| {
        final = std.mem.concat(b.allocator, u8, &.{
            "/usr/include/",
            some,
        }) catch unreachable;
    } else {
        const triple = target.result.linuxTriple(b.allocator) catch unreachable;
        defer b.allocator.free(triple);
        final = std.mem.concat(b.allocator, u8, &.{
            "/usr/include/",
            triple,
        }) catch unreachable;
    }

    const translate_c = b.addTranslateC(.{
        .root_source_file = b.path("src/v4l2/bindings.c"),
        .optimize = optimize,
        .target = target,
        .link_libc = false,
    });
    translate_c.addIncludePath(.{ .cwd_relative = "/usr/include" });
    translate_c.addIncludePath(.{ .cwd_relative = final });

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

    const exe = b.addExecutable(.{
        .name = "demo",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/demo.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "z4l2", .module = module },
            },
        }),
    });
    b.installArtifact(exe);

    const exe_run = b.addRunArtifact(exe);
    exe_run.step.dependOn(b.getInstallStep());

    if (b.args) |arguments| {
        exe_run.addArgs(arguments);
    }

    const run_step = b.step("run", "Run the demo");
    run_step.dependOn(&exe_run.step);

    const exe_test = b.addTest(.{
        .root_module = exe.root_module,
        .name = "demo",
    });

    const library_test = b.addTest(.{
        .root_module = module,
        .name = "z4l2",
    });

    const library_test_run = b.addRunArtifact(library_test);
    const exe_test_run = b.addRunArtifact(exe_test);

    const test_step = b.step("test", "Test the code");
    test_step.dependOn(&library_test_run.step);
    test_step.dependOn(&exe_test_run.step);

    const library_check = b.addLibrary(.{
        .name = "z4l2",
        .root_module = module,
    });

    const exe_check = b.addLibrary(.{
        .name = "z4l2",
        .root_module = module,
    });

    const check_step = b.step("check", "Check the code");
    check_step.dependOn(&library_check.step);
    check_step.dependOn(&exe_check.step);
}
