=begin
Write a select method that mirrors the behavior of Array#select.

- Takes a block
- Yields each element to the block
- If block eval's as true:
  - Current element is included in the returned array
- Returns a new array


- Takes an array parameter
- Takes a block (implicit or explicit)

- `selection = []`
- counter from 0 to arr size - 1
- while less than arr size:
  - add arr[counter] to selection if yield(arr[counter]) returns true
  - increment counter
- return selection
=end

def select(arr)
  selection = []
  counter = 0

  while counter < arr.size do
    selection << arr[counter] if yield(arr[counter])
    counter += 1
  end

  selection
end

# Tests

array = [1, 2, 3, 4, 5]

p select(array) { |num| num.odd? }      # => [1, 3, 5]
p select(array) { |num| puts num }      # => [], because "puts num" returns nil and evaluates to false
p select(array) { |num| num + 1 }       # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true
