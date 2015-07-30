require 'game'

describe Game do 
  ROWS = ['A','B','C']
  COLUMNS = ['1','2','3']

  let(:input) {StringIO.new('A2')}
  let(:output) {StringIO.new('')}
  let(:coordinates) {['∙','◦','∙','∙']}
  let(:grid) {Grid.new(input,["E","E","E","E"],ROWS,COLUMNS).draw_ship(:battleship,1)}
  let(:table) {output.string.split("\n")}

  describe 'two by two grid' do
    it 'displays a grid at the beginning of the game' do 
      Game.new(input,output,ROWS,COLUMNS,grid).start
      expect(table[1]).to include("1","2")
      expect(table[2]).to include('A','∙')
    end

    it 'asks the user to guess a coordinate' do 
      Game.new(input,output,ROWS,COLUMNS,grid).start
      expect(table[0]).to include("Guess a coordinate")
      expect(table[1]).to include("1","2")
    end

    it 'displays an updated grid once a player has made a guess' do 
      grid = Grid.new(input,["E","E","E","E"],ROWS,COLUMNS).draw_ship(:battleship,1)
      Game.new(input,output,ROWS,COLUMNS,grid).start
      expect(table[1]).to include("1","2")
      expect(table[2]).to include("∙")
    end
  end

    describe "a 3 by 3 game which doesn't exit till all hits made" do
      let(:rows) {['A','B','C']}
      let(:columns) {['1','2','3']}
      let(:grid) {Grid.new(input,["E","E","E","E","E","E","E","E","E"],rows,columns)}

      it 'asks for another guess when miss' do 
        input = StringIO.new("C1\nA2\nA1")
        grid.draw_ship(:battleship,1)
        final_grid = grid.draw_ship(:battleship,0)
        Game.new(input,output,rows,columns,final_grid).start
        expect(output.string).to include("You missed.")
      end

      it 'tells the user they sunk a battleship' do 
        input = StringIO.new("B2\n")
        grid_with_ship = Grid.new(input,["E","E","E","E","E","E","E","E","E"],rows,columns).draw_ship(:battleship,4)
        Game.new(input,output,rows,columns,grid_with_ship).start
        expect(output.string).to include("You sunk all the ships.")
      end

      it 'tells the user when they have sunk a destroyer' do 
        input = StringIO.new("A2\nA3\n")
        grid_with_ship = Grid.new(input,["E","E","E","E","E","E","E","E","E"],rows,columns)
        grid_with_destroyer = grid_with_ship.draw_ship(:destroyer,1)
        Game.new(input,output,rows,columns,grid_with_destroyer).start
        expect(output.string).to include("You sunk all the ships. You win")
        expect(output.string).to include("You sunk a destroyer.")
      end

      it 'exits the game when all hits have been made' do 
        input = StringIO.new("B2\n")
        final_grid = grid.draw_ship(:battleship,4)
        Game.new(input,output,rows,columns,final_grid).start
        expect(output.string).to include("You win")
        expect(output.string).to include("You sunk all the ships.")
      end
    end
  end
