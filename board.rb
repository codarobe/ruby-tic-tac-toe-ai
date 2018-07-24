module TicTacToe
  class Board
    def initialize(player_one_symbol, player_two_symbol, board_array = nil)
      if board_array
        @board = Marshal.load(Marshal.dump(board_array))
      else
        @board = [['[0]', '[1]', '[2]'], ['[3]', '[4]', '[5]'], ['[6]', '[7]', '[8]']]
      end
      @player_one_symbol = player_one_symbol
      @player_two_symbol = player_two_symbol
    end

    def set_position(index, symbol)
      row = index / 3
      column = index % 3
      if is_valid_move(row, column)
        @board[row][column] = symbol
        return true
      end
      false
    end

    def is_valid_move(row, column)
      return false if row < 0 || row > 2
      return false if column < 0 || column > 2
      if @board[row][column] == @player_one_symbol || @board[row][column] == @player_two_symbol
        return false
      end
      true
    end

    def check_for_win
      (0..2).each do |i|
        winner = check_column_for_match(i)
        return winner if winner
        winner = check_row_for_match(i)
        return winner if winner
      end
      winner = check_diagonals
      return winner if winner
      false
    end

    def check_column_for_match(index)
      symbol = @board[0][index]
      return symbol if @board[1][index] == symbol && @board[2][index] == symbol
      false
    end

    def check_row_for_match(index)
      symbol = @board[index][0]
      return symbol if @board[index][1] == symbol && @board[index][2] == symbol
      false
    end

    def check_diagonals
      symbol = @board[1][1]
      return symbol if @board[0][0] == symbol && @board[2][2] == symbol
      return symbol if @board[0][2] == symbol && @board[2][0] == symbol
      false
    end

    def no_moves_remaining
      @board.each do |row|
        row.each do |cell|
          if cell != @player_one_symbol && cell != @player_two_symbol
            return false
          end
        end
      end
      true
    end

    def print_board
      @board.each do |row|
        row.each do |cell|
          print(cell)
        end
        print("\n")
      end
    end

    def get_board
      Marshal.load(Marshal.dump(@board))
    end
  end
end
