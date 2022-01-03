directions = File.readlines("/Users/kph/Stuff/aoc2015/day3/input.txt").first.split('')

# part 1
houses = directions.reduce([[0,0]]) do |houses, direction|
  (x,y) = houses.last
  newhouse = case direction
  when "^"
    [x, y+1]
  when ">"
    [x+1, y]
  when "<"
    [x-1, y]
  when "v"
    [x, y-1]
  end
  houses + [ newhouse ]
end
at_least_one = houses.tally.keys.count

# 2592
puts "At least one present #{at_least_one}"

# part 2
houses_with_robo = directions.reduce([[0,0],[0,0]]) do |houses, direction|
  (x,y) = houses[-2]
  newhouse = case direction
  when "^"
    [x, y+1]
  when ">"
    [x+1, y]
  when "<"
    [x-1, y]
  when "v"
    [x, y-1]
  end
  houses + [ newhouse ]
end
at_least_one_with_robo = houses_with_robo.tally.keys.count

# 2360
puts "At least one present with robo #{at_least_one_with_robo}"
