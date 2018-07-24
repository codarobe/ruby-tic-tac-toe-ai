module TicTacToe
  require './board'
  require './opponent'
  class Game
    def initialize
      @player_one = '[X]'
      @player_two = '[O]'
      @board = Board.new(@player_one, @player_two)
      @current_player = @player_one
      single_player_game
    end

    def two_player_game
      system 'clear'
      winner = is_over
      until winner
        system 'clear'
        print_board
        print('Current Player: ' + String(@current_player), "\n")
        print('Make a selection: ')
        input = gets.chomp.to_i
        until make_move(input)
          system 'clear'
          print_board
          print('Current Player: ' + String(@current_player), "\n")
          print('Invalid selection!', "\n")
          print('Make a selection:')
          input = gets.chomp.to_i
        end
        winner = is_over
        system 'clear'
        print_board
      end
      if winner == @player_one
        puts 'Player 1 Wins!'
      elsif winner == @player_two
        puts 'Player 2 Wins!'
      else
        puts 'CAT - Tie Game'
      end
    end

    def single_player_game
      opponent = Opponent.new(@player_two, @player_one)
      system 'clear'
      winner = is_over
      until winner
        system 'clear'
        print_board
        print('Current Player: ' + String(@current_player), "\n")
        if @current_player == @player_one
          print('Make a selection: ')
          input = gets.chomp.to_i
          until make_move(input)
            system 'clear'
            print_board
            print('Current Player: ' + String(@current_player), "\n")
            print('Invalid selection!', "\n")
            print('Make a selection:')
            input = gets.chomp.to_i
          end
        else
          move = opponent.make_move(@board.get_board)
          make_move(move)
        end
        winner = is_over
        system 'clear'
        print_board
      end
      if winner == @player_one
        puts 'Player 1 Wins!'
      elsif winner == @player_two
        puts 'Player 2 Wins!'
      else
        puts 'CAT - Tie Game'
      end
    end

    def switch_player
      @current_player = @current_player == @player_one ? @player_two : @player_one
    end

    def make_move(index)
      success = @board.set_position(index, @current_player)
      if success
        switch_player
        true
      else
        false
      end
    end

    def is_over
      winner = @board.check_for_win
      if winner
        return winner
      elsif @board.no_moves_remaining
        return true
      end
      false
    end

    def print_board
      @board.print_board
    end

  end
end

TicTacToe::Game.new

