class Reindeer
  class << self
    def parse(line)
      parts = line.split(' ')
      Reindeer.new(parts[0], parts[3].to_i, parts[6].to_i, parts[13].to_i)
    end
  end

  attr_accessor :name, :speed, :duration, :rest_period
  def initialize(name, speed, duration, rest_period)
    self.name = name
    self.speed = speed
    self.duration = duration
    self.rest_period = rest_period
  end

  def position_after(seconds)
    remaining = seconds
    distance = 0
    while remaining > 0
      if remaining <= duration
        distance += remaining*speed
        remaining = 0
      else
        distance += duration*speed
        remaining -= duration
        remaining -= rest_period
      end
    end
    distance
  end
end

def new_scoring(reindeer, time)
  scores = Hash[reindeer.map { |r| [r, 0] }]

  counter = 0
  while counter < time
    counter += 1
    winner = reindeer.map { |r| [r, r.position_after(counter) ] }.max_by(&:last).first
    scores[winner] += 1
  end

  scores
end

def parse(data)
  data.map { |l| Reindeer.parse(l) }
end

test_reindeer = parse(File.readlines("/Users/kph/stuff/aoc2015/day14/test-input.txt"))
positions = test_reindeer.map { |r| r.position_after(1000) }
puts "Test positions are #{positions}"

reindeer = parse(File.readlines("/Users/kph/stuff/aoc2015/day14/input.txt"))
positions = reindeer.map { |r| r.position_after(2503) }
puts "Winner position is #{positions.max}" # 2696

test_scores = new_scoring(test_reindeer, 1000)
puts "Test scores are #{test_scores}" # the puzzle text says 689, but 689+312 = 1001 not 1000?

scores = new_scoring(reindeer, 2503)
winner = scores.max_by(&:last)
puts "Winner is #{winner}" # 1084
