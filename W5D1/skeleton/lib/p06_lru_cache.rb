require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    value = nil
    if @map.include?(key)
      node = @map[key]
      new_node = update_node!(node)
      @map[key] = new_node
      return node.val
    else
      calc!(key)
    end
    
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
 
      value = @prc.call(key)
      @store.append(key, value)
      @map.set(key, @store.last)

      eject! if count > @max
      return value
  end

  def update_node!(node)
    node.prev.next = node.next
    @store.last.next = node
    node.prev = @store.last
    node.next = @store.tail
    @store.tail.prev = node
  end

  def eject!
    @map.delete(@store.first.key)
    @store.head.next = @store.first.next
    @store.first.next.prev = @store.head
  end
end
