const std = @import("std");
const stdout = std.io.getStdOut().writer();
const common = @import("common");

fn up(numbers: [20][20]u32, prods: *std.ArrayList(u32)) !void {
    for (0..19) |y| {
        for (0..19) |x| {
            if (y + 3 > 19) {
                break;
            }
            const prod = numbers[y + 3][x]*numbers[y + 2][x]*numbers[y + 1][x]*numbers[y][x];
            try prods.append(prod);
        }
    }
}

fn right(numbers: [20][20]u32, prods: *std.ArrayList(u32)) !void {
    for (0..19) |y| {
        for (0..19) |x| {
            if (x + 3 > 19) {
                break;
            }
            const prod = numbers[y][x]*numbers[y][x + 1]*numbers[y][x + 2]*numbers[y][x + 3];
            try prods.append(prod);
        }
    }
}

fn dUpRight(numbers: [20][20]u32, prods: *std.ArrayList(u32)) !void {
    for (3..19) |y| {
        for (0..16) |x| {
            const prod = numbers[y][x]*numbers[y - 1][x + 1]*numbers[y - 2][x + 2]*numbers[y - 3][x + 3];
            try prods.append(prod);
        }
    }
}

fn dUpLeft(numbers: [20][20]u32, prods: *std.ArrayList(u32)) !void {
    for (3..19) |y| {
        for (3..19) |x| {
            const prod = numbers[y][x]*numbers[y - 1][x - 1]*numbers[y - 2][x - 2]*numbers[y - 3][x - 3];
            try prods.append(prod);
        }
    }
}

fn dDownLeft(numbers: [20][20]u32, prods: *std.ArrayList(u32)) !void {
    for (0..16) |y| {
        for (3..19) |x| {
            const prod = numbers[y][x]*numbers[y + 1][x - 1]*numbers[y + 2][x - 2]*numbers[y + 3][x - 3];
            try prods.append(prod);
        }
    }
}

fn dDownRight(numbers: [20][20]u32, prods: *std.ArrayList(u32)) !void {
    for (0..16) |y| {
        for (0..16) |x| {
            const prod = numbers[y][x]*numbers[y + 1][x + 1]*numbers[y + 2][x + 2]*numbers[y + 3][x + 3];
            try prods.append(prod);
        }
    }
}

fn solve() !u32 {
    var numbers = [20][20]u32{
        [_]u32{ 8, 2, 22, 97, 38, 15, 0, 40, 0, 75, 4, 5, 7, 78, 52, 12, 50, 77, 91, 8, },
        [_]u32{ 49, 49, 99, 40, 17, 81, 18, 57, 60, 87, 17, 40, 98, 43, 69, 48, 4, 56, 62, 0, },
        [_]u32{ 81, 49, 31, 73, 55, 79, 14, 29, 93, 71, 40, 67, 53, 88, 30, 3, 49, 13, 36, 65, },
        [_]u32{ 52, 70, 95, 23, 4, 60, 11, 42, 69, 24, 68, 56, 1, 32, 56, 71, 37, 2, 36, 91, },
        [_]u32{ 22, 31, 16, 71, 51, 67, 63, 89, 41, 92, 36, 54, 22, 40, 40, 28, 66, 33, 13, 80, },
        [_]u32{ 24, 47, 32, 60, 99, 3, 45, 2, 44, 75, 33, 53, 78, 36, 84, 20, 35, 17, 12, 50, },
        [_]u32{ 32, 98, 81, 28, 64, 23, 67, 10, 26, 38, 40, 67, 59, 54, 70, 66, 18, 38, 64, 70, },
        [_]u32{ 67, 26, 20, 68, 2, 62, 12, 20, 95, 63, 94, 39, 63, 8, 40, 91, 66, 49, 94, 21, },
        [_]u32{ 24, 55, 58, 5, 66, 73, 99, 26, 97, 17, 78, 78, 96, 83, 14, 88, 34, 89, 63, 72, },
        [_]u32{ 21, 36, 23, 9, 75, 0, 76, 44, 20, 45, 35, 14, 0, 61, 33, 97, 34, 31, 33, 95, },
        [_]u32{ 78, 17, 53, 28, 22, 75, 31, 67, 15, 94, 3, 80, 4, 62, 16, 14, 9, 53, 56, 92, },
        [_]u32{ 16, 39, 5, 42, 96, 35, 31, 47, 55, 58, 88, 24, 0, 17, 54, 24, 36, 29, 85, 57, },
        [_]u32{ 86, 56, 0, 48, 35, 71, 89, 7, 5, 44, 44, 37, 44, 60, 21, 58, 51, 54, 17, 58, },
        [_]u32{ 19, 80, 81, 68, 5, 94, 47, 69, 28, 73, 92, 13, 86, 52, 17, 77, 4, 89, 55, 40, },
        [_]u32{ 4, 52, 8, 83, 97, 35, 99, 16, 7, 97, 57, 32, 16, 26, 26, 79, 33, 27, 98, 66, },
        [_]u32{ 88, 36, 68, 87, 57, 62, 20, 72, 3, 46, 33, 67, 46, 55, 12, 32, 63, 93, 53, 69, },
        [_]u32{ 4, 42, 16, 73, 38, 25, 39, 11, 24, 94, 72, 18, 8, 46, 29, 32, 40, 62, 76, 36, },
        [_]u32{ 20, 69, 36, 41, 72, 30, 23, 88, 34, 62, 99, 69, 82, 67, 59, 85, 74, 4, 36, 16, },
        [_]u32{ 20, 73, 35, 29, 78, 31, 90, 1, 74, 31, 49, 71, 48, 86, 81, 16, 23, 57, 5, 54, },
        [_]u32{ 1, 70, 54, 71, 83, 51, 54, 69, 16, 92, 33, 48, 61, 43, 52, 1, 89, 19, 67, 48, },
    };
    const allocator = std.heap.page_allocator;
    var prods = std.ArrayList(u32).init(allocator);
    defer prods.deinit();

    // Get products for each direction.
    // up = down, right = left so run them once because products
    // will be the same.
    try up(numbers, &prods);
    try right(numbers, &prods);
    try dUpRight(numbers, &prods);
    try dUpLeft(numbers, &prods);
    try dDownLeft(numbers, &prods);
    try dDownRight(numbers, &prods);

    return common.maxList(u32, prods);
}

pub fn main() !void {
    const solution = try solve();
    try stdout.print("{}\n", .{solution});
}
