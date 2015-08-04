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

  def draw_all_ships
    SHIPS.each_with_index do |(_ships,number_of_cells),index|
    index_increment = 0
    random_index_position = random_index
    number_of_cells.times do |new_ship|
      @cells[random_index_position + index_increment] = SHIPS.keys[index]
      index_increment += 1
    end
    end
    @cells
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

  def draw_vertical_ship(ship,position)
    SHIPS.each_with_index do |(draw_ship,number_of_cells),index|
    if ship == draw_ship
      i = position 
      number_of_cells.times do |new_ship|
        @cells[(i)] = SHIPS.keys[index]
        i += @column_label.size 
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

  def random_index
    position_on_grid = rand(0..@cells.size)
    new_position = check_ship_not_in_position(position_on_grid)
    check_ship_on_edge(new_position)
  end

  def check_ship_on_edge(position_on_grid)
    if position_on_grid  % @column_label.size == 0
      position = position_on_grid
    else 
      position = rand(0..@cells.size)
      check_ship_on_edge(position)
    end
    position
  end

  def check_ship_not_in_position(position_on_grid)
    if @cells[position_on_grid]..@cells[position_on_grid + 5] == "E"
      position = position_on_grid 
      puts position
    else
      position = rand(0..@cells.size)
      check_ship_not_in_position(position)
    end
    position
  end
end
