require 'battleship'

class Grid
  def initialize(input,output,rows,columns,grid)
    @input = input
    @output = output
    @row_label = rows
    @column_label = columns
    @grid = grid
  end

  def start
    @output.puts "Guess a coordinate:\n"
    player_guess
  end

  def player_guess
    first_move = (Battleship.new(@grid).player_one_move(check_ship_in_coordinate?))
    display_table(first_move)
  end

  def check_ship_in_coordinate?
    coordinate_guess = @input.gets
    Battleship.new(@grid).target(coordinate_guess)
  end

  def display_table(cells)
    display_columns
    display_rows(cells)
    @output.puts "\n"
  end

  def display_columns
    @output.print "\t"
    @column_label.each do |number|
      @output.print number.center(7)
    end
    @output.puts "\n"
  end

  def display_rows(cells)
    @output.print @row_label[0]
    cells.each_with_index do |cell, index|
      @output.print "\t"
      @output.print cell.center(5)
      new_row?(index)
    end
  end

  def new_row?(index)
      if last_cell_in_row?(index)
        @output.puts "\s"
        @output.print row_label_for_cell(index)
      end
  end

  def last_cell_in_row?(index)
    (index + 1) % @column_label.size == 0
  end

  def row_label_for_cell(index)
    row_label_index = ((index + 1) / @column_label.size) 
    @row_label[row_label_index]
  end

end

