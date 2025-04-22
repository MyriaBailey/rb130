# Building an each method from scratch

def each(arr)
  counter = 0

  while counter < arr.size do
    yield(arr[counter]) if block_given?
    counter += 1
  end

  arr
end

each([1, 2, 3, 4, 5]) { |num| puts num }