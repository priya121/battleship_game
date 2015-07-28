require 'player'
require 'display'

class Grid
  SHIPS = {:battleship => 4,
           :destroyer => 2,
           :submarine => 3,
           :aircraft_carrier => 5,
           :cruiser => 3}

  BATTLESHIP = "S"
  DESTROYER = "D"
  SUBMARINE = "Sub"
  EMPTY = "E"
  MISS = "M"
  HIT_BATTLESHIP = "H"
  HIT_DESTROYER = "HD"
  HIT_SUBMARINE = "HS"

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

  def draw_ship(ship,position)
    SHIPS.each do |draw_ship,number_of_cells|
      if ship == draw_ship
        i = 0
        number_of_cells.times do |new_ship|
          @cells[position + (i)] = "S"
          i += 1
        end
      end
    end
    @cells
  end

  def place_ship(position)
    @cells[position] = BATTLESHIP
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
    if @cells[column_number] == BATTLESHIP
      @cells[column_number] = HIT_BATTLESHIP
    elsif  @cells[column_number] == DESTROYER
      @cells[column_number] = HIT_DESTROYER
    elsif  @cells[column_number] == SUBMARINE
      @cells[column_number] = HIT_SUBMARINE
    elsif @cells[column_number] != BATTLESHIP || @cells[column_number] != DESTROYER || @cells[column_number] != SUBMARINE
      @cells[column_number] = MISS
    end
    Display.new(@cells,@row_label,@column_label,@output).player_one_move
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
