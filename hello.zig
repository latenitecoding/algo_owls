const std = @import("std");
const stdin = std.io.getStdIn().reader();
const stdout = std.io.getStdOut().writer();

// ========================================================
// Solution
// ========================================================

pub fn main() !void {
    try print("Hello, World!\n", .{});
}

// ========================================================
// Helpers
// ========================================================

inline fn next(buffer: []u8) ![]u8 {
    return (try stdin.readUntilDelimiterOrEof(buffer, ' ')).?;
}

inline fn nextArray(comptime T: type, buffer: []u8, arr: []T, n: usize) !usize {
    for (0..(n - 1)) |i| {
        arr[i] = try std.fmt.parseInt(T, try next(buffer), 10);
    }
    arr[n - 1] = try std.fmt.parseInt(T, try nextLine(buffer), 10);
    return n;
}

inline fn nextFloat(comptime T: type, buffer: []u8) !T {
    return try std.fmt.parseFloat(T, try nextLine(buffer));
}

inline fn nextInt(comptime T: type, buffer: []u8) !T {
    return try std.fmt.parseInt(T, try nextLine(buffer), 10);
}

inline fn nextLine(buffer: []u8) ![]u8 {
    return (try stdin.readUntilDelimiterOrEof(buffer, '\n')).?;
}

inline fn nextTuple(comptime T: type, buffer: []u8) !struct { T, T } {
    return .{
        try std.fmt.parseInt(T, try next(buffer), 10),
        try std.fmt.parseInt(T, try nextLine(buffer), 10),
    };
}

inline fn print(comptime format: []const u8, args: anytype) !void {
    try stdout.print(format, args);
}
