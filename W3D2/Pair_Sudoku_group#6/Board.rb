require_relative "Tile.rb"

class Board

    attr_accessor :grid

    def initialize(file_name)
        @grid = []
        @file_name = file_name
        File.foreach(@file_name) do |line|
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
            puts line.join
        end
    end

    def update_value(pos, val)
        i = pos[0]
        j = pos[1]
        @grid[i][j].value = val
    end

    def solved?
        all_blocks_solved? && all_rows_solved? && all_columns_solved?
    end

    def row_solved?(row)
        sorted = [1,2,3,4,5,6,7,8,9]
        row.sort == sorted
    end

    def all_rows_solved?
        @grid.each do |subarr|
            row = subarr.map {|ele| ele.value}
            return false if !self.row_solved?(row)
        end 
        return true 
    end


    def all_columns_solved?
        new_grid = @grid.transpose
        new_grid.each do |subarr|
            row = subarr.map {|ele| ele.value}
            return false if !self.row_solved?(row)
        end 
        return true 
    end

    def block_solved?(block)
        arr = block.flatten.map {|ele| ele.value}
        self.row_solved?(arr)
    end

    def all_blocks_solved?
        block1 = [@grid[0][0..2], @grid[1][0..2], @grid[2][0..2]]
        block2 = [@grid[0][3..5], @grid[1][3..5], @grid[2][3..5]]
        block3 = [@grid[0][6..8], @grid[1][6..8], @grid[2][6..8]]
        block4 = [@grid[3][0..2], @grid[4][0..2], @grid[5][0..2]]
        block5 = [@grid[3][3..5], @grid[4][3..5], @grid[5][3..5]]
        block6 = [@grid[3][6..8], @grid[4][6..8], @grid[5][6..8]]
        block7 = [@grid[6][0..2], @grid[7][0..2], @grid[8][0..2]]
        block8 = [@grid[6][3..5], @grid[7][3..5], @grid[8][3..5]]
        block9 = [@grid[6][6..8], @grid[7][6..8], @grid[8][6..8]]
        all_blocks = [block1, block2, block3, block4, block5, block6, block7, block8, block9]
        all_blocks.all? {|block| self.block_solved?(block)}
    end


    
end