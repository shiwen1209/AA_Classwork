require_relative "piece.rb"
require_relative "null_piece.rb"
require_relative "queen.rb"
require_relative "rook.rb"
require_relative "bishop.rb"
require_relative "king.rb"
require_relative "knight.rb"

class Board

    def initialize 
        @rows = Array.new(8) {Array.new(8, NullPiece.instance) } #have to make this null piece }
        @null_piece = NullPiece.instance
        @black_pieces = []
        @white_pieces = []
        populate
    end

    def [](pos)
        i, j = pos
        return @rows[i][j]
    end

    def []=(pos, val) #val is a piece
        i, j = pos
        @rows[i][j] = val
    end

    def move_piece(start_pos, end_pos)
        raise 'starting position is empty' if self[start_pos] == @null_piece
        i, j = end_pos
        raise "Invalid end position" if i > 7 || j > 7 
        piece = self[start_pos]
        self[end_pos] = piece
        self[start_pos] = @null_piece
        render #potentially remove later
    end

    def valid_pos?(pos)
    end

    def add_piece(piece, pos)
    end

    def in_check?(color)
    end

    def check_mate?(color)
    end

    def find_king(color)
    end 

    def pieces
    end 

    def dup
    end

    def move_piece!(color, start_pos, end_pos)
    end

    def populate
        (0..7).each do |i|
            (0..7).each do |j|
                if i == 0 && j == 3
                    queen = Queen.new(:white, self, [i,j])
                    @rows[i][j] = queen
                    @white_pieces<< queen
                elsif i == 7 && j == 3
                    queen = Queen.new(:black, self, [i,j])
                    @rows[i][j] = queen
                    @black_pieces<< queen
                elsif i == 0 && j == 4
                    king = King.new(:white, self, [i,j])
                    @rows[i][j] = king
                    @white_pieces<< king
                elsif i == 7 && j == 4
                    king = King.new(:black, self, [i,j])
                    @rows[i][j] = king
                    @black_pieces<< king
                elsif i == 0 && (j == 1 || j == 6)
                    p = Knight.new(:white, self, [i,j])
                    @rows[i][j] = p
                    @white_pieces<< p
                elsif i == 7 && (j == 1 || j == 6)
                    p = Knight.new(:black, self, [i,j])
                    @rows[i][j] = p
                    @black_pieces<< p
                elsif i == 0 && (j == 2 || j == 5)
                    p = Bishop.new(:white, self, [i,j])
                    @rows[i][j] = p
                    @white_pieces<< p
                elsif i == 7 && (j == 2 || j == 5)
                    p = Bishop.new(:black, self, [i,j])
                    @rows[i][j] = p
                    @black_pieces<< p
                elsif i == 0 && (j == 0 || j == 7)
                    p = Rook.new(:white, self, [i,j])
                    @rows[i][j] = p
                    @white_pieces<< p
                elsif i == 7 && (j == 0 || j == 7)
                    p = Rook.new(:black, self, [i,j])
                    @rows[i][j] = p
                    @black_pieces<< p
                else
                    @rows[i][j] = @null_piece
                end
            end
        end
    end

    def render
        @rows.each do |sub|
            puts sub.map { |ele| ele.to_s}.join("  ")
        end
    end

end

if __FILE__ == $PROGRAM_NAME 
    b = Board.new
    b.populate
    b.render 
    p b[[0,3]]
    p b[[7,3]]
end 