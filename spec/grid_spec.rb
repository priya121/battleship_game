require 'grid'

describe Grid do 
  let(:input) {StringIO.new('A2')}
  let(:output) {StringIO.new('')}
  let(:coordinates) {['∙','◦','∙','∙']}
  let(:grid) {Game.new(input,["E","E","E","E"],ROWS,COLUMNS).place_ship(1)}
  let(:table) {output.string.split("\n")}

  describe 'two by two grid' do
    COLUMNS = ['1','2']
    ROWS = ['A','B']

    it 'displays a grid at the beginning of the game' do 
      Grid.new(input,output,ROWS,COLUMNS,grid).start
      expect(table[1]).to include("1","2")
      expect(table[2]).to include('A','∙')
    end

    it 'asks the user to guess a coordinate' do 
      Grid.new(input,output,ROWS,COLUMNS,grid).start
      expect(table[0]).to include("Guess a coordinate")
      expect(table[1]).to include("1","2")
    end

    it 'displays an updated grid once a player has made a guess' do 
      grid = Game.new(input,["E","E","E","E"],ROWS,COLUMNS).place_ship(1)
      Grid.new(input,output,ROWS,COLUMNS,grid).start
      expect(table[1]).to include("1","2")
      expect(table[2]).to include("∙")
    end
  end

    describe "a 3 by 3 game which doesn't exit till all hits made" do
      let(:rows) {['A','B','C']}
      let(:columns) {['1','2','3']}
      let(:grid) {Game.new(input,["E","E","E","E","E","E","E","E","E"],rows,columns)}

      it 'asks for another guess when miss' do 
        input = StringIO.new("C1\nA2\nA1")
        grid.place_ship(1)
        final_grid = grid.place_ship(0)
        Grid.new(input,output,rows,columns,final_grid).start
        expect(output.string).to include("You missed.")
      end

      it 'tells the user they sunk a battleship' do 
        input = StringIO.new("B2\n")
        grid_with_ship = Game.new(input,["E","E","E","E","E","E","E","E","E"],rows,columns).place_ship(4)
        Grid.new(input,output,rows,columns,grid_with_ship).start
        expect(output.string).to include("You sunk all the Battleships.")
      end

      it 'tells the user when they have sunk a destroyer' do 
        input = StringIO.new("A2\nA3\n")
        grid_with_ship = Game.new(input,["E","E","E","E","E","E","E","E","E"],rows,columns)
        grid_with_destroyer = grid_with_ship.place_destroyer(1)
        Grid.new(input,output,rows,columns,grid_with_destroyer).start
        expect(output.string).to include("You sunk all the Battleships. You win")
        expect(output.string).to include("You sunk a destroyer.")
      end

      it 'exits the game when all hits have been made' do 
        input = StringIO.new("B2\n")
        final_grid = grid.place_ship(4)
        Grid.new(input,output,rows,columns,final_grid).start
        expect(output.string).to include("You win")
        expect(output.string).to include("You sunk all the Battleships.")
      end
    end
  end
