require 'curses'
require 'grid'

class Console
  def initialize(input,output,grid,height,width,screen)
    @input = input
    @output = output
    @grid = grid
    @height = height
    @width = width
    @screen = screen
  end

  def player_guess
    guess = @input.gets
    guessed = Grid.new(2,2,@grid).target(guess)
    display(guessed)
  end

  def display(guessed)
    guessed.each_with_index do |cell,index|
    if (index)% @width == 0
      @output.puts "\n"
    end
        if cell == "E"
          @output.print"∙"
        elsif cell == "M"
          @output.print "◦"
        elsif cell == "S"
          @output.print "🚢"
        end
      end
  end

  def run

  end


end
