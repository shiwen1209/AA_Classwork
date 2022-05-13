class Array
    def my_uniq
        self.uniq
    end

    def two_sum
        pairs = []
        
        self.each_index do |i|
        ((i + 1)...self.length).to_a.each do |j|
            pairs << [i, j] if self[i] + self[j] == 0
            end
        end

        pairs
    end

    def my_transpose()
        d = self.length

        arr = Array.new(d) {Array.new(d)}
        (0...d).each do |i|
            (0...d).each do |j|
                arr[i][j] = self[j][i]
            end
        end
        arr
    end

end

def stockpicker(prices) 
    index_min = 0
    index_max = 0
    min = prices[0]
    max = prices[0]
    pp = 0
    pp_best = []
    prices.each_with_index do |price, i|
        if price < min
            min = price
            index_min = i
        elsif price > max
            max = price
            index_max = i
        end
        if index_min > index_max
                max = min
        end
        if pp < max - min
            pp = max - min
            pp_best = [index_min, index_max]
        end
    end
    
    return pp_best
end

class Hanoi
    attr_accessor :towers, :size

    def initialize(size)
        @size = size
        @towers = Array.new(3) {Array.new}
        (1..size).reverse_each do |num|
            @towers[0] << num
        end
    end

    def move(i, j)
        raise IOError if !(0...3).include?(i) || !(0...3).include?(j)
        raise IOError if towers[i].empty?
        if towers[j].empty? || towers[j].last > towers[i].last
            towers[j]<< towers[i].pop
            return true
        else
            return false 
        end 
    end

    def won?
        return true if towers[0].empty? && towers[1].empty? && towers[2].length == size
        return false
    end

    def play
        until won?
            begin
            p towers
            puts "please enter the column to move from and move to by entering their indices like 'x,y'"
            i, j = gets.chomp.split(",").map {|n| n.to_i}
            move(i, j)
            rescue IOError => e2,0
                p "Error occurured: #{e}"
                retry
            end

        end
        p "You won!"
    end

    
end

h = Hanoi.new(4)
h.play