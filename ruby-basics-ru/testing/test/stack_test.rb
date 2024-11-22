# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'
require 'minitest/power_assert'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @stack = Stack.new
  end

  def teardown
    @stack.clear!
  end

  def test_if_add_item_to_stack
    assert { @stack.empty? }
    @stack.push! 'added_string'
    refute { @stack.empty? }
  end

  def test_if_delete_item_from_stack
    assert { @stack.empty? }
    @stack.push! 'added_string'
    refute { @stack.empty? }
    @stack.pop!
    assert { @stack.empty? }
  end

  def test_if_stack_clear
    assert { @stack.empty? }
    @stack.push! 'added_string'
    refute { @stack.empty? }
    @stack.clear!
    assert { @stack.empty? }
  end

  def test_if_stack_empty
    assert { @stack.empty? }
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
