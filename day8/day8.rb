strings = File.readlines("/Users/kph/Stuff/aoc2015/day8/input.txt").map(&:strip)

code = strings.map(&:length).reduce(0, &:+)
memory = strings.map { |s| eval(s) }.map(&:length).reduce(0, &:+)

puts "Difference is #{code-memory}" # 1333

escaped = strings.map(&:inspect).map(&:length).reduce(0, &:+)
puts "Difference is #{escaped-code}" # 2046
