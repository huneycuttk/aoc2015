row = 2981
col = 3075

# ordinal of the values in the row start with k-1+v_k-1
# this is the sum of digits from 1..row-1 + 1
# in the row, values are offset by sum of integers from (row+1)..(row+col-1)

def ordinal(row, col)
  rowinitial = (row)*(row-1)/2 + 1
  offset = (col-1)*( (row+1) + (row+col-1) ) / 2
  rowinitial+offset
end

def transform(value)
  ( value * 252533 ) % 33554393
end

def calculate(initial, ordinal)
  (1...ordinal).reduce(initial) { |s, _| transform(s) }
end

desired = ordinal(row, col)
puts "Finding #{desired}th grid item"
current = 20151125
result = calculate(20151125, desired)

puts "Result is #{result}" # 9132360
