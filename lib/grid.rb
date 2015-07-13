require 'battleship'

class Grid
  attr_accessor :rows,:columns
  def initialize(rows,columns)
    @rows = rows
    @columns = columns
  end

  def draw_grid 
    @coordinates = []
    @coordinate = []
    @columns.each do |column|
      @rows.each do |row|
        @coordinate << row + column
      end
    end
    @coordinates << @coordinate
    @separated = @coordinate.each_slice(10).to_a
  end

  def first_column_coordinates
    draw_grid
    first_column_coordinates = @separated[0] 
  end

  def first_row_coordinates
    draw_grid
    first_row_coordinates = []
    @separated.each do |row_coordinate|
      first_row_coordinates << row_coordinate[0]
    end
    first_row_coordinates
  end
end
