require 'grid'

class Display
  SHIPS = {:battleship => 4,
    :destroyer => 2,
    :submarine => 3,
    :aircraft_carrier => 5,
    :cruiser => 3}

  HIT_SHIPS = {:hit_battleship => 'HB',
               :hit_submarine => 'HS',
               :hit_destroyer => 'HD',
               :hit_cruiser => 'HC',
               :hit_aircraft_carrier => 'HA',
               :miss => "◦",
               'E' => "∙",
               :battleship => "∙",
               :destroyer => "∙",
               :submarine => "∙",
               :aircraft_carrier => "∙",
               :cruiser => "∙"}
  EMPTY = 'E'

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
      @output.print cell
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

  def coordinate_empty(cell)
    cell == :miss 
    @coordinates_after_guess << "◦"
  end

  def coordinate_ship_hit(cell)
     cell == :hit_battleship
     @coordinates_after_guess << "HB"
  end

  def hit_made
    @cells.map do |cell| HIT_SHIPS[cell]
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

  def ship_sunk
    @cells.map do |cell| SHIPS[cell]
    end
  end

  def hit_a_ship(grid_after_player_move)
    grid_after_player_move.count("HB") == 4
    @output.puts "You sunk a battleship."
  end

  def destroyer_sunk(grid_after_player_move)
     grid_after_player_move.count("HD") == 2
     @output.puts "You sunk a destroyer."
  end

  def submarine_sunk(grid_after_player_move)
    grid_after_player_move.count("HS") == 3
    @output.puts "You sunk a submarine."
  end

  def aircraft_carrier_sunk(grid_after_player_move)
     grid_after_player_move.count("HA") == 5
     @output.puts "You sunk a aircraft carrier."
  end

  def cruiser_sunk(grid_after_player_move)
    grid_after_player_move.count("HC") == 3
    @output.puts "You sunk a cruiser."
  end
end
