=begin
Recreate the `reduce` method from scratch

- yields two arguments to the block
  - first is accumulator/memo, second is current element
- return value of block is assigned to the accumulator obj
- can give accumulator a default value as optional parameter
  - this is the starting value

if NO argument given:
- memo = first element of arr, val = second
- counter = 0 or 1, depending on if used for memo or val

if YES starting argument given:
- memo = starting argument
- val = first element of arr

if start.nil?
- memo = arr[0]
- counter = 1
- val = arr[1]
- start iterating on 1...arr.size
else
- memo = start
- counter = 0
- val = arr[0]
- start iterating on 0...arr.size

=end

def reduce(arr, start = nil)
  counter = 0
  memo = arr[0]

  if start.nil?
    counter += 1 
  else
    memo = start
  end

  while counter < arr.size do
    memo = yield(memo, arr[counter])
    counter += 1
  end
  
  memo
end


array = [1, 2, 3, 4, 5]

p (reduce(array) { |acc, num| acc + num })                    # => 15
p (reduce(array, 10) { |acc, num| acc + num })                # => 25
# reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass

p (reduce(['a', 'b', 'c']) { |acc, value| acc += value })     # => 'abc'
p (reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value }) # => [1, 2, 'a', 'b']