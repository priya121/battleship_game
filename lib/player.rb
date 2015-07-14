require 'battleship'
require 'grid'

class Player
  attr_accessor :guess
  def initialize(guess,ship_coordinate)
    @ship_coordinate = ship_coordinate
    @guess = guess
  end

end

