require_relative "Board.rb"
require_relative "Tile.rb"

class Game

    def initialize(file_name)
        @file_name = file_name
        @board = Board.new(@file_name)
    end

    def play
        until @board.solved?
            @board.render
            begin 
                print "Please under a pos and value: "
                input_arr = gets.split(" ").map {|ele| ele.to_i}
                i, j, val = input_arr
                pos = [i, j]
                raise ArgumentError if @board.grid[i][j].given || !(0...9).include?(i) || !(0...9).include?(j) 
            rescue
                puts "That is not a legal position, please try again"
                retry
            end 
            @board.update_value(pos, val)
        end
        puts "You completed the sudoku!"
    end
end
