#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'battleship'
require 'grid'

COLUMNS = ['1','2','3']
ROWS = ['A','B','C']

grid = Battleship.new(["E","E","E","E","E","E","E","E","E"],ROWS,COLUMNS)

grid.place_ship(2)
final_grid = grid.place_ship(3)

Grid.new(Kernel,Kernel,ROWS,COLUMNS,final_grid).start

