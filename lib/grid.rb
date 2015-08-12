require 'player'
require 'display'

class Grid
  SHIPS = {:battleship => 4,
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

  def draw_all_ships
    SHIPS.each_with_index do |(_ship,number_of_cells),index|
    index_increment = 0
    random_index_position = random_index(number_of_cells)
    number_of_cells.times do |new_ship|
      @cells[random_index_position + index_increment] = SHIPS.keys[index]
      index_increment += 1
    end
    end
    @cells
  end

  def draw_all_vertical_ships
    SHIPS.each_with_index do |(_ship,number_of_cells),index|
    index_increment = 0
    random_index_position = random_index(number_of_cells)
    number_of_cells.times do |new_ship|
      @cells[random_index_position + index_increment] = SHIPS.keys[index]
      index_increment += @column_label.size
    end
    end
    @cells
  end

  def vertical_or_horizontal
      index_increment += 
        [@column_label.size, 1].sample(1)
  end

  def draw_ship(ship,position)
    SHIPS.each_with_index do |(draw_ship,number_of_cells),index|
    if ship == draw_ship
      index_increment = 0
      number_of_cells.times do |new_ship|
        @cells[position + (index_increment)] = SHIPS.keys[index]
        index_increment += 1 
      end
    end
    end
    @cells
  end

  def draw_all_vertical_ships
    SHIPS.each_with_index do |(_ships,number_of_cells),index|
    index_increment = 0
    random_index_position = random_index(number_of_cells)
    number_of_cells.times do |new_ship|
      @cells[random_index_position + index_increment] = SHIPS.keys[index]
      index_increment += @column_label.size
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
    elsif  @cells[column_number] == SHIPS.keys[3]
      @cells[column_number] = :hit_aircraft_carrier 
    elsif  @cells[column_number] == SHIPS.keys[4]
      @cells[column_number] = :hit_cruiser 
    elsif @cells[column_number] != SHIPS.keys[0]|| @cells[column_number] != SHIPS.keys[1] || @cells[column_number] != SHIPS.keys[2] || @cells[column_number] !=SHIPS.key[3]
      @cells[column_number] = :miss
    end
    Display.new(@cells,@row_label,@column_label,@output).player_one_move
  end

  def random_index(number_of_cells)
    position_on_grid = rand(0..@cells.size)
    if check_all_positions_available(position_on_grid,number_of_cells) 
      @position = position_on_grid
    else
      random_index(number_of_cells)
    end
  end

  def check_all_positions_available(position_on_grid,number_of_cells)
    increment = 0
    number_of_cells.times do 
      if position_available(position_on_grid + increment) 
      else
        return false
      end
      increment += 1
    end
    true
  end

  def position_available(position_on_grid)
    width = @column_label.size
    height = width
    on_the_edge = (position_on_grid) % width == 0 
    on_the_bottom = (position_on_grid) % height == 0
    !on_the_edge && !on_the_bottom && @cells[position_on_grid] == "E"
  end
end
