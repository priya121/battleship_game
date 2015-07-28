require 'player'
require 'display'

class Game
  SHIPS = {:battleship => ['S','S','S','S'],
           :destroyer => ['D','D'],
           :submarine => ['SUB','SUB','SUB'],
           :aircraft_carrier => ['A','A','A','A','A'],
           :cruiser => ['C','C','C']}

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

  def place_ship(position)
    @cells[position] = SHIPS[:battleship][0]
    @cells
  end

  def place_destroyer(position)
    @cells[position] = SHIPS[:destroyer][0]
    @cells[position + 1] = SHIPS[:destroyer][1]
    @cells
  end
   
  def place_submarine(position)
    @cells[position] = SHIPS[:submarine][0]
    @cells[position + 1] = SHIPS[:submarine][1]
    @cells[position + 2] = SHIPS[:submarine][2]
    @cells
  end

  def target(index_from_coordinate)
    hit_or_miss(index_from_coordinate)
  end

  def hit_or_miss(column_number)
    if @cells[column_number] == SHIPS[:battleship][0]
      @cells[column_number] = HIT_BATTLESHIP
    elsif  @cells[column_number] == SHIPS[:destroyer][0]
      @cells[column_number] = HIT_DESTROYER
    elsif  @cells[column_number] == SHIPS[:submarine][0]
      @cells[column_number] = HIT_SUBMARINE
    elsif @cells[column_number] != SHIPS[:battleship][0] || @cells[column_number] != SHIPS[:destroyer][0] || @cells[column_number] != SHIPS[:submarine][0]
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
