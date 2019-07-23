require 'byebug'

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end

  def inspect
    to_s
  end
end

class LinkedList

  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    # debugger
    @head.next == @tail
  end

  def get(key)
  end

  def include?(key)
  end

  def append(key, val)
    node1 = Node.new(key, val)
    node1.prev = last
    last.next = node1
    node1.next = @tail
    @tail.prev = node1

  end

  def update(key, val)
  end

  def remove(key)
  end

  def each(&prc)
    nodes = [first]
    until nodes[-1].next == @tail
      nodes << nodes[-1].next
    end
    nodes.each { |node| prc.call(node) }
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
