require_relative "Card.rb"

class Board

    attr_accessor :grid, :num

    def initialize (num=4)
        @num = num
        @grid = Array.new(num) {Array.new(num, "*")}
        @values = {"L"=>2, "H"=>2,"I"=>2,"O"=>2,"R"=>2,"Z"=>2,"K"=>2,"F"=>2}
    end

    def populate
        @grid.each_with_index do |subarr, i|
            subarr.each_with_index do |ele, j|
                value = @values.select {|k,v| v>0}.keys.sample
                card = Card.new(value)
                @values[value] -= 1
                @grid[i][j] = card
            end
        end
    end

    def render
        @grid.each do |row|
            arr = row.map do |ele|
                if ele.face_up
                    ele.value
                else
                    "*"
                end
            end
            puts arr.join
        end
    end

    def won?
        @grid.each do |row|
            row.each do |card|
                if card.face_up == false
                    return false 
                end 
            end 
        end 
        true
    end

    def reveal(pos)
        if !@grid[pos[0]][pos[1]].face_up
            @grid[pos[0]][pos[1]].reveal
        end
    end


end