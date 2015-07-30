class Score

  def initialize(cells)
    @cells = cells
  end

  def ships_left_on_grid
    if destroyer_coordinates_left_on_grid == true || submarine_coordinates_left_on_grid == true || battleship_coordinates_left_on_grid == true 
      @total_cells = true
    else
      @total_cells = false
    end
  end

  def destroyer_coordinates_left_on_grid
    if @cells.include?(:destroyer)
      true
    else
      false
    end
  end

  def submarine_coordinates_left_on_grid
    if @cells.include?(:submarine)
      true
    else
      false
    end
  end

  def battleship_coordinates_left_on_grid
    if @cells.include?(:battleship)
      true
    else
      false
    end
  end

end
