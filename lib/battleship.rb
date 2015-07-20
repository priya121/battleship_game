class Battleship
  EMPTY = "E"
  MISS = "M"
  HIT = "H"
  SHIP = "S"
  attr_accessor :rows,:columns
  attr_reader :cells

  def initialize(cells)
    @cells = cells
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
    if  cell == EMPTY || cell == SHIP
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

  def target(guess)
    index = guess.split(//)[1].to_i - 1
    if @cells[index] != SHIP
      @cells[index] = MISS
    elsif @cells[index] == SHIP
      @cells[index] = HIT
    end
    @cells
  end
end

