require 'grid'

describe Grid do 
  let(:input) {StringIO.new('A2')}
  let(:output) {StringIO.new('')}
  let(:coordinates) {['∙','◦','∙','∙']}
  let(:grid) {Battleship.new(["E","E","E","E"],ROWS,COLUMNS).place_ship(1)}
  let(:table) {output.string.split("\n")}

  describe 'two by two grid' do
    COLUMNS = ['1','2']
    ROWS = ['A','B']

    it 'creates the table with coordinates' do 
      Grid.new(input,output,ROWS,COLUMNS,grid).display_table(coordinates)
      expect(table[0]).to include("1","2")
      expect(table[1]).to include("A")
    end

    it 'asks the user to guess a coordinate' do 
      Grid.new(input,output,ROWS,COLUMNS,grid).start
      expect(table[0]).to include("Guess a coordinate")
      expect(table[1]).to include("1")
    end

    it 'creates a table with y axis letters' do 
      Grid.new(input,output,ROWS,COLUMNS,grid).display_table(['∙'])
      expect(table[0]).to include("1","2")
      expect(table[1]).to include("A")
    end

    it 'creates a table with x axis numbers' do 
      Grid.new(input,output,ROWS,COLUMNS,grid).display_table(['∙'])
      expect(table[0]).to include("1","2")
      expect(table[1]).to include("∙")
    end

    it 'takes a 1d array and outputs a 2 by 2 grid' do 
      Grid.new(input,output,ROWS,COLUMNS,grid).display_table(coordinates)
      expect(table[0]).to include("1","2")
      expect(table[2]).to include("∙")
    end

    it 'displays an updated grid once a player has made a guess' do 
      grid = Battleship.new(["E","E","E","E"],ROWS,COLUMNS).place_ship(1)
      Grid.new(input,output,ROWS,COLUMNS,grid).start
      expect(table[1]).to include("1","2")
      expect(table[2]).to include("∙")
    end
    
    it 'changes empty, miss/ship or hit to coordinates' do 
      initial_grid = ["E","E","E","E"]
      player_coordinate_guess =  Battleship.new(initial_grid,ROWS,COLUMNS).target('A1')
      expect(Grid.new(input,output,ROWS,COLUMNS,grid).player_one_move(player_coordinate_guess)).to eq(["◦", "∙", "∙", "∙"])
    end
  end

  describe 'three by three grid' do 
    rows = ['A','B','C']
    columns = ['1','2','3']

    it 'displays an empty 3 by 3 grid' do 
      grid = Battleship.new(["E","E","E","E","E","E","E","E","E"],rows,columns).place_ship(1)
      Grid.new(input,output,rows,columns,grid).display_table(grid)
      expect(table[0]).to include("1","2","3")
      expect(table[1]).to include("A\t")
      expect(table[2]).to include("B\t")
      expect(table[3]).to include("C\t")
    end
  end

  describe "a game that doesn't exit until a hit has been made - " do
    rows = ['A','B','C']
    columns = ['1','2','3']

    it 'asks for another guess when miss' do 
      input = StringIO.new('A1\n')
      output = StringIO.new("")
      grid = Battleship.new(["E","E","E","E","E","E","E","E","E"],rows,columns).place_ship(1)
      Grid.new(input,output,rows,columns,grid).start
      expect(output.string).to include("You missed.")
    end

    it 'asks for another guess when miss' do 
      input = StringIO.new('B2\n')
      output = StringIO.new("")
      grid = Battleship.new(["E","E","E","E","E","E","E","E","E"],rows,columns).place_ship(4)
      Grid.new(input,output,rows,columns,grid).start
      expect(output.string).to include("You sunk my battleship.")
    end
  end
end
