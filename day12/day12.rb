require 'json'

json = JSON.parse(File.read("/Users/kph/Stuff/aoc2015/day12/input.txt"))

def count_numbers(json)
  case(json)
  when Integer
    json
  when String
    0
  when Array
    json.reduce(0) { |sum, thing| count_numbers(thing) + sum }
  when Hash
    count_numbers(json.keys) + count_numbers(json.values)
  end
end

numbers = count_numbers(json)
puts "Number sum is #{numbers}" # 191164


def count_numbers_no_red(json)
  case(json)
  when Integer
    json
  when String
    0
  when Array
    json.reduce(0) { |sum, thing| count_numbers_no_red(thing) + sum }
  when Hash
    json.values.include?("red") ? 0 : (count_numbers_no_red(json.keys) + count_numbers_no_red(json.values))
  end
end

numbers2 = count_numbers_no_red(json)
puts "Number sum without red is #{numbers2}" # 87842
