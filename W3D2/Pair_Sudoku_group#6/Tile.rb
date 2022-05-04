class Tile

    attr_reader :given
    attr_accessor :value
    def initialize(value)
        if value != 0 
            @given = true
        else
            @given = false
        end
        @value = value
    end
end