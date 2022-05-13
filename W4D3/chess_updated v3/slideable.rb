module Slideable 
    HORIZONTAL_DIR = ["up", "down", "left", "right"]
    DIAGONAL_DIR = ["upleft", "upright", "downleft", "downright"]

    def horizontal_dirs
        pos = self.pos
        arr = []
        HORIZONTAL_DIR.each do |dir|
            arr += self.helper(pos, dir)
        end
        arr.select {|pos| (0..7).include?(pos[0]) && (0..7).include?(pos[1])}
    end

    def helper(pos, dir)
        row, col = pos
        arr = []
        (1..7).each do |i|
            if dir == "up"
                move = [row - i, col]
            elsif dir == "down"
                move = [row + i, col]
            elsif dir == "left"
                move = [row, col + i]
            elsif dir == "right"
                move = [row, col  - i]
            elsif dir == "upleft"
                move = [row - i , col - i]
            elsif dir == "upright"
                move = [row - i, col + i]
            elsif dir == "downleft"
                move = [row + i, col - i]
            elsif dir == "downright"
                move = [row + i, col + i]
            end

            r, c = move
            
            if (0..7).include?(r) && (0..7).include?(c) && self.board[move].color == self.color 
                break 
            elsif (0..7).include?(r) && (0..7).include?(c) && self.board[move].color == "_" 
                arr << move
            elsif (0..7).include?(r) && (0..7).include?(c) && self.board[move].color != self.color
                arr<< move # trigger opponent to lose a piece, update the board with the new piece 
                break
            end
        end 
        return arr
    end


    def diagonal_dirs 
        pos = self.pos
        arr = []
        DIAGONAL_DIR.each do |dir|
            arr += self.helper(pos, dir)
        end
        arr.select {|pos| (0..7).include?(pos[0]) && (0..7).include?(pos[1])}
    end 

    def move_dirs
        return {"horizontal" => true, "diagonal" => true}
    end

    def moves
        arr = []
        arr += self.horizontal_dirs if self.move_dirs["horizontal"] == true
        arr += self.diagonal_dirs if self.move_dirs["diagonal"] == true
        arr
    end

end