#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'game'
require 'grid'

COLUMNS = ['1','2','3','4','5']
ROWS = ['A','B','C','D','E']
cells = ["E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E"]

Grid.new(Kernel,cells,ROWS,COLUMNS).draw_vertical_ship(:submarine,0)
Grid.new(Kernel,cells,ROWS,COLUMNS).draw_ship(:battleship,20)
changed_cells = Grid.new(Kernel,cells,ROWS,COLUMNS).draw_ship(:destroyer,11)

Game.new(Kernel,Kernel,ROWS,COLUMNS,changed_cells).start

