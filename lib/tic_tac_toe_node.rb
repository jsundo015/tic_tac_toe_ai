require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @prev_move_pos = prev_move_pos
    @next_mover_mark = next_mover_mark
    @board = TicTacToe.board
  end

  def losing_node?(evaluator) #dfs
    return true if @board.over? and @board.winner != evaluator
    return false if @board.over? and @board.winner.nil?
    return false if @board.over? and @board.winner == evaluator

    @board.children.each do |child|
      res = losing_node?(child.board.winner)
      return res unless res == nil 
    end

  end

  def winning_node?(evaluator) #dfs
    return true if @board.over? and @board.winner == evaluator
    return false if @board.over? and @board.winner.nil?
    return false if @board.over? and @board.winner != evaluator

    @board.children.each do |child|
      res = winning_node?(child.board.winner)
      return res unless res == nil
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    @board.each.with_index do |row, i|
      row.each.with_index do |spot, j|
        temp_board = @board.dup
        temp_board[i, j] = next_mover_mark if spot.empty?
        prev_move_post = temp_board[i, j]
        children << temp_board
      end
    end
        #if a board spot is empty, 
        #we populate a deep dupe of board with the mark, 
        #then push this populated board into children
    # end
    return children
  end
  
end
