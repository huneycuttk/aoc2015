instructions = File.readlines("/Users/kph/Stuff/aoc2015/day1/input.txt")

instruction = instructions.first.split('')

floor, neg = instruction.each.with_index.reduce([0,nil]) do |(f,neg), (i, idx)|
  nf = i == "(" ? f+1 : f-1
  nneg = (neg.nil? && nf < 0) ? idx+1 : neg
  [nf, nneg]
end

puts "floor is #{floor}, neg is #{neg}"
