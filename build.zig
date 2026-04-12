const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const module = b.addModule("z4l2", .{
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("src/root.zig"),
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
