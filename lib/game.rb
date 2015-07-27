require 'player'

class Game
  EMPTY = "E"
  MISS = "M"
  HIT = "H"
  HIT_DESTROYER = "HD"
  HIT_SUBMARINE = "HS"
  SHIP = "S"
  DESTROYER = "D"
  SUBMARINE = "SUB"

  attr_accessor :row_label, :column_label
  attr_reader :cells

  def initialize(input,cells,row_label,column_label)
    @input = input
    @cells = cells
    @row_label = row_label
    @column_label = column_label
  end

  def self.generate_empty_cells(rows,columns)
   @empty_grid = ''
   empty_cells =  ("E" * (rows.size * columns.size))
   @empty_grid << empty_cells
   @empty_grid.split(//)
  end

  def self.generate_grid(size)
    grid = []
    (0..size - 1). each do |cell|
      rand = [EMPTY,SHIP].sample
      grid << rand
    end
    grid
  end

  def place_ship(position)
    @cells[position] = SHIP
    @cells
  end

  def place_destroyer(position)
    @cells[position] = DESTROYER
    @cells[position + 1] = DESTROYER
    @cells
  end
   
  def place_submarine(position)
    @cells[position] = SUBMARINE
    @cells[position + 1] = SUBMARINE
    @cells[position + 2] = SUBMARINE
    @cells
  end

  def target(index_from_coordinate)
    hit_or_miss(index_from_coordinate)
  end

  def hit_or_miss(column_number)
    if @cells[column_number] == SHIP
      @cells[column_number] = HIT
    elsif  @cells[column_number] == DESTROYER
      @cells[column_number] = HIT_DESTROYER
    elsif  @cells[column_number] == SUBMARINE
      @cells[column_number] = HIT_SUBMARINE
    elsif @cells[column_number] != SHIP || @cells[column_number] != DESTROYER || @cells[column_number] != SUBMARINE
      @cells[column_number] = MISS
    end
    player_one_move(@cells)
  end

  def player_one_move(guessed)
    @coordinates_after_guess = []
    guessed.each do |cell|
      coordinate_empty(cell)
      coordinate_ship_hit(cell)
      coordinate_destroyer_hit(cell)
      coordinate_submarine_hit(cell)
      coordinate_unchanged(cell)
    end
    @coordinates_after_guess
  end

  def coordinate_empty(cell)
    if cell == MISS 
      @coordinates_after_guess << "◦"
    end
  end

  def coordinate_ship_hit(cell)
    if cell == HIT 
      @coordinates_after_guess << "HIT"
    end
  end

  def coordinate_unchanged(cell)
    if cell == EMPTY || cell == SHIP || cell == DESTROYER || cell == SUBMARINE
      @coordinates_after_guess << "∙"
    end
  end

  def coordinate_destroyer_hit(cell)
    if cell == HIT_DESTROYER
      @coordinates_after_guess << "HD"
    end
  end

  def coordinate_submarine_hit(cell)
    if cell == HIT_SUBMARINE
      @coordinates_after_guess << "HS"
    end
  end

  def ships_left_on_grid
    total_ships = []
    @cells.each_with_index do |coordinate,index|
      if coordinate == "S" || coordinate == "D"
        total_ships << index
      end
    end
    total_ships.size
  end
end
