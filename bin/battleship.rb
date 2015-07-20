#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'battleship'
require 'grid'

COLUMNS = ['1','2','3']
ROWS = ['A','B','C']

grid = Battleship.new(["E","E","E","E","E","E","E","E","E"],ROWS,COLUMNS).place_ship(2)

Grid.new(Kernel,Kernel,ROWS,COLUMNS,grid).start

