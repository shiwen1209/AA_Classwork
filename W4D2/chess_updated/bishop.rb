require_relative "slideable.rb"
require_relative "board.rb"
require_relative "null_piece.rb"

class Bishop < Piece

    include Slideable

    attr_reader :symbol
    attr_accessor :pos
    def initialize(color, board, pos)
        @symbol = :B
        super
    end

    def move_dirs
        return {"horizontal" => false, "diagonal" => true}
    end
end