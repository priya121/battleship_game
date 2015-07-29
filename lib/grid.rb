require 'player'
require 'display'

class Grid
  SHIPS = {:battleship => 1,
           :destroyer => 2,
           :submarine => 3,
           :aircraft_carrier => 5,
           :cruiser => 3}

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
      rand = [EMPTY,SHIPS.keys].sample
      grid << rand
    end
    grid
  end

  def draw_ship(ship,position)
    SHIPS.each_with_index do |(draw_ship,number_of_cells),index|
    if ship == draw_ship
      i = 0
      number_of_cells.times do |new_ship|
        @cells[position + (i)] = SHIPS.keys[index]
        i += 1
      end
    end
    end
    @cells
  end

  def target(index_from_coordinate)
    hit_or_miss(index_from_coordinate)
  end
  def hit_or_miss(column_number)
    if @cells[column_number] == SHIPS.keys[0]
      @cells[column_number] = :hit_battleship
    elsif  @cells[column_number] == SHIPS.keys[1] 
      @cells[column_number] = :hit_destroyer 
    elsif  @cells[column_number] == SHIPS.keys[2]
      @cells[column_number] = :hit_submarine 
    elsif @cells[column_number] != SHIPS.keys[0]|| @cells[column_number] != SHIPS.keys[1] || @cells[column_number] != SHIPS.keys[2]
      @cells[column_number] = :miss
    end
    Display.new(@cells,@row_label,@column_label,@output).player_one_move
  end

def ships_left_on_grid
  
    @battleships = []
    @destroyers = []
    @submarines = []
    @cells.each_with_index do |coordinate,index|
    if coordinate == :battleship
      @battleships << coordinate
    end
    if coordinate == :destroyer
      @destroyers << coordinate
    end
    if coordinate == :submarine 
      @submarines << coordinate
    end
    end
    @total_ships = (@destroyers.size + @submarines.size + @battleships.size)
  end

  def destroyer_left_on_grid
    @destroyers.size
  end

  def submarine_left_on_grid
    @submarines.size
  end

  def battleships_left_on_grid
    @battleships.size
  end

end
