#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'grid_console'
require 'curses'

Curses.init_screen
Curses.curs_set 0

grid = Grid.new(2,2,["E","S","E","E"])


Console.new(Kernel,Kernel,grid,2,2,Curses).player_guess

