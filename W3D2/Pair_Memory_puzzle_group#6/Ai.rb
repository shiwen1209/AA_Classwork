require_relative "Board.rb"

class Ai

    attr_accessor :known_cards, :matched_cards
    
    def initialize
        @known_cards = Hash.new {|h, k| h[k] = []} # l 00  "l"=> [[0,0], [0,1]]
        @matched_cards = []
    end

    def receive_revealed_card(pos, card_value)
        @known_cards[card_value]<< pos
    end

    def receive_match(board, pos1, pos2)
        if board.grid[pos1[0]][pos1[1]].value == board.grid[pos2[0]][pos2[1]].value
            @matched_cards<< pos1
            @matched_cards<< pos2
        end
    end
    
    def get_first_position(board)
        @known_cards.each do |k, v|
            if v.length == 2 && !@matched_cards.include?(v[0])
                return v[0]
            end 
        end

        pos = random_position(board.num)
        until !@known_cards.values.flatten(1).include?(pos)
            pos = random_position(board.num)
        end

        self.receive_revealed_card(pos, board.grid[pos[0]][pos[1]].value)
        return pos
    end



    def random_position(num)
        pos = []
        pos<< rand(0...num)
        pos<< rand(0...num)
        return pos
    end 

    def get_second_position(board, pos)
        first_card_value = board.grid[pos[0]][pos[1]].value
        @known_cards.each do |k, v|
            if k == first_card_value && v.length == 2
                return v[1]
            end 
        end

        pos = random_position(board.num)
        until !@known_cards.values.flatten(1).include?(pos)
            pos = random_position(board.num)
        end

        self.receive_revealed_card(pos, board.grid[pos[0]][pos[1]].value)
        return pos
    end



end