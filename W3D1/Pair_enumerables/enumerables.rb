class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    return self
  end

  def my_select(&prc)
    new_arr = []
    self.my_each(&prc).each do |ele|
        if prc.call(ele)
            new_arr<< ele
        end
    end 
    return new_arr
  end

  def my_reject(&prc)
    new_arr = []
    self.each do |ele|
      if !prc.call(ele)
        new_arr << ele
      end
    end
    return new_arr
  end

  def my_any?(&prc)
    self.each do |ele|
        return true if prc.call(ele)
    end
    return false
  end

  def my_all?(&prc)
    count = 0 
    self.each do |ele|
        count += 1 if prc.call(ele)
    end
    return true if count == self.length 
    return false
  end

  def my_flatten
    return [self] if !self.is_a?(Array)
    new_arr = []
    self.each do |ele|
      if ele.is_a?(Array)
        new_ele = ele.my_flatten
        new_arr += new_ele
      else
        new_arr << ele
      end
    end
    return new_arr
  end

  def my_zip(*arr)
    new_arr = Array.new(self.length) {Array.new}
    self.each_with_index do |ele, i|
        new_arr[i]<< ele
    end
    arr.each do |subs|
        subs.each_with_index do |ele, i|
            if new_arr[i] != nil
                new_arr[i]<< ele
            end
        end
    end

    new_arr.each do |array|
        if array.length < arr.length + 1
            (arr.length + 1 - array.length).times {array<< nil}
        end
    end
    return new_arr
  end

  def my_rotate(num=1)
    new_arr = []
    self.each_with_index do |ele, i|
      new_index = (i + num) % self.length
      new_arr << self[new_index]
    end
    return new_arr
  end

  def my_join(seperator = "")
    new_str = ""
    self.each do |ele|
        new_str = new_str + ele + seperator
    end
    if new_str[-1] == seperator
        new_str[-1] = ""
    end
    return new_str
  end 
  
  def my_reverse
    new_arr = []
    i = self.length - 1
    while i >= 0
      new_arr << self[i]
      i -= 1
    end
    return new_arr
  end
end



# return_value = [1, 2, 3].my_each do |num|
#   puts num
#  end.my_each do |num|
#   puts num
#  end

#  p return_value  # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

# p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# p [ 1 ].my_reverse               #=> [1]