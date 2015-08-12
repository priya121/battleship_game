require 'spec_helper'
require 'display'

describe Display do 
  EMPTY = "E"
  ROWS = ['A','B','C','D']
  COLUMNS = ['1','2','3','4']

  let (:output) {StringIO.new('')}
  let (:table) {output.string.split("\n")}
  let (:cells) {['∙','∙','∙','∙','∙','∙','∙','∙']}
  let (:after_player_move) {[:miss,'E',:hit_battleship,'E','E','E','E','E','E']}

  it 'displays a new table' do 
    Display.new(cells,ROWS,COLUMNS,output).display_table(cells)
    expect(table[0]).to include("1","2","3")
    expect(table[1]).to include("A")
    expect(table[2]).to include("B")
    expect(table[3]).to include("C")
  end

  it 'changes the display of cells from letter to icons' do 
    grid_after_guess = Display.new(after_player_move,ROWS,COLUMNS,output).hit_made
    Display.new(cells,ROWS,COLUMNS,output).display_table(grid_after_guess)
    expect(table[0]).to include("1","2","3")
    expect(table[1]).to include("A")
    expect(table[1]).to include("∙")
  end

  describe '#hit_made' do 
    it 'changes the display of cells from letter to icons' do 
      grid_after_guess = Display.new(after_player_move,ROWS,COLUMNS,output)
      changed_symbols = Display.new(after_player_move,ROWS,COLUMNS,output).hit_made
      expect(changed_symbols).to include("HB")
      expect(changed_symbols).to include('∙')
      expect(changed_symbols).to include("◦")
    end
  end
end
