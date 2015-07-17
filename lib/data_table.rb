require 'grid'

class Table
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
    guess = @input.gets
    @output.puts display_table(Grid.new(2,2,@grid).player_one_move(Grid.new(2,2,@grid).target(guess)))
  end

  def display_table(cells)
    @output.print "\t"
    @column_label.each do |number|
      @output.print number.ljust(24)
    end
    @output.puts "\n"
    @output.print @row_label[0]
    cells.each_with_index do |cell, index|
      @output.print "\t"
      @output.print cell.ljust(20)
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

