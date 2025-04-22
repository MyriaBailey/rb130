# Building the `times` method from scratch

def times(num)
  counter = 0

  while counter < num do
    yield(counter) if block_given?
    counter += 1
  end

  counter
end

p times(5) { |n| puts n }