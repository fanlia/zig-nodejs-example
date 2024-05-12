const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const lib = b.addSharedLibrary(.{
        .name = "addon",
        .root_source_file = .{ .path = "src/lib.zig" },
        .target = target,
        .optimize = .ReleaseSmall,
    });

    lib.addIncludePath(.{
        .path = "node_modules/node-api-headers/include/",
    });
    lib.linkLibC();
    const wf = b.addWriteFiles();
    wf.addCopyFileToSource(lib.getEmittedBin(), "zig-out/lib/lib.node");
    wf.step.dependOn(&lib.step);
    b.getInstallStep().dependOn(&wf.step);
}
