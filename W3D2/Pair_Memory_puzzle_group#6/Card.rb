class Card

    attr_accessor :face_up, :value
    def initialize(value)
        @face_up = false
        @value = value 
    end

    def reveal
        @face_up = true
    end

    def hide
        @face_up = false
    end

    def ==(card1, card2)
        if card1.value == card2.value
            return true
        end 
        return false 
    end



end