require 'grid'

class Table
  def initialize(input,output,rows,columns,width,grid)
    @input = input
    @output = output
    @row_label = rows
    @column_label = columns
    @width = width
    @grid = grid
  end

  def player_guess
    @output.puts "Guess a coordinate:\n"
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
    cells.each_with_index do |row, index|
      @output.print "\t"
      @output.print row.ljust(20)
      if (index+1)% @column_label.size == 0
        @output.puts "\s"
        @output.print @row_label[@column_label.size-index]
      end
    end
    @output.puts "\n"
  end
end

