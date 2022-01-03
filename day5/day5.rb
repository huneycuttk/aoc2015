strings = File.readlines("/Users/kph/Stuff/aoc2015/day5/input.txt").map(&:strip)

# PART 1
nice = strings.filter do |string|
  chars = string.split('')

  # ab, cd, pq, or xy immediate no
  # must have three vowels (can be repeated)
  # must have a double letter
  string !~ /(ab)|(cd)|(pq)|(xy)/ &&
    chars.filter { |c| ["a", "e", "i", "o", "u"].include?(c) }.count >= 3 &&
    !chars.each_cons(2).find { |(a,b)| a == b }.nil?
end
count = nice.count

puts "Number of nice strings is #{count}"

# PART 2
nice_new = strings.filter do |string|
  chars = string.split('')
  pairs = chars.each_cons(2).map(&:join)

  # match a pair twice (use regex here)
  # pair with one letter in between (so a group of three where first == last)
  !pairs.find { |p| string =~ /.*#{p}.*#{p}.*/ }.nil? &&
  !chars.each_cons(3).find { |(a,b,c)| a == c }.nil?
end
count_new = nice_new.count
puts "Number of nice strings with new rules is #{count_new}"
