require 'byebug'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    key = key.hash
    if !include?(key)
      self[key] << key
      @count += 1
      if @count >= num_buckets
        resize!
      end
    end
  end

  def include?(key)
    self[key.hash].include?(key.hash)
  end

  def remove(key)
    if include?(key)
      self[key.hash].delete(key.hash)
      @count -= 1
    end
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
