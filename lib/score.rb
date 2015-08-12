class Score

  def initialize(cells)
    @cells = cells
  end

  def ships_left_on_grid?
    if destroyer_coordinates_left_on_grid == true || submarine_coordinates_left_on_grid == true || battleship_coordinates_left_on_grid == true || aircraft_carrier_coordinates_left_on_grid == true || cruiser_coordinates_left_on_grid == true 
    else
      false
    end
  end

  def cruiser_coordinates_left_on_grid
    @cells.include?(:cruiser)
  end

  def aircraft_carrier_coordinates_left_on_grid
    @cells.include?(:aircraft_carrier)
  end

  def destroyer_coordinates_left_on_grid
   @cells.include?(:destroyer)
  end

  def submarine_coordinates_left_on_grid
    @cells.include?(:submarine)
  end

  def battleship_coordinates_left_on_grid
   @cells.include?(:battleship)
  end

end
