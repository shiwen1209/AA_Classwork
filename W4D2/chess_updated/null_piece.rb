# require_relative 'piece.rb'
require 'singleton'

class NullPiece < Piece

    include Singleton

    attr_reader :color

    def initialize
        @color = "_"        
    end

    def symbol
        :empty
    end

    def empty?  #overload empty for pieces
        return true
    end

end