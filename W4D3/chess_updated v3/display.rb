require_relative "board.rb"
require_relative "cursor.rb"
require "colorize"
require "colorized_string"

class Display

   attr_reader :board
   attr_accessor :cursor
   def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], @board)
    render
   end 

    def render
        board.rows.each_with_index do |sub, i|
            sub.each_with_index do |piece, j|
                if @cursor.cursor_pos == [i, j]
                    print piece.to_s.colorize(:red).colorize( :background => :light_green)
                elsif piece.empty? 
                    if (i.even? && j.even?) || (i.odd? && j.odd?)
                        print "   ".colorize(:background => :light_blue)
                    else 
                        print "   ".colorize(:background => :light_yellow)
                    end
                else
                    if (i.even? && j.even?) || (i.odd? && j.odd?)
                        print piece.to_s.colorize(piece.color).colorize( :background => :light_blue)
                    else 
                        print piece.to_s.colorize(piece.color).colorize( :background => :light_yellow)
                    end
                end
            end 
            print "\n"
        end
        puts
    end

    

end