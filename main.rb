require_relative "lib/board"
require_relative "lib/shape"
require_relative "lib/shapes/nought"
require_relative "lib/shapes/cross"
require_relative "lib/player"


def main()
  puts "Welcome to tic-tac-toe!"
  valid_letter = false
  input_letter = 'o'
  while !valid_letter
    puts "Player 1: Please type 'o' to play as nought or 'x' to play as cross."
    letter = gets.chomp
    puts letter
    if ["o", "x"].include?(letter)
      input_letter = letter
      valid_letter = true
    else
      puts "#{letter} is not a valid input."
    end
  end

  player_1 = nil
  player_2 = nil
  if input_letter == 'o'
    player_1 = Player.new(1, Nought.new)
    player_2 = Player.new(2, Cross.new)
    puts "Player 1 will be noughts (O)."
    puts "Player 2 will be crosses (X)."
  else
    player_1 = Player.new(1, Cross.new)
    player_2 = Player.new(2, Nought.new)
    puts "Player 1 will be crosses (X)."
    puts "Player 2 will be noughts (O)."
  end
  
  shape_to_full_name = {"O" => :noughts, "X" => :crosses}
  board = Board.new
  current_player = player_1
  game_over = false
  player_has_won = false
  drawn_game = false
  valid_move = false

  while !game_over
    begin
      board.display
      while !valid_move
        puts "Player #{current_player.number_id}: Please select the row to place a #{current_player.shape.value} from 0 (1st row) - 2 (3rd row)."
        row = Integer(gets.chomp)
        puts "Player #{current_player.number_id}: Please select the column to place a #{current_player.shape.value} from 0 (1st column) - 2 (3rd column)."
        column = Integer(gets.chomp)
        valid_move = board.add(current_player.shape.value, row, column)
        if !valid_move
          puts "You cannot place a #{current_player.shape.value} at (#{row}, #{column}), as there is already a shape there."
          board.display
        end
      end
    rescue StandardError => e
      # puts "#{e}"
      puts "Invalid input: Please type a value from 0 - 2."
      retry
    end
    # After every move, check if there is a draw or if the current player has won.
    # player_has_drawn = board.check_draw_condition(current_player.shape.value)
    player_has_won = board.check_win_condition(current_player.shape.value)
    drawn_game = board.check_draw_condition()

    if player_has_won || drawn_game
      game_over = true
    end
    # Need to check the draw condition as well.

    if !game_over
      # Switch the player turns
      current_player == player_1 ? current_player = player_2 : current_player = player_1
      valid_move = false
    end
    
  end
  board.display
  if player_has_won
    puts "Player #{current_player.number_id} has won with " \
                    "#{shape_to_full_name[current_player.shape.value]} " \
                    "(#{current_player.shape.value})."
  elsif drawn_game
    puts "This game is a draw."
  end
end

main()