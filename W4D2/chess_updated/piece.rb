# require_relative "board.rb"

class Piece

    attr_reader :color, :board
    attr_accessor :pos
    def initialize(color, board, pos) # WS: added pos as a parameter, use when initiate the board
        @color = color  # changed color to symble  use :white or :black
        @board = board
        @pos = pos
    end

    def symbol
        :O
        # raise "needs to be overriden"  # this should be overiden by the children class method
    end

    def to_s
        case symbol
        when :Q
            return color === :white ?  "♕"  : "♛"     
        when :K
            return color === :white ?  "♔"  : "♚"     
        when :KN
            return color === :white ?  "♘"  : "♞"     
        when :B
            return color === :white ?  "♗"  : "♝"    
        when :R
            return color === :white ?  "♖"  : "♜"    
        else
            return "_"
        end
    end

    def empty?  #  every piece  is not empty
        return false 
    end

    def valid_moves?
    end

    def pos=(val)
    end

    

    private

    def move_into_check?(end_pos)
    end

end 