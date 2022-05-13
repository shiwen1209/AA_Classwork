require_relative "display.rb"
require_relative "cursor.rb"

class HumanPlayer < Player

    def initialize(color, display)
        super
    end

    def make_move(board)
        begin
            start_move = []

            starter = true

            #while statement here gets us a start move when we press enter/space
            while starter == true
                cursor_val = display.cursor.get_input
                display.render
                puts "#{cursor_val}"
                if cursor_val != nil 
                    start_move = cursor_val
                    puts cursor_val.to_s + "is start move"
                    starter = false
                end
            end

            print "valid moves are: "
            p @display.board[start_move].moves

            raise StandardError.new("Invalid starting position") if board[cursor_val].color != self.color

            end_move = []

            #while statement here gets us an end move when we press enter/space
            ender = true 
            while ender == true
                cursor_val = display.cursor.get_input
                display.render
                if cursor_val != nil
                    end_move = cursor_val
                    puts cursor_val.to_s + "is end move"
                    ender = false
                end
            end

            board.move_piece(start_move, end_move)
            
        rescue StandardError => e
            puts "error occured: #{e}"
            retry
        end
        display.render
        
    end #------ end make_move method
end