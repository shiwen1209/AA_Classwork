

class Piece

    attr_reader :color, :board
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def symbol
        :O
    end

    def to_s
        case symbol
        when :Q
            return " ♕ "
        when :K
            return " ♔ "
        when :B
            return " ♗ "
        when :H
            return " ♘ "
        when :P
            return " ♙ "
        when :R
            return " ♖ "
        else
            return " _ "
        end
    end

    def empty?
        false
    end

    def move_into_check?(end_pos)
        p "mover"
        new_board = @board.dup
        new_board.move_piece(@pos, end_pos)
        new_board.in_check?(@color)
    end

    def valid_moves
        p "valid?"
        self.moves.select do |move|
            !move_into_check?(move)
        end
    end

    def pos=(val)
    end

    

    private


end 