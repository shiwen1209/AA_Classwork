require_relative "stepable.rb"
require_relative "board.rb"
require_relative "null_piece.rb"

class Knight < Piece

    include Stepable

    attr_reader :symbol, :color
    attr_accessor :pos
    
    def initialize(color, board, pos)
        @symbol = :H
        super(color, board, pos)
    end
end