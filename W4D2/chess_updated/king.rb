require_relative "stepable.rb"
require_relative "board.rb"
require_relative "null_piece.rb"

class King < Piece

    include Stepable

    attr_reader :symbol
    attr_accessor :pos
    def initialize(color, board, pos)
        @symbol = :K
        super
    end

end