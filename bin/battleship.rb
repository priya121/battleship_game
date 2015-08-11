#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'game'
require 'grid'

COLUMNS = ['1','2','3','4','5','6','7','8','9','10']
ROWS = ['A','B','C','D','E','F','G','H','I','J']

cells = Grid.generate_empty_cells(ROWS,COLUMNS)
changed_cells = Grid.new(Kernel,cells,ROWS,COLUMNS).draw_all_vertical_ships

Game.new(Kernel,Kernel,ROWS,COLUMNS,changed_cells).start
