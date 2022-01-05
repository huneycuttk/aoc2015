class Grid
  attr_reader :values
  def initialize(values)
    @values = values
  end

  def animate
    Grid.new(values.each.with_index.map do |row, rowidx|
      row.each.with_index.map do |value, colidx|
        on_neighbors = neighbors(rowidx, colidx).filter { |(x,y)| self[x, y] }.length
        value ? (on_neighbors == 2 || on_neighbors == 3) : (on_neighbors == 3)
      end
    end)
  end

  def [](x, y)
    values[x][y]
  end

  def to_s
    values.map do |row|
      row.map do |value|
        value ? "#" : "."
      end.join
    end.join("\n")
  end

  def count
    values.reduce(0) { |s, r| s + r.reduce(0) { |rs, v| rs + (v ? 1 : 0) } }
  end

  def force_corners
    Grid.new(values.map { |v| v.dup }).tap do |g|
      g.values[0][0] = true
      g.values[0][x_count-1] = true
      g.values[y_count-1][0] = true
      g.values[y_count-1][x_count-1] = true
    end
  end

  private
  def x_count
    values.length
  end

  def y_count
    values.first.length
  end

  def neighbors(x, y)
    [
      [ x-1, y-1 ], [ x, y-1 ], [ x+1, y-1 ],
      [ x-1, y   ],             [ x+1, y   ],
      [ x-1, y+1 ], [ x, y+1 ], [ x+1, y+1 ]
    ].filter { |(x1,y1)| x1 >= 0 && x1 < x_count && y1 >= 0 && y1 < y_count }
  end
end


def parse(data)
  Grid.new(data.map do |line|
    line.strip.split('').map { |c| c == "#" }
  end)
end

test_grid = parse(File.readlines("/Users/kph/Stuff/aoc2015/day18/test-input.txt"))
puts test_grid
puts ""
4.times.reduce(test_grid) { |g, _| g.animate.tap { |ng| puts ng ; puts ""} }

grid = parse(File.readlines("/Users/kph/Stuff/aoc2015/day18/input.txt"))
final = 100.times.reduce(grid) { |g, _| g.animate }
puts final
puts "Final on count is #{final.count}" # 1061

test_grid2 = test_grid.force_corners
puts test_grid2
puts ""
5.times.reduce(test_grid2) { |g, _| g.animate.force_corners.tap { |ng| puts ng ; puts ""} }

grid2 = grid.force_corners
final2 = 100.times.reduce(grid2) { |g, _| g.animate.force_corners }
puts final2
puts "Final on count with corners on is #{final2.count}" # 1006
