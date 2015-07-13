class Battleship
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

  def generate_row_coordinates
    draw_grid
    @first_row  = []
    @second_row = []
    @third_row = []
    @separated.each do |row_coordinates|
      @first_row << row_coordinates[0]
      @second_row << row_coordinates[1]
      @third_row << row_coordinates[2]
    end
  end

  def first_row
    generate_row_coordinates
    @first_row
  end

  def second_row
    generate_row_coordinates
    @second_row 
  end

  def third_row 
    generate_row_coordinates
    @third_row
  end

  def battleship_coordinates(first_row)
    @battleship = first_row[3] 
  end

  def destroyer_coordinates(third_row)
    @destroyer = third_row[6]
  end

  def player_guess(guess)
     if guess == destroyer_coordinates(third_row)
      guess.split(//).inspect
      column = guess[1].to_i - 1
      row = third_row
      removed_coordinate = row.delete_at(column)
    end
     row
  end

end
