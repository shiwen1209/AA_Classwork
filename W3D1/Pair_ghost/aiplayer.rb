class AiPlayer
  attr_reader :name
  
    def initialize(name)
        @name = name
        @dictionary = Hash.new
        File.foreach("dictionary.txt") do |word|
            @dictionary[word.chomp] = word.chomp
        end 
    end

    def guess(fragment)
        win_move = []
        loss_move = []
        ("a".."z").each do |letter|
            if @dictionary.has_key?(fragment + letter)
                loss_move<< letter
            elsif @dictionary.any? {|k, v| k.include?(fragment + letter) }
                win_move<< letter
            end
        end

        if win_move.length > 0 
            return win_move.sample
        else
            return loss_move.sample 
        end
    end




end