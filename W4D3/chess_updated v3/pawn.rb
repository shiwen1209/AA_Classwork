require_relative "board.rb"
require_relative "null_piece.rb"
require_relative "piece.rb"

class Pawn < Piece

    attr_reader :symbol, :color
    attr_accessor :pos
    
    def initialize(color, board, pos)
        @symbol = :P
        super(color, board, pos)
    end

    def at_start_row?
        row, col = self.pos
        if self.color == :black && row == 1
            true
        elsif self.color == :white && row == 6
            true
        else
            false
        end
    end

    def forward_dir
        row, col = self.pos

        if self.color == :black
            1
        else
            -1
        end
    end

    def forward_steps
        row, col = self.pos
        up_one = [row + forward_dir, col]
        up_two = [row + (forward_dir * 2), col]

        arr = []

        if self.board[up_one].empty?
            arr << up_one
        end
        
        if at_start_row? && self.board[up_one].empty? && self.board[up_two].empty?
            arr << up_two
        end

        arr
    end

    def side_attacks
        row, col = self.pos

        arr = []

        side1 = [row + forward_dir, col + forward_dir]
        side2 = [row + forward_dir, col - forward_dir] 

        if (0..7).include?(side1[0]) && (0..7).include?(side1[1]) && !self.board[side1].empty? && self.board[side1].color != self.color 
            arr << side1
        end
        if (0..7).include?(side2[0]) && (0..7).include?(side2[1]) && !self.board[side2].empty? && self.board[side2].color != self.color
            arr << side2 
        end
        arr
    end

    def moves
        arr = []

        arr += side_attacks
        arr += forward_steps
        arr.select { |pos| (0..7).include?(pos[0]) && (0..7).include?(pos[1]) }
    end
end