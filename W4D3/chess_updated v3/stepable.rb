module Stepable
    
    def king_moves
        row, col = self.pos

        arr = [
        [row + 1, col], #moves up
        [row, col + 1], #moves right
        [row + 1, col + 1], #move up 1, right 1 southeast
        [row - 1, col], #moves down 1
        [row, col - 1], # moves left 1
        [row - 1, col -1 ], # northwest
        [row + 1, col - 1], # southwest
        [row - 1, col + 1] #northeast
        ]
        
        
        
        arr.select {|pos| (0..7).include?(pos[0]) && (0..7).include?(pos[1]) && self.board[pos].color != self.color}
    
    
    end 

    def knight_moves
        row, col = self.pos

        arr = [
        [row + 2, col + 1], 
        [row + 2, col - 1], 
        [row + 1, col + 2], 
        [row + 1, col - 2], 
        [row - 1, col + 2], 
        [row - 1, col - 2], 
        [row - 2, col - 1], 
        [row - 2, col + 1] 
        ]

        arr.select {|pos| (0..7).include?(pos[0]) && (0..7).include?(pos[1]) && self.board[pos].color != self.color}
    end

    def moves
        if self.is_a?(King)
            king_moves
        elsif self.is_a?(Knight)
            knight_moves
        end 
    end

end