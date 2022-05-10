require "byebug"
require_relative 'tic_tac_toe'


class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos
  def initialize(board, mark)
    @board = board
    @next_mover_mark = mark
    @prev_move_pos = []
  end

  def losing_node?(evaluator)
      # debugger
      # return true if @board.tied? 
      # return false if evaluator == @next_mover_mark && self.children.length == 1 && self.children[0].board.tied? 
      return false if @board.tied? 
      return false if @board.winner == :x  && evaluator == :x
      return false if @board.winner == :o && evaluator == :o
      return true if @board.winner == :o && evaluator == :x
      return true if @board.winner == :x && evaluator == :o

      if evaluator == @next_mover_mark && self.children.all?{|kid| kid.losing_node?(evaluator) }
        return true
      elsif evaluator != @next_mover_mark && self.children.any?{|kid| kid.losing_node?(evaluator) }
        return true 
      else
        return false
      end
    
  end

  def winning_node?(evaluator)
      # return false if @board.tied? 
      return true if @board.winner == :x  && evaluator == :x
      return true if @board.winner == :o && evaluator == :o
      return false if @board.winner == :o && evaluator == :x
      return false if @board.winner == :x && evaluator == :o

      if evaluator == @next_mover_mark && self.children.any?{|kid| kid.winning_node?(evaluator)}
        return true
      elsif evaluator != @next_mover_mark && self.children.all?{|kid| kid.winning_node?(evaluator)}
        return true 
      else
        return false
      end


  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    all_pos = (0..2).to_a.product((0..2).to_a)
    new_arr = []
    if @next_mover_mark == :x
      new_mark = :o
    else 
      new_mark = :x
    end
    
    all_pos.each do |pos|
      if @board.empty?(pos)
        new_board = @board.dup
        new_board[pos]= @next_mover_mark
        new_child = TicTacToeNode.new(new_board, new_mark)
        new_child.prev_move_pos= pos
        new_arr<< new_child
      end 
    end
    return new_arr

  end
  

end


# node = TicTacToeNode.new(Board.new, :o)
# node.board[[0, 0]] = :x
# node.board[[0, 1]] = :o
# node.board[[0, 2]] = :x
# node.board[[1, 0]] = :o
# node.board[[1, 1]] = :x
# node.board[[1, 2]] = :o
# node.board[[2, 0]] = :o
# node.board[[2, 1]] = :x
# node.losing_node?(:o)