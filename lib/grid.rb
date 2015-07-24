class Grid
  EMPTY = "E"
  MISS = "M"
  HIT = "H"
  HIT_DESTROYER = "HD"
  SHIP = "S"
  DESTROYER = "D"

  attr_accessor :row_label, :column_label
  attr_reader :cells

  def initialize(cells,row_label,column_label)
    @cells = cells
    @row_label = row_label
    @column_label = column_label
  end

  def self.generate_empty_cells(rows,columns)
   @empty_grid = ''
   empty_cells =  ("E" * (rows.size * columns.size))
   @empty_grid << empty_cells
   @empty_grid.split(//)
  end

  def self.generate_grid(size)
    grid = []
    (0..size - 1). each do |cell|
      rand = [EMPTY,SHIP].sample
      grid << rand
    end
    grid
  end

  def place_ship(position)
    @cells[position] = SHIP
    @cells
  end

  def place_destroyer(position)
    @cells[position] = DESTROYER
    @cells[position+1] = DESTROYER
    @cells
  end

  def target(guess)
    column_number = guess.split(//)[1].to_i - 1
    row_letter = guess.split(//)[0]
    index_for_given_coordinate(row_letter,column_number)
  end

  def index_for_given_coordinate(row_letter,column_number)
    @row_label.each_with_index do |row,i|
      if row_letter == row
        column_number += (@column_label.length * i) 
      end
    end
     hit_or_miss(column_number)
  end

  def hit_or_miss(column_number)
    if @cells[column_number] == SHIP
       @cells[column_number] = HIT
    elsif @cells[column_number] == DESTROYER
       @cells[column_number] = HIT_DESTROYER
    elsif @cells[column_number] != SHIP || @cells[column_number] != DESTROYER
      @cells[column_number] = MISS
    end
    player_one_move(@cells)
  end

  def player_one_move(guessed)
    @coordinates_after_guess = []
    guessed.each do |cell|
      coordinate_unchanged(cell)
      coordinate_empty(cell)
      coordinate_ship_hit(cell)
    end
     @coordinates_after_guess
  end

  def coordinate_unchanged(cell)
    if cell == EMPTY || cell == SHIP || cell == DESTROYER
      @coordinates_after_guess << "∙"
    end
  end

  def coordinate_empty(cell)
    if cell == MISS 
      @coordinates_after_guess << "◦"
    end
  end

  def coordinate_ship_hit(cell)
    if cell == HIT || cell == HIT_DESTROYER
      @coordinates_after_guess << "HIT"
    end
  end

  def ships_left_in_grid
    total_ships = []
    @cells.each_with_index do |coordinate,index|
      if coordinate == "S" || coordinate == "D"
        total_ships << index
      end
    end
    total_ships.size
  end
end
