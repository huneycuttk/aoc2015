dimensions = File.readlines("/Users/kph/Stuff/aoc2015/day2/input.txt")

paper, ribbon = dimensions.reduce([0,0]) do |(paper, ribbon), dim|
  (l,w,h) = dim.split("x").map(&:to_i)
  paper += 2*l*w + 2*w*h + 2*l*h + [l,w,h].sort[0..1].reduce(1, &:*)
  ribbon += l*w*h + [l,w,h].sort[0..1].reduce(0) { |r, s| r + 2*s }
  [paper, ribbon]
end

# paper is 1606483, ribbon 3842356
puts "paper is #{paper}, ribbon is #{ribbon}"
