class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if self[num].include?(num)
      return
    end
    self[num]<< num
    @count += 1
    if @count == num_buckets 
      resize!
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    dupped = @store.dup
    @count = 0 
    @store = Array.new(num_buckets*2) { Array.new }
    dupped.each do |sub|
      sub.each do |ele|
        insert(ele)
      end
    end
  end
end
