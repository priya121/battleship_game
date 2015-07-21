require 'battleship'

class Grid
  EMPTY = "E"
  MISS = "M"
  HIT = "H"
  SHIP = "S"

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
    first_move = player_one_move(check_ship_in_coordinate?)
    display_table(first_move)
    if first_move.to_s.include?("HIT")
      @output.puts "You sunk a battleship."
    else
      @output.puts "You missed."
    end
    player_win?(first_move)
  end

  def player_win?(first_move)
    hits = []
    first_move.each do |cell|
      if cell ==  "HIT"
        hits << cell 
      end
    end
    if hits.length == 1
      @output.puts "You sunk all the battleships."
      @output.puts "You win."
    else 
      @output.puts "Try again."
    end
  end

  def check_ship_in_coordinate?
    coordinate_guess = @input.gets.to_s
    Battleship.new(@grid,@row_label,@column_label).target(coordinate_guess)
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

  def player_one_move(guessed)
    @coordinates_after_guess = []
    guessed.each do |cell|
      coordinate_unchanged?(cell)
      coordinate_empty?(cell)
      coordinate_ship_hit?(cell)
    end
    @coordinates_after_guess
  end

  def coordinate_unchanged?(cell)
    if cell == EMPTY || cell == SHIP
      @coordinates_after_guess << "∙"
    end
  end

  def coordinate_empty?(cell)
    if cell == MISS 
      @coordinates_after_guess << "◦"
    end
  end

  def coordinate_ship_hit?(cell)
    if cell == HIT
      @coordinates_after_guess << "HIT"
    end
  end
end

