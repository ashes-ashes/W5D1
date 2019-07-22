require 'byebug'

class MaxIntSet

  attr_reader :store

  def initialize(max)
    @max = max
    @store = Array.new(max + 1, false)
  end

  def insert(num)
    if is_valid?(num)
      @store[num] = true
    else
      raise "Out of bounds"
    end
  end

  def remove(num)
    if is_valid?(num)
      @store[num] = false
    else
      raise "Out of bounds"
    end
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
   (0..@max).include?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets] << num
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !include?(num)
      self[num] << num
      @count += 1
      if @count >= num_buckets
        resize!
      end
    end
  end

  def remove(num)
    if include?(num)
    @store[num % num_buckets].delete(num)
    @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    idx = num % num_buckets
    @store[idx]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @count = 0
    old_arr = @store
    @store = Array.new(old_arr.length * 2) { Array.new() }
    old_arr.each do |sub|
      sub.each do |num|
        insert(num)
      end
    end
  end
end
