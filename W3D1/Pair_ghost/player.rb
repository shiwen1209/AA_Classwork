class Player

    attr_reader :name
    def initialize(name)
        @name = name
    end

    def guess
        puts "#{@name} please enter a letter"
        letter = gets.chomp
        if !alert_invalid_guess(letter)
            raise "invalid input"
        end
        return letter 
    end 

    def alert_invalid_guess(guess)
        if guess.length != 1
            return false 
        else
            return true 
        end 
    end

end