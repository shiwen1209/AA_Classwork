require_relative "board.rb"
require_relative "display.rb"
require_relative "player.rb"
require_relative "human_player.rb"
require "byebug"

class Game
    attr_reader :board
    def initialize
        @board = Board.new 
        @board.populate
        @display = Display.new(@board)
        @player1 = HumanPlayer.new(:black, @display)
        @player2 = HumanPlayer.new(:white, @display)
        @current_player = @player2
        @opponent_player = @player1
    end

    def play
        
        until @board.in_check?(@current_player.color) && @board.check_mate?(@current_player.color)
            puts "It's #{@current_player.color}'s turn"
            @current_player.make_move(@board)
            p "#{@opponent_player.color} is in check" if @board.in_check?(@opponent_player.color)
            swap_turn
        end
        puts "checkmate!"
    end

    def swap_turn
        if @current_player == @player2
            @current_player = @player1 
            @opponent_player = @player2
        else
            @current_player = @player2
            @opponent_player = @player1
        end
    end

end

game = Game.new

game.play



