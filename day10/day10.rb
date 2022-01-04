input = "1113222113"

# http://www.se16.info/js/lands2.htm
def read_elements
  elements = {}
  evolution = {}
  File.readlines("/Users/kph/Stuff/aoc2015/day10/elements.txt").map(&:strip).each do |line|
    parts = line.split("\t")
    elt = parts[1]
    evol = parts[2].split(' ').map(&:strip)
    text = parts[3]
    elements[elt] = text
    evolution[elt] = evol
  end
  [ elements, evolution ]
end

def look_and_say(input)
  chars = input.split('')
  chars[1..].reduce([ [chars[0]] ] ) do |rec, char|
    if rec.last.first == char
      rec.last << char
    else
      rec << [ char ]
    end
    rec
  end.reduce([]) { |res, group| res + [ group.count, group.first ] }.join
end

def look_and_say_elements(input, count)
  elements, evolution = read_elements
  initial = elements.key(input)
  puts "Initial element is #{initial}"
  result = (1..count).reduce([ initial ]) do |current, _|
    current.map { |e| evolution[e] }.flatten
  end
  result.map { |e| elements[e].length }.reduce(0, &:+)
end


result = look_and_say_elements(input, 40)
puts "Result size is #{result}" # 252594

result2 = look_and_say_elements(input, 50)
puts "Next result size is #{result2}" # 3579328
