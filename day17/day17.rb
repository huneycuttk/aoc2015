containers = File.readlines("/Users/kph/stuff/aoc2015/day17/input.txt").map(&:strip).map(&:to_i)

total = (1...containers.length).map do |count|
  containers.combination(count).map { |l| l.reduce(&:+) }
end.flatten.filter { |x| x == 150 }.length

puts "Total combinations is #{total}" #  4372

min_containers = (1...containers.length).find do |count|
  !containers.combination(count).map { |l| l.reduce(&:+) }.filter { |x| x == 150 }.empty?
end

puts "Min containers is #{min_containers}" # 4
total_with_min = containers.combination(min_containers).map { |l| l.reduce(&:+) }.filter { |x| x == 150 }.length
puts "Total with min is #{total_with_min}" # 4
