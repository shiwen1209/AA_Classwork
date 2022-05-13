require_relative "slideable.rb"
require_relative "board.rb"
require_relative "null_piece.rb"

class Bishop < Piece

    include Slideable

    attr_reader :symbol, :color
    attr_accessor :pos
    
    def initialize(color, board, pos)
        @symbol = :B
        super(color, board, pos)
    end

    def move_dirs
        return {"horizontal" => false, "diagonal" => true}
    end

end