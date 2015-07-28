require 'grid'

class Display
  BATTLESHIP = "S"
  DESTROYER = "D"
  SUBMARINE = "Sub"
  EMPTY = "E"
  MISS = "M"
  HIT_BATTLESHIP = "H"
  HIT_DESTROYER = "HD"
  HIT_SUBMARINE = "HS"

  def initialize(cells,row_label,column_label,output)
    @cells = cells
    @row_label = row_label
    @column_label = column_label
    @output = output
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

  def player_one_move
    @coordinates_after_guess = []
    @cells.each do |cell|
      coordinate_empty(cell)
      coordinate_ship_hit(cell)
      coordinate_destroyer_hit(cell)
      coordinate_submarine_hit(cell)
      coordinate_unchanged(cell)
    end
    @coordinates_after_guess
  end

  def coordinate_empty(cell)
    if cell == MISS 
      @coordinates_after_guess << "◦"
    end
  end

  def coordinate_ship_hit(cell)
    if cell == HIT_BATTLESHIP
      @coordinates_after_guess << "HIT"
    end
  end

  def coordinate_unchanged(cell)
    if cell == EMPTY || cell == BATTLESHIP|| cell == DESTROYER|| cell == SUBMARINE
      @coordinates_after_guess << "∙"
    end
  end

  def coordinate_destroyer_hit(cell)
    if cell == HIT_DESTROYER
      @coordinates_after_guess << "HD"
    end
  end

  def coordinate_submarine_hit(cell)
    if cell == HIT_SUBMARINE
      @coordinates_after_guess << "HS"
    end
  end

end
