require 'set'

def parse(data)
  participants = Set.new
  quotients = {}
  data.map { |l| l.split(' ') }.each do |line|
    first = line.first
    last = line.last[0..-2]

    participants << first
    participants << last

    happiness = line[3].to_i
    happiness *= -1 if line[2] == "lose"
    quotients[[first,last]] = happiness
  end

  return [ participants.to_a, quotients ]
end

def evaluate_happiness(seating, quotients)
  all_pairs = seating.each_cons(2) + seating.reverse.each_cons(2) +
    [ [ seating.first, seating.last ], [ seating.last, seating.first ] ]
  all_pairs.map { |p| quotients[p] || 0 }.reduce(0, &:+)
end

def optimal_happiness(participants, quotients)
  participants.permutation(participants.length).map { |s| evaluate_happiness(s, quotients) }.max
end

test_participants, test_quotients = parse(File.readlines("/Users/kph/Stuff/aoc2015/day13/test-input.txt"))
participants, quotients = parse(File.readlines("/Users/kph/Stuff/aoc2015/day13/input.txt"))

test_result = optimal_happiness(test_participants, test_quotients)
puts "Test optimal happiness is #{test_result}" # 330

result = optimal_happiness(participants, quotients)
puts "Optimal happiness is #{result}" # 709

participants << "Me"
result = optimal_happiness(participants, quotients)
puts "Optimal happiness with me is #{result}" # 668
