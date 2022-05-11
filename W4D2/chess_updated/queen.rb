require_relative "slideable.rb"
require_relative "board.rb"
require_relative "null_piece.rb"

class Queen < Piece

    include Slideable

    attr_reader :symbol
    attr_accessor :pos
    def initialize(color, board, pos)
        @symbol = :Q
        super
    end
end