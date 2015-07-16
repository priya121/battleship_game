require 'curses'
require 'grid'

class Console
  def initialize(input,output,grid,height,width)
    @input = input
    @output = output
    @grid = grid
    @height = height
    @width = width
  end

  def player_guess
    @output.puts "Guess a coordinate:\n"
    guess = @input.gets
    display(Grid.new(2,2,@grid).target(guess))
  end

  def display(guessed)
    guessed.each_with_index do |cell,index|
      if cell == "E" || cell == "S"
        @output.print"∙"
      elsif cell == "M"
        @output.print "◦"
      elsif cell == "H"
        @output.print "HIT"
      end
    end
  end

end
