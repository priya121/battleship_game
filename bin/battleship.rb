#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'game'
require 'grid'

COLUMNS = ['1','2','3','4','5']
ROWS = ['A','B','C','D','E']
cells = ["E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E"]

changed_cells = Display.new(cells,ROWS,COLUMNS,Kernel).draw_ship(:aircraft_carrier,0)

Game.new(Kernel,Kernel,ROWS,COLUMNS,changed_cells).start

