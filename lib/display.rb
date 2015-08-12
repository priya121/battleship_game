require 'grid'

class Display
  SHIPS = {:battleship => 4,
    :destroyer => 2,
    :submarine => 3,
    :aircraft_carrier => 5,
    :cruiser => 3}

  EMPTY = "E"

  def initialize(cells,row_label,column_label,output)
    @cells = cells
    @row_label = row_label
    @column_label = column_label
    @output = output
  end

  def display_table(cells)
    display_columns
    display_rows(cells)
    @output.puts "\n"
  end

  def display_columns
    @output.print "\t"
    @column_label.each do |number|
      @output.print number.center(8)
    end
    @output.puts "\n"
  end

  def display_rows(cells)
    @output.print @row_label[0]
    cells.each_with_index do |cell, index|
      @output.print "\t"
      @output.print cell.center(5)
      if last_cell_in_row?(index) == true
        @output.puts "\s"
        @output.print row_label_for_cell(index)
      end
    end
  end

  def last_cell_in_row?(index)
    (index + 1) % @column_label.size == 0
  end

  def row_label_for_cell(index)
    row_label_index = ((index + 1) / @column_label.size) 
    @row_label[row_label_index]
  end

  def player_one_move
    @coordinates_after_guess = []
    @cells.each do |cell|
      coordinate_empty(cell)
      coordinate_ship_hit(cell)
      coordinate_destroyer_hit(cell)
      coordinate_submarine_hit(cell)
      coordinate_aircraft_hit(cell)
      coordinate_cruiser_hit(cell)
      coordinate_unchanged(cell)
    end
    @coordinates_after_guess
  end

  def coordinate_empty(cell)
    if cell == :miss 
      @coordinates_after_guess << "◦"
    end
  end

  def coordinate_ship_hit(cell)
    if cell == :hit_battleship
      @coordinates_after_guess << "HB"
    end
  end

  def coordinate_unchanged(cell)
    if cell == EMPTY || cell == SHIPS.keys[0] || cell == SHIPS.keys[1] || cell == SHIPS.keys[2] || cell == SHIPS.keys[3] || cell == SHIPS.keys[4] || cell == SHIPS.keys[5]
      @coordinates_after_guess << "∙"
    end
  end

  def coordinate_destroyer_hit(cell)
    if cell == :hit_destroyer
      @coordinates_after_guess << "HD"
    end
  end

  def coordinate_cruiser_hit(cell)
    if cell == :hit_cruiser
      @coordinates_after_guess << "HC"
    end
  end

  def coordinate_submarine_hit(cell)
    if cell == :hit_submarine 
      @coordinates_after_guess << "HS"
    end
  end

  def coordinate_aircraft_hit(cell)
    if cell == :hit_aircraft_carrier 
      @coordinates_after_guess << "HA"
    end
  end

  def display_hit_or_miss(grid_after_player_move,index_after_player_move)
    missed_shot(grid_after_player_move,index_after_player_move)
    hit_a_ship(grid_after_player_move)
    destroyer_sunk(grid_after_player_move)
    submarine_sunk(grid_after_player_move)
    aircraft_carrier_sunk(grid_after_player_move)
    cruiser_sunk(grid_after_player_move)
  end

  def missed_shot(grid_after_player_move,index_after_player_move)
    unless grid_after_player_move[index_after_player_move] == "HB" || grid_after_player_move[index_after_player_move] == "HD" || grid_after_player_move[index_after_player_move] =="HS"
      @output.puts "You missed."
      @output.puts "Guess again"
    end
  end

  def hit_a_ship(grid_after_player_move)
    if grid_after_player_move.count("HB") == 4
      @output.puts "You sunk a battleship."
    end
  end

  def destroyer_sunk(grid_after_player_move)
    if grid_after_player_move.count("HD") == 2
      @output.puts "You sunk a destroyer."
    end
  end

  def submarine_sunk(grid_after_player_move)
      grid_after_player_move.count("HS") == 3
      @output.puts "You sunk a submarine."
  end

  def aircraft_carrier_sunk(grid_after_player_move)
    if grid_after_player_move.count("HA") == 5
      @output.puts "You sunk a aircraft carrier."
    end
  end

  def cruiser_sunk(grid_after_player_move)
    if grid_after_player_move.count("HC") == 3
      @output.puts "You sunk a cruiser."
    end
  end
end
