require_relative 'piece.rb'
require 'singleton.rb'

class NullPiece < Piece

    include Singleton

    attr_reader :color, :symbol

    def initialize
        @color = "_"     
        @symbol = " "   
    end

    def empty?
        true
    end

end