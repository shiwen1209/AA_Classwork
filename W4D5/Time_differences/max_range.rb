def windowed_max_range1(arr, w)
    current_max = nil
    i = 0
    while i < arr.length - w + 1
        sub = arr[i, w].max -  arr[i, w].min
        if current_max == nil || current_max < sub 
            current_max = sub
        end
        i += 1 
    end
    current_max
end
# p windowed_max_range1([1, 0, 2, 5, 4, 8], 2) # 4, 8
# p windowed_max_range1([1, 0, 2, 5, 4, 8], 3) # 0, 2, 5
# p windowed_max_range1([1, 0, 2, 5, 4, 8], 4)   # 2, 5, 4, 8
# p windowed_max_range1([1, 3, 2, 5, 4, 8], 5) # 3, 2, 5, 4, 8


class MyQueue
    attr_accessor :index
    def initialize
        @store = []
        @index = 0
    end

    def peek
        @store.first
    end

    def size
        @store.length
    end
    def empty?
        @index == @store.length
    end

    def enqueue(el)
        @store.push(el)
    end

    def dequeue
        if !empty?
            first = @store[@index]
            @index += 1
            return first
        else
            return nil
        end
    end
end

class MyStack 

    attr_reader :max, :min
    def initialize
        @store = []
        # @max = nil
        # @min = nil
    end

    def push(ele)
        @store<< ele
        # @max = ele if @max == nil || ele > @max
        # @min = ele if @min == nil || ele < @min
    end

    def pop
        @store.pop
    end

    def peek
        @store.last
    end

    def size
        @store.length
    end

    def empty?
        @store.empty?
    end

end

class StackQueue
    def initialize
        @stack1 = MyStack.new
        @stack2 = MyStack.new
    end

    def size
        @stack1.size + @stack2.size
    end

    def empty?
        @stack1.empty? && @stack2.empty?
    end

    def enqueue(ele)
        @stack1.push(ele)
    end

    def dequeue
        if !@stack2.empty?
            return @stack2.pop
        else
            until @stack1.empty?
                item = @stack1.pop
                @stack2.push(item)
            end
        end
        @stack2.pop
    end
end

class MinMaxStack 

    attr_accessor :max, :min
    def initialize
        @store = []
        @max = nil 
        @min = nil 
    
    end

    def push(ele)
        @max = ele if @max == nil || ele > @max
        @min = ele if @min == nil || ele < @min

        @store<< [ele, @max, @min]
    end

    def pop
        a = @store.pop
        if !self.empty?
            @max = @store.last[1]
            @min = @store.last[2]
        else
            @max = nil 
            @min = nil 
        end
        return a[0]
    end

    def peek
        @store.last[0]
    end

    def size
        @store.length
    end

    def empty?
        @store.empty?
    end

end

class MinMaxStackQueue
    def initialize
        @stack1 = MinMaxStack.new
        @stack2 = MinMaxStack.new
    end

    def size
        @stack1.size + @stack2.size
    end

    def empty?
        @stack1.empty? && @stack2.empty?
    end

    def enqueue(ele)
        @stack1.push(ele)
    end

    def dequeue
        if !@stack2.empty?
            return @stack2.pop
        else
            until @stack1.empty?
                item = @stack1.pop
                @stack2.push(item)
            end
        end
        @stack2.pop
    end

    def min 
        return nil if @stack1.min == nil && @stack2.min == nil 
        return @stack2.min if @stack1.min == nil 
        return @stack1.min if @stack2.min == nil 
        @stack1.min < @stack2.min ? @stack1.min : @stack2.min
    end 

    def max 
        return nil if @stack1.max == nil && @stack2.max == nil 
        return @stack2.max if @stack1.max == nil 
        return @stack1.max if @stack2.max == nil 
        @stack1.max > @stack2.max ? @stack1.max : @stack2.max
    end
end

def windowed_max_range2(arr, w)
    current_max = nil
    s = MinMaxStackQueue.new
    arr.each_with_index do |ele, i|
        s.enqueue(ele)
        if s.size > w
            s.dequeue 
            current_max = s.max - s.min if current_max == nil || (s.max - s.min) > current_max
        end
    end
    return current_max
end


p windowed_max_range2([1, 0, 2, 5, 4, 8], 2)
p windowed_max_range2([1, 0, 2, 5, 4, 8], 3) 
p windowed_max_range2([1, 0, 2, 5, 4, 8], 4) 
p windowed_max_range2([1, 3, 2, 5, 4, 8], 5)