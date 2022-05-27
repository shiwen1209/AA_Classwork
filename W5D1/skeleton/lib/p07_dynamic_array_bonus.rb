require "byebug"


class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray

  include Enumerable

  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    if i < 0 && i >= -@count
      return @store[@count + i]
    elsif i < -@count || i >= @count
      return nil 
    else 
      return @store[i]
    end
  end

  def []=(i, val)
    if i < 0 && i >= -@count
      @store[@count + i] = val
    elsif i < -@count 
      return nil 
    elsif i >= @count
      # debugger
      (i - @count).times {push(nil)}
      push(val)
    else 
      @store[i] = val
    end

  end

  def capacity
    @store.length
  end

  def include?(val)
    i = 0
    while i < @count
      if @store[i] == val 
        return true
      end
    end
    return false
  end

  def push(val)
    if @count >= capacity
      resize!
    end
    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    if @count = capacity - 1
      resize!
    end
    i = @count
    while i > 0 
      @store[i] = @store[i-1]
      i -= 1
    end 
    @store[0] = val
    @count += 1
  end

  def pop
    return nil if @count == 0
    result = @store[@count-1]
    @store[@count-1] = nil 
    @count -= 1
    return result
  end

  def shift
    return nil if @count == 0
    result = @store[0]
    i = 0 
    while i < @count 
      @store[i] = @store[i+1]
      i += 1
    end
    @store[@count-1] = nil 
    @count -= 1
    return result
  end

  def first
    @store[0]
  end

  def last
    @store[@count-1]
  end

  def each
    i = 0
    while i < @count
      yield @store[i]
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false if @count != other.count
    i = 0 
    while i < @count
      if self[i] != other[i]
        return false
      end
      i += 1
    end
    return true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    old_store = @store.dup
    @store = StaticArray.new(capacity*2)
    @count = 0 
    i = 0 
    while i < old_store.length
      self.push(old_store[i])
      i += 1
    end
  end
end
