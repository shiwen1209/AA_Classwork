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
      self.prev.next = self.next if self.prev
    self.next.prev = self.prev if self.next
    self.next = nil
    self.prev = nil
    self
  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail
  def initialize
    @head = Node.new
    @tail = Node.new
    @tail.prev = @head
    @head.next = @tail
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
    @head.next == @tail
  end

  def get(key)
    next_node = @head
    while next_node != nil
      return next_node.val if next_node.key == key
      next_node = next_node.next
    end
  end

  def include?(key)
    next_node = @head
    while next_node != nil
      return true if key == next_node.key
      next_node = next_node.next
    end
    false
  end

  def append(key, val)
    node = Node.new(key, val)
    old_node = @tail.prev
    old_node.next = node
    node.prev = old_node
    @tail.prev = node
    node.next = @tail
    return node
  end

  def update(key, val)
    next_node = @head
    while next_node != nil
      next_node.val = val if next_node.key == key
      next_node = next_node.next
    end
  end

  def remove(key)
    next_node = @head
    while next_node != nil
      if next_node.key == key
        current = next_node.prev
        next_next_node = next_node.next

        current.next = next_next_node
        next_next_node.prev = current
        break
      end

      next_node = next_node.next
    end
  end

  def each
    current_node = first
    while current_node.val != nil
      yield current_node
      current_node = current_node.next
    end
    
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
