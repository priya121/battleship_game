class Battleship
  EMPTY = "E"
  MISS = "M"
  HIT = "H"
  SHIP = "S"
  attr_accessor :row_label, :column_label
  attr_reader :cells

  def initialize(cells,row_label,column_label)
    @cells = cells
    @row_label = row_label
    @column_label = column_label
  end

  def self.generate_grid(size)
    grid = []
    (0..size - 1). each do |cell|
      rand = [EMPTY,SHIP].sample
      grid << rand
    end
    grid
  end

  def place_ship(grid)
    @cells[grid] = SHIP
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
    ship_hit?(column_number)
  end

  def ship_hit?(column_number)
    if @cells[column_number] != SHIP 
      @cells[column_number] = MISS
    else @cells[column_number] == SHIP
      @cells[column_number] = HIT
    end
    @cells
  end

end
