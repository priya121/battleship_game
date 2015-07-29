require 'game'

describe Grid  do 
  EMPTY = "E"

  describe '#place_ship and place_destroyer' do 
    initial_grid = [EMPTY,EMPTY,EMPTY,EMPTY]
    grid_ship_placed = [EMPTY,EMPTY,:battleship,EMPTY]

    let(:row_label) {['A','B']}
    let(:column_label) {['1','2']}
    let(:input) {StringIO.new('A1')}

    it 'has 0 rows and 0 columns' do 
      expect(Grid.new(input,initial_grid,row_label,column_label).cells).to eq(initial_grid)
    end

    it 'has empty 2 rows and 2 columns' do 
      expect(Grid.new(input,initial_grid,row_label,column_label).cells).to eq(initial_grid)
    end

    it 'has 1 ship as a coordinate' do 
      expect(Grid.new(input,initial_grid,row_label,column_label).draw_ship(:battleship,2)).to eq(grid_ship_placed)
    end

    it 'draws a ship depending on which ship is passed to it' do
      initial_grid = [EMPTY,EMPTY,EMPTY,EMPTY]
      expect(Grid.new(input,initial_grid,row_label,column_label).draw_ship(:destroyer,0)).to eq([:destroyer,:destroyer,"E","E"])
    end

    it 'draws a ship depending on which ship is passed to it' do
      initial_grid = [EMPTY,EMPTY,EMPTY,EMPTY]
      expect(Grid.new(input,initial_grid,row_label,column_label).draw_ship(:submarine,1)).to eq(["E",:submarine,:submarine,:submarine])
    end

    describe '#target' do 
      let(:row_label) {['A','B']}
      let(:column_label) {['1','2']}
      let(:input) {StringIO.new('A2')}

      it 'changes an empty coordinate to a miss' do
        initial_grid = ["E","E","E","E"]
        input = StringIO.new('A1')
        ship_placed = (Grid.new(input,initial_grid,row_label,column_label).draw_ship(:battleship,1))
        expect(Grid.new(input,ship_placed,row_label,column_label).target(0)).to eq(["◦", "∙", "∙", "∙"])
      end

      it 'changes a coordinate in the first row with a ship to a hit' do 
        input = StringIO.new('A2')
        initial_grid = ["E","E","E","E"]
        ship_placed = (Grid.new(input,initial_grid,row_label,column_label).draw_ship(:battleship,1))
        expect(Grid.new(input,initial_grid,row_label,column_label).target(1)).to eq(["∙", "HIT", "∙", "∙"])
      end

      it 'changes a coordinate with a ship in second row hit' do 
        input = StringIO.new('B1')
        initial_grid = ["E","E","E","E"]
        ship_placed = (Grid.new(input,initial_grid,row_label,column_label).draw_ship(:battleship,3))
        expect(Grid.new(input,ship_placed,row_label,column_label).target(3)).to eq(["∙", "∙", "∙", "HIT"])
      end

      it 'changes a coordinate with a ship in the third row hit' do 
        row_label = ['A','B','C']
        column_label = ['1','2','3']
        initial_grid = ["E","E","E","E","E","E","E","E","E"]
        ship_placed = (Grid.new(input,initial_grid,row_label,column_label).draw_ship(:battleship,1))
        expect(Grid.new(input,ship_placed,row_label,column_label).target(4)).to eq(["∙", "∙", "∙", "∙", "◦", "∙", "∙", "∙", "∙"])
        expect(Grid.new(input,ship_placed,row_label,column_label).target(7)).to eq(["∙", "∙", "∙", "∙", "◦", "∙", "∙", "◦", "∙"])

      end

      it 'changes a coordinate when a destroyer is hit' do 
        initial_grid = ["E","E","E","E"]
        ship_placed = (Grid.new(input,initial_grid,row_label,column_label).draw_ship(:destroyer,1))
        expect(Grid.new(input,ship_placed,row_label,column_label).target(1)).to eq(["∙", "HD", "∙", "∙"])
        expect(Grid.new(input,ship_placed,row_label,column_label).target(0)).to eq(["◦", "HD", "∙", "∙"])
      end

      it 'changes a coordinate when a submarine is hit' do 
        initial_grid = ["E","E","E","E"]
        ship_placed = (Grid.new(input,initial_grid,row_label,column_label).draw_ship(:submarine,0))
        expect(Grid.new(input,ship_placed,row_label,column_label).target(0)).to eq(["HS", "∙", "∙", "∙"])
        expect(Grid.new(input,ship_placed,row_label,column_label).target(1)).to eq(["HS", "HS", "∙", "∙"])
        expect(Grid.new(input,ship_placed,row_label,column_label).target(2)).to eq(["HS", "HS", "HS", "∙"])
      end

      it 'changes icon to hit once a player makes a guess' do 
        initial_grid = ["E","E","E","E","E","E","E","E","E"]
        input = StringIO.new('A2')
        new_game =  Grid.new(input,initial_grid,row_label,column_label)
        new_game.draw_ship(:battleship,1)
        result = new_game.target(1)
        expect(result).to eq(["∙","HIT","∙","∙","∙","∙","∙","∙","∙"])
      end
    end

    describe '#ships_left_on_grid' do 
      let(:row_label) {['A','B']}
      let(:column_label) {['1','2']}
      let(:input) {StringIO.new('A2')}

      it 'counts all the ships left on the grid' do 
        grid_with_battleship = Grid.new(input,initial_grid,row_label,column_label).draw_ship(:battleship,1)
        grid = Grid.new(input,grid_with_battleship,row_label,column_label)
        expect(grid.ships_left_on_grid).to eq(1)
      end
      
      it 'counts all the destroyers left on the grid' do 
        grid_with_destroyer = Grid.new(input,initial_grid,row_label,column_label).draw_ship(:destroyer,0)
        result = Grid.new(input,grid_with_destroyer,row_label,column_label).ships_left_on_grid
        destroyers = Grid.new(input,grid_with_destroyer,row_label,column_label).destroyer_coordinates_left_on_grid
        expect(result).to eq(2)
        expect(destroyers).to eq(2)
      end
  
      it 'counts all the battleships left on the grid' do  
        grid_with_destroyer = Grid.new(input,initial_grid,row_label,column_label).draw_ship(:battleship,0)
        result = Grid.new(input,grid_with_destroyer,row_label,column_label).ships_left_on_grid
        expect(result).to eq(2)
      end
    end

    describe '#generate_grid and #generate empty grid' do
      it 'generates 4 random cells' do 
        grid = Grid.generate_grid(4) 
        expect(grid.size).to eq(4)
      end

      it 'generates 10 random cells' do 
        grid = Grid.generate_grid(10) 
        expect(grid.size).to eq(10)
      end

      it "auto genetares an empty grid if one isn't supplied" do
        ROWS= ['A','B','C']
        COLUMNS = ['1','2','3']
        input = StringIO.new('A1')
        expect(Grid.generate_empty_cells(ROWS,COLUMNS)).to eq(["E","E","E","E","E","E","E","E","E"])
      end
    end
  end
end
