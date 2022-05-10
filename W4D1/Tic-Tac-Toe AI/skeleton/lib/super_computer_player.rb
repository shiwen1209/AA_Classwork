require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    newNode = TicTacToeNode.new(game.board,mark)

    op_mark = ""
    if mark == :x
      op_mark = :o
    else
      op_mark = :x
    end
         
    newNode.children.each do |child|
            if  child.winning_node?(mark) && child.children.all?{|kid| kid.losing_node?(op_mark)} 
              return child.prev_move_pos
            end
    end

    newNode.children.each do |child|
      if !child.losing_node?(mark)
        return child.prev_move_pos
      end
    end

    raise "AI is dumb"
    
    

  end

end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end

