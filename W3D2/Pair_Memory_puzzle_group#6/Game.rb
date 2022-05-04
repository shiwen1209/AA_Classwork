require_relative "Card.rb"
require_relative "Board.rb"
require_relative "Player.rb"
require_relative "Ai.rb"

class Game

    attr_accessor :board, :previous_guesses
    def initialize (num = 4)
        @num = num
        @board = Board.new(num)
        @board.populate
        @player = Player.new
        @ai = Ai.new
    end

    def play
        count = 0
        while !@board.won?
            @board.render
            pos1 = @player.get_position  # this is for human player
            # pos1 = @ai.get_first_position(@board) #this is for ai
            @board.grid[pos1[0]][pos1[1]].reveal
            @board.render
            pos2 = @player.get_position # this is for human player
            # pos2 = @ai.get_second_position(@board, pos1) #this is for ai
            @board.grid[pos2[0]][pos2[1]].reveal
            # @ai.receive_match(@board, pos1, pos2) #this is for ai
            @board.render
            self.hide?(@board.grid[pos1[0]][pos1[1]], @board.grid[pos2[0]][pos2[1]])
            count += 1
            puts "You've guessed #{count} times"
            puts '--------'
        end
        puts "You win!"
    end

    def hide? (card1, card2)
        if card1.value != card2.value
            card1.hide
            card2.hide
        end
    end
end 