class Score

  def initialize(cells)
    @cells = cells
  end

  def ships_left_on_grid
    if destroyer_coordinates_left_on_grid == true || submarine_coordinates_left_on_grid == true || battleship_coordinates_left_on_grid == true || aircraft_carrier_coordinates_left_on_grid == true || cruiser_coordinates_left_on_grid == true 
      @total_cells = true
    else
      @total_cells = false
    end
  end

  def cruiser_coordinates_left_on_grid
    if @cells.include?(:cruiser)
      true
    else
      false
    end
  end

  def aircraft_carrier_coordinates_left_on_grid
    if @cells.include?(:aircraft_carrier)
      true
    else
      false
    end
  end

  def aircraft_carrier_coordinates_left_on_grid
    if @cells.include?(:aircraft_carrier)
      true
    else
      false
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

