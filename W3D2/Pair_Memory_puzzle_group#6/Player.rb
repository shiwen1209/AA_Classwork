class Player

    def initialize
    end

    def get_position
        puts "Please enter a position: "
        pos = gets.chomp.split.map {|ele| ele.to_i}
        pos
    end
    
end