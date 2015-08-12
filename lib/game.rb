class Game
  SHIPS = {:battleship => 4,
    :destroyer => 2,
    :submarine => 3,
    :aircraft_carrier => 5,
    :cruiser => 3}

  def initialize(input,output,rows,columns,cells)
    @input = input
    @output = output
    @row_label = rows
    @column_label = columns
    @cells = cells
    @player = Player.new(@input,@output,@row_label,@column_label)
    @grid = Grid.new(@input,@cells,@row_label,@column_label) 
    @display = Display.new(@cells,@row_label,@column_label,@output)
  end

  def ask_player_guess
    @output.puts @display.display_table(@display.hit_made)
    @output.puts "Guess a coordinate:\n"
    @index_after_player_move = @player.give_coordinate
    grid_after_player_move = @grid.target(@index_after_player_move)
    @display.display_table(grid_after_player_move)
    @display.display_hit_or_miss(grid_after_player_move,@index_after_player_move)
  end


  def start
    while ships_left_on_grid? 
      ask_player_guess 
    end
      @output.puts "You sunk all the ships. You win"
    end

  private

  def ships_left_on_grid?
    @cells.any? { |c|
      SHIPS.keys.include?(c) }
  end
end
