#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'grid'
require 'curses'

grid = Battleship.new(2,2,["E","E","E","E","E","E","E","E","E"]).place_ship(2)
COLUMNS = ['1','2','3']
ROWS = ['A','B','C']

Grid.new(Kernel,Kernel,ROWS,COLUMNS,3,grid).start

