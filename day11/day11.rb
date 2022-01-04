initial = "cqjxjnds"

ALPHABET = "abcdefghijklmnopqrstuvwxyz".split('')

def increment_character(character)
  newidx = ALPHABET.find_index(character) + 1
  newidx = 0 if newidx % ALPHABET.length == 0
  [ALPHABET[newidx], newidx == 0]
end

def increment_string(string)
  reversed = string.reverse.split('')
  incr = true
  incremented = []
  reversed.each do |char|
    if incr
      res, incr = increment_character(char)
    else
      res = char
    end
    incremented << res
  end

  incremented.reverse.join
end

def has_straight_three(string)
  !string.split('').map { |c| ALPHABET.find_index(c) }.each_cons(3).find { |(a,b,c)| a == b-1 && a == c-2 }.nil?
end

def has_two_pairs(string)
  pairs = ALPHABET.map { |c| "#{c}#{c}" }

  first = pairs.find { |p| string =~ /.*#{p}.*/ }
  second = (pairs - [ first ]).find { |p| string =~ /.*#{p}.*/ }
end

def password_rules(string)
  has_straight_three(string) && has_two_pairs(string) && string !~ /[iol]/
end

def next_password(initial)
  result = increment_string(initial)
  while !password_rules(result)
    result = increment_string(result)
  end
  result
end

newp = next_password(initial)
puts "Next password is #{newp}" # cqjxxyzz

newp2 = next_password(newp)
puts "Next password is #{newp2}" # cqkaabcc
