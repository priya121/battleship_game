class Grid
  attr_accessor :rows,:columns
  attr_reader :cells
  def initialize(rows,columns,cells)
    @rows = rows
    @columns = columns
    @cells = cells
  end

  def self.generate_grid(size)
    grid = []
    (0..size - 1). each do |cell|
      rand = ["E","S"].sample
      grid << rand
    end
    grid
  end

  def self.random_grid(width,height)
    cells = generate_grid(width*height)
    grid = Grid.new(width,height,cells)
    return grid
  end

  def place_ship(grid)
    @cells[grid] = "S"
    @cells
  end

  def target(guess)
    index = guess.split(//)[1].to_i - 1
    if @cells[index] != "S" 
      @cells[index] = "M"
    elsif @cells[index] == "S"
      @cells[index] = "H"
    end
    @cells
  end
end

