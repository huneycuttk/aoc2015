require 'digest'

key = "iwrupvqb"

number5 = -1

loop do
  number5 += 1
  digest = Digest::MD5.hexdigest("#{key}#{number5}")
  break if digest =~ /^00000/
end

puts "number 5 is #{number5}"

number6 = -1

loop do
  number6 += 1
  digest = Digest::MD5.hexdigest("#{key}#{number6}")
  break if digest =~ /^000000/
end

puts "number 6 is #{number6}"
