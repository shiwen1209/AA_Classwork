require "byebug"

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
            return color == :white ? " ♕ " : " ♛ "
        when :K
            return color == :white ? " ♔ " : " ♚ "
        when :B
            return color == :white ? " ♗ " : " ♝ "
        when :H
            return color == :white ? " ♘ " : " ♞ "
        when :P
            return color == :white ? " ♙ " : " ♟ "
        when :R
            return color == :white ? " ♖ " : " ♜ "
        else
            return "   "
        end
    end

    def empty?
        false
    end

    def move_into_check?(end_pos)
        # debugger
        # p "mover"
        new_board = @board.dup
        # old_pos = @pos
        # p "e0"
        # p @pos
        # p end_pos 
        # p new_board[@pos].class
        # p new_board[end_pos].class
        # p "old board"
        # p self.board[[0,1]].class
        # p self.board[[2,2]].class
        # p self.board[[2,0]].class
        # p self.board[[0,1]].pos
        # p self.board[[0,1]].object_id
        # p self.object_id
        # p self.board[[0,0]].object_id
        # p "new board"
        # p new_board[[0,1]].class
        # p new_board[[2,2]].class
        # p new_board[[2,0]].class
        # p new_board[[0,1]].pos
        # p new_board[[0,1]].object_id
        # p new_board[[0,0]].object_id

        # new_board.move_piece(@pos, end_pos)

        piece = new_board[@pos]
        new_board[end_pos] = piece
        piece.pos = end_pos
        new_board[@pos] = NullPiece.instance
        # p "e1"
        # p new_board[old_pos]
        # p new_board[end_pos].class
        # p "xyz"
        # p @color
        # p "check new board"
        # p new_board[[7,4]].class
        # p new_board[[7,4]].color
        # p new_board[[4,7]].class
        # p new_board[[4,7]].color
        # p new_board[[4,7]].moves
        # p new_board.in_check?(@color)
        new_board.in_check?(@color)
    end

    def valid_moves
        p "valid?"
        self.moves.select do |move|
            # p "x"
            # p move
            # p "y"
            # p self.pos
            !move_into_check?(move)
        end
    end

    def pos=(val)
    end

    

    private


end 