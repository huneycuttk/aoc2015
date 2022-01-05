require 'prime'

presents = 36000000


# PART 1

# each house gets the sum of the divisors of the house number times ten.
# this is easy with ruby because of the Prime class and its prime_division method to find the
# prime factors
def sum_of_divisors(number)
  number.prime_division.map { |(factor, exponent)| (factor**(exponent+1)-1) / (factor-1) }.reduce(1, &:*)
end

house = 1
current = 10
while current < presents
  house += 1
  current = sum_of_divisors(house)*10
end

puts "First house with at least #{presents} is #{house} at #{current}" # 831600


# PART 2
def non_infinite_elf_presents(number)
  factors = number.prime_division
  primes, powers = factors.transpose
  exponents = powers.map{|i| (0..i).to_a}
  divisors = exponents.shift.product(*exponents).map do |powers|
    primes.zip(powers).map{|prime, power| prime ** power}.inject(&:*)
  end

  # exclude all divisors where number/divisor > 50
  elves = divisors.filter { |divisor| number / divisor <= 50 }

  elves.reduce(0, &:+) * 11
end

house = 1
current = 11
while current < presents
  house += 1
  current = non_infinite_elf_presents(house)
end

puts "First house with at least #{presents} is #{house} at #{current}" # 884520
