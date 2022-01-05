weights = File.readlines("/Users/kph/Stuff/aoc2015/day24/input.txt").map(&:strip).map(&:to_i)

def find_group1(weights, groups)
  # target weight for each group is the sum of the weights / 3 since it must be in three equal groups
  target = weights.reduce(0, &:+) / groups

  # start looking for groups starting at the smallest and continue until we get at least one combination that has the target weight
  group1 = []
  size = 1
  while group1.empty?
    size += 1
    group1 = weights.combination(size).map { |c| [c, c.reduce(0, &:+), c.reduce(1, &:*) ] }.filter { |v| v[1] == target }
  end

  group1
end

# Part 1
group1 = find_group1(weights, 3)
puts "Minimum quantum entanglement is #{group1.min_by { |v| v[2] }}" # 11846773891

# Part 2
group1_4= find_group1(weights, 4)
puts "Minimum quantum entanglement is #{group1_4.min_by { |v| v[2] }}" # 80393059
