const std = @import("std");
const rl = @import("raylib");

const model_path = "assets/Untitled.obj";

pub fn main(_: std.process.Init) !void {
    rl.initWindow(800, 600, "OBJ Wireframe - raylib");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    const model = try rl.loadModel(model_path);
    defer rl.unloadModel(model);

    var camera = rl.Camera3D{
        .position = .{ .x = 4.0, .y = 2.5, .z = 4.0 },
        .target = .{ .x = 0.0, .y = 0.0, .z = 0.0 },
        .up = .{ .x = 0.0, .y = 1.0, .z = 0.0 },
        .fovy = 45.0,
        .projection = .perspective,
    };

    while (!rl.windowShouldClose()) {
        rl.updateCamera(&camera, .orbital);

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.black);

        rl.beginMode3D(camera);
        rl.drawModelWires(
            model,
            .{ .x = 0.0, .y = 0.0, .z = 0.0 },
            2.0,
            rl.Color.green,
        );
        rl.endMode3D();

        rl.drawText("Wireframe: assets/Untitled.obj", 20, 20, 20, rl.Color.light_gray);
    }
}
