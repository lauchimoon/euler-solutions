const std = @import("std");
const stdout = std.io.getStdOut().writer();
const data = @embedFile("./0067_triangle.txt");
const common = @import("common");

fn solve(triangle: [][]u16) u64 {
    var y: u64 = triangle.len - 2;
    while (y > 0) : (y -= 1) {
        for (0..y + 1) |x| {
            triangle[y][x] = @max(triangle[y][x] + triangle[y + 1][x], triangle[y][x] + triangle[y + 1][x + 1]);
        }
    }

    triangle[0][0] = @max(triangle[0][0] + triangle[1][0], triangle[0][0] + triangle[1][1]);
    return triangle[0][0];
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    defer _ = gpa.deinit();

    var triangle = try common.load_triangle(&allocator, data);
    try stdout.print("{}\n", .{solve(triangle)});
    common.unload_triangle(triangle, &allocator);
}