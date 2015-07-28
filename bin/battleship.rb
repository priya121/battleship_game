#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'game'
require 'grid'

COLUMNS = ['1','2','3','4','5']
ROWS = ['A','B','C','D','E']

grid = Game.new(Kernel,["E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E"],ROWS,COLUMNS)

grid.place_ship(1)
grid.place_destroyer(7)
final_grid = grid.place_ship(3)

Grid.new(Kernel,Kernel,ROWS,COLUMNS,final_grid).start

