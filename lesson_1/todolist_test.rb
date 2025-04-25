require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'assignment_todo_list'

class TodoListTest < Minitest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)

    @todos.shift
    assert_equal(@todos, @list.to_a)
  end

  def test_pop
    todo = @todos.pop
    assert_equal(todo, @list.pop)
    assert_equal(@todos, @list.to_a)
  end

  def test_done_question
    assert_equal(false, @list.done?)

    @list.mark_all_done
    assert_equal(true, @list.done?)
  end

  def test_add_type_error
    assert_raises(TypeError) do
      @list.add(5)
    end

    assert_raises(TypeError) { @list.add("hello") }
  end

  def test_shovel
    todo4 = Todo.new("Test")
    @list << todo4

    assert_equal(todo4, @list.last)
    assert_equal(4, @list.size)
  end

  def test_add_shovel_alias
    todo4 = Todo.new("Test")

    copy = @list.dup
    copy << todo4
    @list.add(todo4)
    
    assert_equal(copy.to_a, @list.to_a)
  end

  def test_item_at
    assert_equal(@todo1, @list.item_at(0))
    assert_raises(IndexError) { @list.item_at(50) }
  end

  def test_mark_done_at
    assert_equal(false, @list.item_at(0).done?)
    @list.mark_done_at(0)
    assert_equal(true, @list.item_at(0).done?)
    assert_equal(false, @list.item_at(1).done?)
    assert_equal(false, @list.item_at(2).done?)

    assert_raises(IndexError) { @list.mark_done_at(50) }
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_undone_at(50) }
    assert_equal(false, @list.item_at(1).done?)
    @list.mark_done_at(1)
    assert_equal(true, @list.item_at(1).done?)
    @list.mark_undone_at(1)
    assert_equal(false, @list.item_at(1).done?)
  end

  def test_done_bang
    @list.done!
    assert_equal(true, @list.done?)
  end

  def test_remove_at
    assert_equal(@todo2, @list.remove_at(1))
    assert_equal([@todo1, @todo3], @list.to_a)
    assert_raises(IndexError) { @list.remove_at(50) }
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
  
    assert_equal(output, @list.to_s)
  end

  def test_to_s_when_done
    @list.mark_done_at(1)

    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_when_all_done
    @list.done!

    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_each
    counter = 0

    @list.each { |_| counter += 1 }

    assert_equal(counter, @list.size)
  end

  def test_each_return
    val = @list.each { |todo| todo }
    assert_equal(@list, val)
  end

  def test_select
    @list.mark_done_at(1)
    selection = @list.select { |todo| todo.done? }

    assert_instance_of(TodoList, selection)
    assert_equal([@todo2], selection.to_a)
  end
end