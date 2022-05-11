module Stepable
    
    def moves
        row, col = self.pos
        arr = []
        
        if self.is_a?(King)
            arr = [
            [row + 1, col], #moves up  #WS: add comma
            [row, col + 1], #moves right
            [row + 1, col + 1], #move up 1, right 1 southeast
            [row - 1, col], #moves down 1
            [row, col - 1], # moves left 1
            [row - 1, col -1 ], # northwest
            [row + 1, col - 1], # southwest
            [row - 1, col + 1], #northeast
            ]
            
            return arr.select {|pos| (0..7).include?(pos[0]) && (0..7).include?(pos[1]) && self.board[pos].color != self.color}
            
        
        elsif self.is_a?(Knight)

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

            return  arr.select {|pos| (0..7).include?(pos[0]) && (0..7).include?(pos[1]) && self.board[pos].color != self.color}
        end
    end

end