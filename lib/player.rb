require 'battleship'
require 'grid'

class Player
  attr_accessor :guess
  def initialize(guess,ship_coordinate)
    @ship_coordinate = ship_coordinate
    @guess = guess
  end

  def player_guesses_coordinate(guess)
    hit = []
   if @guess == @ship_coordinate
    hit << @ship_coordinate  

   end
  end

end

