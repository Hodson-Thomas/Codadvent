const std = @import("std");

const file_path = "data.txt";

const Elf = struct {
    name: []const u8,
    calories: u32,
    pub fn init(name: []const u8, calories: u32) Elf {
        return .{ .name = name, .calories = calories };
    }

    pub fn set_name(self: *Elf, name: []const u8) void {
        self.name = name;
    }

    pub fn add_calories(self: *Elf, calories: u32) void {
        self.calories += calories;
    }

    pub fn print(self: *const Elf) void {
        std.debug.print("Elf {s} with {d} calories\n", .{ self.name, self.calories });
    }

    pub fn free(self: *const Elf, allocator: std.mem.Allocator) void {
        allocator.free(self.name);
    }
};

pub fn is_u32(s: []const u8) bool {
    _ = std.fmt.parseUnsigned(u32, s, 10) catch {
        return false;
    };
    return true;
}

pub fn removeCarriageReturnInPlace(str: []u8) []const u8 {
    var write_idx: usize = 0;
    for (str) |char| {
        if (char != '\r') {
            str[write_idx] = char;
            write_idx += 1;
        }
    }
    return str[0..write_idx];
}

const ParserIterator = struct {
    file: std.fs.File,
    buf_reader: std.io.BufferedReader(4096, std.fs.File.Reader),
    allocator: std.mem.Allocator,
    buffer: [4096]u8,

    pub fn init(file: std.fs.File, allocator: std.mem.Allocator) ParserIterator {
        return .{
            .file = file,
            .buf_reader = std.io.bufferedReader(file.reader()),
            .buffer = undefined,
            .allocator = allocator,
        };
    }

    fn next(self: *ParserIterator) ?Elf {
        var elf = Elf.init("", 0);
        var has_name = false;
        const reader = self.buf_reader.reader();

        while (true) {
            const line = reader.readUntilDelimiterOrEof(&self.buffer, '\n') catch {
                return elf;
            };

            if (line) |ln| {
                const l = removeCarriageReturnInPlace(ln);
                if (l.len == 0) {
                    return elf;
                }

                if (l.len == 0) {
                    if (has_name) {
                        self.allocator.free(elf.name);
                    }
                    return null;
                }

                if (is_u32(l)) {
                    elf.calories += std.fmt.parseUnsigned(u32, l, 10) catch {
                        if (has_name) {
                            self.allocator.free(elf.name);
                        }
                        return null;
                    };
                } else {
                    elf.name = self.allocator.dupe(u8, l) catch {
                        return null;
                    };
                    has_name = true;
                }
            } else {
                if (has_name) {
                    self.allocator.free(elf.name);
                }
                return null;
            }
        }

        return null;
    }

    pub fn deinit(self: *ParserIterator) void {
        self.file.close();
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const file = try std.fs.cwd().openFile(file_path, .{});

    var iterator = ParserIterator.init(file, allocator);
    defer iterator.deinit();

    const Context = struct {
        pub fn compare(_: @This(), a: Elf, b: Elf) std.math.Order {
            return std.math.order(a.calories, b.calories);
        }
    };

    var heap = std.PriorityQueue(Elf, Context, Context.compare).init(allocator, .{});
    defer {
        while (heap.removeOrNull()) |elf| {
            allocator.free(elf.name);
        }
        heap.deinit();
    }

    while (iterator.next()) |elf| {
        if (heap.count() < 3) {
            try heap.add(elf);
        } else if (elf.calories > heap.peek().?.calories) {
            const removed = heap.removeOrNull().?;
            allocator.free(removed.name);
            try heap.add(elf);
        } else {
            allocator.free(elf.name);
        }
    }

    std.debug.print("\nOur best elves are ...:\n", .{});
    var temp_elves = std.ArrayList(Elf).init(allocator);
    defer temp_elves.deinit();

    while (heap.removeOrNull()) |elf| {
        try temp_elves.append(elf);
    }

    var i = temp_elves.items.len;
    while (i > 0) {
        i -= 1;
        const elf = temp_elves.items[i];
        elf.print();
        elf.free(allocator);
    }

    std.debug.print("\n", .{});
}
