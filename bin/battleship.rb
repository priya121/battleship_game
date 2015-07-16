#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'data_table'
require 'curses'

grid = Grid.new(2,2,["E","E","E","E"]).place_ship(1)
COLUMNS = ['1','2']
ROWS = ['A','B']

Table.new(Kernel,Kernel,ROWS,COLUMNS,2,grid).player_guess

