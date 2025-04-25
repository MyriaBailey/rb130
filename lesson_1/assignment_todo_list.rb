=begin
Making a `TodoList` which contains `Todo` objects
Internally in `TodoList` using an `Array` for the collection of `Todo`s



=end

# Given TodoList starter:

# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  # rest of class needs implementation

  def add(todo)
    raise TypeError, "Can only add Todo objects" unless todo.is_a?(Todo)
    self.todos << todo
  end

  alias_method :<<, :add

  def size
    todos.size
  end

  def first
    todos.first
  end

  def last
    todos.last
  end

  def to_a
    todos
  end

  def done?
    todos.all? { |todo| todo.done? }
  end

  def item_at(idx)
    todos.fetch(idx)
  end

  def mark_done_at(idx)
    todos.fetch(idx).done!
  end

  def mark_undone_at(idx)
    todos.fetch(idx).undone!
  end

  def done!
    todos.each { |todo| todo.done! }
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(idx)
    todos.fetch(idx)
    todos.delete_at(idx)
  end

  def to_s
    items = todos.map { |todo| todo.to_s }

    header = "---- " + title + " ----"
    items.unshift(header)

    items.join("\n")
  end

  def each
    counter = 0

    while counter < todos.size
      yield(todos[counter])
      counter += 1
    end

    self
  end

  def select
    items = todos.select { |todo| yield(todo) }

    new_list = TodoList.new(title)
    items.each { |item| new_list << item }

    new_list
  end

  def find_by_title(t)
    idx = todos.find_index { |todo| todo.title == t }
    item_at(idx)
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(t)
    find_by_title(t).done! if find_by_title(t)
  end

  def mark_all_done
    done!
  end

  def mark_all_undone
    todos.each { |todo| todo.undone! }
  end

  private

  attr_accessor :todos

end

# Given Todo code:

# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

# Tests given:

# given
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")

# ---- Adding to the list -----

# add
list.add(todo1)                 # adds todo1 to end of list, returns list
list.add(todo2)                 # adds todo2 to end of list, returns list
list.add(todo3)                 # adds todo3 to end of list, returns list
# list.add(1)                     # raises TypeError with message "Can only add Todo objects"

# <<
# same behavior as add
# list << 2


# ---- Interrogating the list -----

# size
# list.size                       # returns 3

# first
# list.first                      # returns todo1, which is the first item in the list

# last
# list.last                       # returns todo3, which is the last item in the list

#to_a
# list.to_a                      # returns an array of all items in the list

#done?
# list.done?                     # returns true if all todos in the list are done, otherwise false

# ---- Retrieving an item in the list ----

# item_at
# list.item_at                    # raises ArgumentError
# list.item_at(1)                 # returns 2nd item in list (zero based index)
# list.item_at(100)               # raises IndexError

# ---- Marking items in the list -----

# mark_done_at
# list.mark_done_at               # raises ArgumentError
# list.mark_done_at(1)            # marks the 2nd item as done
#list.mark_done_at(100)          # raises IndexError

# mark_undone_at
# list.mark_undone_at             # raises ArgumentError
# list.mark_undone_at(1)          # marks the 2nd item as not done,
# list.mark_undone_at(100)        # raises IndexError

# done!
# list.done!                      # marks all items as done

# ---- Deleting from the list -----

# shift
# list.shift                      # removes and returns the first item in list

# pop
# list.pop                        # removes and returns the last item in list

# remove_at
# list.remove_at                  # raises ArgumentError
# list.remove_at(1)               # removes and returns the 2nd item
# list.remove_at(100)             # raises IndexError

# ---- Outputting the list -----

# to_s
# list.to_s                      # returns string representation of the list

# ---- Today's Todos ----
# [ ] Buy milk
# [ ] Clean room
# [ ] Go to gym

# or, if any todos are done

# ---- Today's Todos ----
# [ ] Buy milk
# [X] Clean room
# [ ] Go to gym

# Each method:

# list.each do |todo|
#   puts todo
# end

# Select method:

# todo1.done!

# results = list.select { |todo| todo.done? }    # you need to implement this method

# puts results.inspect

# Other Methods

# puts list.find_by_title("Buy milk")

# puts list.all_not_done

# list.mark_done("Go to gym")
# list.mark_all_undone
# puts list