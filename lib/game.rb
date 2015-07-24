require 'grid'
class Game
  EMPTY = "E"
  MISS = "M"
  HIT = "H"
  SHIP = "S"
  DESTROYER = "D"
  def initialize(input,output,rows,columns,grid)
    @input = input
    @output = output
    @row_label = rows
    @column_label = columns
    @grid = grid
  end

  def ask_player_guess
    @output.puts "Guess a coordinate:\n"
    @coordinate_guess = @input.gets.to_s
    player_move = (Grid.new(@grid,@row_label,@column_label).target(@coordinate_guess))
    display_table(player_move)
    if player_move.to_s.include?("HIT")
    @output.puts "You sunk #{player_move.count("HIT")} battleships."
    else
      @output.puts "You missed."
      @output.puts "Guess again"
    end
  end

  def start
    while ships_left_on_grid != 0
     ask_player_guess 
    end
    @output.puts "You sunk all the Battleships. You win"
  end

  def ships_left_on_grid
    Grid.new(@grid,@row_label,@column_label).ships_left_in_grid
  end

  def display_table(cells)
    display_columns
    display_rows(cells)
    @output.puts "\n"
  end

  def display_columns
    @output.print "\t"
    @column_label.each do |number|
      @output.print number.center(7)
    end
    @output.puts "\n"
  end

  def display_rows(cells)
    @output.print @row_label[0]
    cells.each_with_index do |cell, index|
      @output.print "\t"
      @output.print cell.center(5)
      new_row?(index)
    end
  end

  def new_row?(index)
    if last_cell_in_row?(index)
      @output.puts "\s"
      @output.print row_label_for_cell(index)
    end
  end

  def last_cell_in_row?(index)
    (index + 1) % @column_label.size == 0
  end

  def row_label_for_cell(index)
    row_label_index = ((index + 1) / @column_label.size) 
    @row_label[row_label_index]
  end
end


