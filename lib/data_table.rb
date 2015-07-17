require 'battleship'

class Grid
  def initialize(input,output,rows,columns,width,grid)
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
    first_move = (Battleship.new(2,2,@grid).player_one_move(check_ship_in_coordinate?))
    display_table(first_move)
  end

  def check_ship_in_coordinate?
    coordinate_guess = @input.gets
    Battleship.new(2,2,@grid).target(coordinate_guess)
  end

  def display_table(cells)
    @output.print "\t"
    @column_label.each do |number|
      @output.print number.center(7)
    end
    @output.puts "\n"
    @output.print @row_label[0]
    cells.each_with_index do |cell, index|
      @output.print "\t"
      @output.print cell.center(6)
      if last_cell_in_row?(index)
        @output.puts "\s"
        @output.print row_label_for_cell(index)
      end
    end
    @output.puts "\n"
  end

  def row_label_for_cell(index)
    row_label_index = ((index + 1) / @column_label.size) 
    @row_label[row_label_index]
  end

  def last_cell_in_row?(index)
    (index + 1) % @column_label.size == 0
  end
end

