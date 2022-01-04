CLUES = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1
}

def parse(data)
  data.map do |line|
    parts = line.split(' ', 3)
    number = parts[1][0..-2]
    properties = eval "{ #{parts.last} }"
    [ number, properties ]
  end
end

sues = parse(File.readlines("/Users/kph/Stuff/aoc2015/day16/input.txt"))
sue = CLUES.reduce(sues) { |remaining, (clue, value)| remaining.filter { |(sue, properties)| properties[clue].nil? || properties[clue] == value } }
puts "Sue is #{sue}" # 40

EXACT_CLUES = {
  children: 3,
  samoyeds: 2,
  akitas: 0,
  vizslas: 0,
  cars: 2,
  perfumes: 1
}

GT_CLUES = {
  cats: 7,
  trees: 3
}

LT_CLUES = {
  pomeranians: 3,
  goldfish: 5
}

remaining = EXACT_CLUES.reduce(sues) { |remaining, (clue, value)| remaining.filter { |(sue, properties)| properties[clue].nil? || properties[clue] == value } }
remaining = GT_CLUES.reduce(remaining) { |remaining, (clue, value)| remaining.filter { |(sue, properties)| properties[clue].nil? || properties[clue] > value } }
sue = LT_CLUES.reduce(remaining) { |remaining, (clue, value)| remaining.filter { |(sue, properties)| properties[clue].nil? || properties[clue] < value } }
puts "Sue is #{sue}" # 241
