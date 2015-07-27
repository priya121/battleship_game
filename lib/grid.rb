require 'game'

class Grid
  EMPTY = "E"
  MISS = "M"
  HIT = "H"
  SHIP = "S"
  DESTROYER = "D"

  def initialize(input,output,rows,columns,cells)
    @input = input
    @output = output
    @row_label = rows
    @column_label = columns
    @cells = cells
    @player = Player.new(@input,@row_label,@column_label)
    @grid = Game.new(@input,@cells,@row_label,@column_label) 
  end

  def ask_player_guess
    @output.puts "Guess a coordinate:\n"
    @index_after_player_move = @player.give_coordinate
    grid_after_player_move = @grid.target(@index_after_player_move)
    display_table(grid_after_player_move)
    display_hit_or_miss(grid_after_player_move)
  end

  def display_hit_or_miss(grid_after_player_move)
    missed_shot(grid_after_player_move)
    hit_a_ship(grid_after_player_move)
    hit_a_destroyer(grid_after_player_move)
    destroyer_sunk(grid_after_player_move)
  end

  def missed_shot(grid_after_player_move)
    unless grid_after_player_move[@index_after_player_move] == "HIT" || grid_after_player_move[@index_after_player_move] == "HD"
      @output.puts "You missed."
      @output.puts "Guess again"
    end
  end

  def hit_a_ship(grid_after_player_move)
    if grid_after_player_move.to_s.include?("HIT") 
      @output.puts "You sunk #{grid_after_player_move.count("HIT")} battleships."
    else
    end
  end

  def hit_a_destroyer(grid_after_player_move)
    if grid_after_player_move.to_s.include?("HD")
      @output.puts "You hit #{grid_after_player_move.count("HD")} part of a destroyer."
    end
  end

  def destroyer_sunk(grid_after_player_move)
    if grid_after_player_move.count("HD") == 2
      @output.puts "You sunk a destroyer."
    end
  end

  def start
    while ships_left_on_grid != 0
      ask_player_guess 
    end
    @output.puts "You sunk all the Battleships. You win"
  end

  def ships_left_on_grid
    @grid.ships_left_on_grid
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
