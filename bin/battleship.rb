#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'grid_console'
require 'curses'

grid = Grid.new(2,2,["E","E","E","E"]).place_ship(3)

Console.new(Kernel,Kernel,grid,2,2).player_guess

