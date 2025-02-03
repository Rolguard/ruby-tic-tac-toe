class Board
  attr_reader(:grid) 
  def initialize
    @grid = [['-', '-', '-'],
              ['-', '-', '-'],
              ['-', '-', '-']]
  end
  
  def display
    @grid.each {|row| puts row.join(" ")}
  end

  # Return true if a shape is added to a non-empty cell (valid move), otherwise return false (invalid move).
  def add(shape, row, column)
    if row < 0 || row > @grid.count
      return false
    elsif column < 0 || column > @grid[0].count
      return false
    elsif @grid[row][column] != "-"
      return false
    end
    @grid[row][column] = shape
    return true
  end

  def check_draw_condition()
    for row in 0..2
      for col in 0..2
        if @grid[row][col] == "-"
          return false
        end
      end
    end
    return true
  end

  # Expects a character string representing the shape on the board. E.g. 'O' or 'X'
  def check_win_condition(shape)
    return check_horizontal_win?(shape) || check_vertical_win?(shape) || check_diagonal_win?(shape)
  end

  private

  def check_horizontal_win?(shape)
    for row in 0..2
      shape_counter = 0
      for col in 0..2
        if grid[row][col] == shape
          shape_counter += 1
        end
      end
      if shape_counter == 3
        return true
      end
    end
    return false
  end
  def check_vertical_win?(shape)
    for col in 0..2
      shape_counter = 0
      for row in 0..2
        if grid[row][col] == shape
          shape_counter += 1
        end
      end
      if shape_counter == 3
        return true
      end
    end
    return false
  end
  def check_diagonal_win?(shape)
    # For a 3x3 tic-tac-toe board
    # Check [(0, 0), (1, 1), (2, 2) AND (0, 2), (1, 1), (2, 0)]
    
    # Check top left corner to bottom right diagonal
    shape_counter = 0
    for i in 0..2
      if grid[i][i] == shape
        shape_counter += 1
      end
    end
    if shape_counter == 3
      return true
    end

    # Check top right corner to bottom left diagonal
    row = 0
    col = 2
    shape_counter = 0
    while row <= 2 and col >= 0
      if grid[row][col] == shape
        shape_counter += 1
      end
      row += 1
      col -= 1
    end
    if shape_counter == 3
      return true
    end
    return false

  end
end