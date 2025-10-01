const std = @import("std");

const stdin = std.fs.File.stdin();
const stdout = std.fs.File.stdout();

pub fn main() !void {
    var in: [4096]u8 = undefined;
    var out: [4096]u8 = undefined;

    const N = try lastInt(usize, &in);

    try print("{d}\n", &out, .{N});
}

//==================================================================
// HELPERS
//==================================================================

fn lastFloat(comptime T: type, buff: []u8) !T {
    const input = try nextLine(buff);
    return try std.fmt.parseFloat(T, input, 10);
}

fn lastInt(comptime T: type, buff: []u8) !T {
    const input = try nextLine(buff);
    return try std.fmt.parseInt(T, input, 10);
}

fn next(buff: []u8) ![]u8 {
    var r = stdin.readerStreaming(buff);
    return try r.interface.takeDelimiterExclusive(' ');
}

fn nextFloat(comptime T: type, buff: []u8) !T {
    const input = try next(buff);
    return try std.fmt.parseFloat(T, input, 10);
}

fn nextInt(comptime T: type, buff: []u8) !T {
    const input = try next(buff);
    return try std.fmt.parseInt(T, input, 10);
}

fn nextLine(buff: []u8) ![]u8 {
    var r = stdin.readerStreaming(buff);
    return try r.interface.takeDelimiterExclusive('\n');
}

fn nextList(comptime T: type, buff: []u8, arr: []T, n: usize) ![]T {
    var r = stdin.readerStreaming(buff);
    for (0..(n - 1)) |i| {
        const input = try r.interface.takeDelimiterExclusive(' ');
        arr[i] = try std.fmt.parseInt(T, input, 10);
    }
    const input = try r.interface.takeDelimiterExclusive('\n');
    arr[n - 1] = try std.fmt.parseInt(T, input, 10);
    return arr;
}

fn Tuple(comptime T: type) type {
    return struct { T, T };
}

fn nextTuple(comptime T: type, buff: []u8) !Tuple(T) {
    var r = stdin.readerStreaming(buff);
    const left = try r.interface.takeDelimiterExclusive(' ');
    const right = try r.interface.takeDelimiterExclusive('\n');
    return .{
        try std.fmt.parseInt(T, left, 10),
        try std.fmt.parseInt(T, right, 10),
    };
}

fn print(comptime fmt: []const u8, buff: []u8, args: anytype) !void {
    var w = stdout.writerStreaming(buff);
    try w.interface.print(fmt, args);
    try w.interface.flush();
}
