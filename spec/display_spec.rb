require 'display'

describe Display do 
  
EMPTY = "E"
ROWS = ['A','B','C','D']
COLUMNS = ['1','2','3','4']

  let (:output) {StringIO.new('')}
  let (:table) {output.string.split("\n")}
  let (:cells) {['∙','∙','∙','∙','∙','∙','∙','∙']}
  let (:after_player_move) {['M','E','∙','∙','∙','∙','∙','∙']}

  it 'displays a new table' do 
    Display.new(cells,ROWS,COLUMNS,output).display_table(cells)
    expect(table[0]).to include("1","2","3")
    expect(table[1]).to include("A")
    expect(table[2]).to include("B")
    expect(table[3]).to include("C")
  end

  it 'changes the display of cells from letter to icons' do 
    grid_after_guess = Display.new(after_player_move,ROWS,COLUMNS,output).player_one_move
    Display.new(cells,ROWS,COLUMNS,output).display_table(grid_after_guess)
    expect(table[0]).to include("1","2","3")
    expect(table[1]).to include("A")
    expect(table[1]).to include("∙")
  end

    it 'draws a ship depending on which ship is passed to it' do
      initial_grid = [EMPTY,EMPTY,EMPTY,EMPTY]
      expect(Display.new(initial_grid,ROWS,COLUMNS,output).draw_ship(:destroyer,0)).to eq(["S","S","E","E"])
    end

    it 'draws a ship depending on which ship is passed to it' do
      initial_grid = [EMPTY,EMPTY,EMPTY,EMPTY]
      expect(Display.new(initial_grid,ROWS,COLUMNS,output).draw_ship(:submarine,1)).to eq(["E","S","S","S"])
    end
end
