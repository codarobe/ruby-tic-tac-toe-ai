module TicTacToe
  require('./board')
  class Opponent
    def initialize(my_symbol, player_symbol)
      @my_symbol = my_symbol
      @player_symbol = player_symbol

    end

    def make_move(board_array)
      @simulation = Simulation.new(board_array, @my_symbol, @player_symbol)
      @simulation.run_simulations(1000, board_array)
    end

  end

  class Simulation
    def initialize(board_array, my_symbol, player_symbol)
      @board_array = board_array
      @my_symbol = my_symbol
      @player_symbol = player_symbol
    end

    def mts(simulation_count)
      available_moves = get_available_moves(@board_array)
      best_move = available_moves.first
      best_move_score = -1 * simulation_count
      available_moves.each do |move|
        board = Board.new(@my_symbol, @player_symbol, @board_array)
        board.set_position(move, @my_symbol)
        current_score = simulate_n_matches(board, simulation_count)
        if current_score > best_move_score
          best_move = move
          best_move_score = current_score
        end
      end
      best_move
    end

    def run_simulations(simulation_count, board_array)
      available_moves = get_available_moves(board_array)
      best_move = available_moves.first
      best_move_score = -1 * simulation_count
      available_moves.each { |move|
        board = Board.new(@my_symbol, @player_symbol, board_array)
        board.set_position(move, @my_symbol)
        current_score = simulate_n_matches(board, simulation_count)
        if current_score > best_move_score
          best_move = move
          best_move_score = current_score
        end
      }
      best_move
    end

    def simulate_n_matches(board, n)
      score = 0
      (0..n).each {
        new_board = Board.new(@my_symbol, @player_symbol, board.get_board)
        score += simulate_match(new_board)
      }
      score
    end

    def simulate_match(board)
      @current_player = @my_symbol
      winner = is_over(board)
      until winner
        move = get_random_move
        until make_move(board, move)
          move = get_random_move
        end
        winner = is_over(board)
      end
      if winner == @my_symbol
        1
      elsif winner == @player_two
        -1
      else
        0
      end
    end

    def switch_player
      @current_player = @current_player == @my_symbol ? @player_symbol : @my_symbol
    end

    def make_move(board, index)
      success = board.set_position(index, @current_player)
      if success
        switch_player
        true
      else
        false
      end
    end

    def is_over(board)
      winner = board.check_for_win
      if winner
        return winner
      end
      if board.no_moves_remaining
        return true
      end
      false
    end

    def get_random_move
      Random.rand(9)
    end

    def get_available_moves(board_array)
      moves = []
      (0..8).each do |i|
        row = i / 3
        column = i % 3
        symbol = board_array[row][column]
        if symbol != @my_symbol && symbol != @player_symbol
          moves.push(i)
        end
      end
      moves
    end
  end
end
