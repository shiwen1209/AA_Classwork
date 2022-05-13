require_relative "slideable.rb"
require_relative "board.rb"
require_relative "null_piece.rb"

class Queen < Piece

    include Slideable

    attr_reader :symbol, :color
    attr_accessor :pos
    
    def initialize(color, board, pos)
        @symbol = :Q
        super(color, board, pos)
    end
end