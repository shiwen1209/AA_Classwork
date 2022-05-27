require_relative 'p04_linked_list'

class HashMap

  include Enumerable

  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    i = bucket(key)
    link = @store[i]
    link.include?(key)
  end

  def set(key, val)
    i = bucket(key)
    link = @store[i]
    if !link.include?(key)
      link.append(key, val)
      @count += 1
    else
      link.update(key, val)
    end
    
    if @count == num_buckets - 1
      self.resize!
    end

    return val
  end

  def get(key)
    i = bucket(key)
    link = @store[i]
    return link.get(key)
  end

  def delete(key)
    i = bucket(key)
    link = @store[i]
    link.remove(key)
    @count -= 1
  end

  

  def each
    @store.each do |link|
      link.each do |node|
        yield [node.key, node.val]
      end
    end

  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    dupped = @store.dup
    @count = 0 
    @store = Array.new(num_buckets*2) { LinkedList.new }
    dupped.each do |link|
      link.each do |node|
        set(node.key, node.val)
      end
    end
  end

  def bucket(key)
    key.hash % num_buckets
  end
end
