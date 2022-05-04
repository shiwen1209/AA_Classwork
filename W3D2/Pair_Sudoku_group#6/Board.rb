require_relative "Tile.rb"

class Board

    attr_accessor :grid

    def initialize
        @grid = []
    end

    def from_file(name)
        File.foreach(name) do |line|
            subarr = line.chomp.split("").map {|ele| Tile.new(ele.to_i)}
            @grid << subarr
        end
    end

    def render
        @grid.each do |subarr|
            line = subarr.map do |ele|
                if ele.value == 0
                    "*"
                else
                    ele.value.to_s
                end 
            end
            p line
        end
    end

    def update_value(pos, value)
    end

    
end