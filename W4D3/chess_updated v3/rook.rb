require_relative "slideable.rb"
require_relative "board.rb"
require_relative "null_piece.rb"

class Rook < Piece

    include Slideable

    attr_reader :symbol, :color
    attr_accessor :pos
    
    def initialize(color, board, pos)
        @symbol = :R
        super(color, board, pos)
    end

    def move_dirs
        return {"horizontal" => true, "diagonal" => false}
    end

end