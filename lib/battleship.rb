class Battleship
  EMPTY = "E"
  MISS = "M"
  HIT = "H"
  SHIP = "S"
  DESTROYER = "D"

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

  def place_destroyer(grid)
    @cells[grid]  = DESTROYER
    @cells[grid+1] = DESTROYER
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
     hit_or_miss?(column_number)
  end

  def hit_or_miss?(column_number)
    if @cells[column_number] == SHIP || @cells[column_number] == DESTROYER
      @cells[column_number] = HIT
    elsif @cells[column_number] != SHIP || @cells[column_number] != DESTROYER
      @cells[column_number] = MISS
    end
    @cells
  end

end

