require 'battleship'

describe Battleship  do 
  EMPTY = "E"
  MISS = "M"
  HIT = "H"
  SHIP = "S"
  initial_grid = [EMPTY,EMPTY,EMPTY,EMPTY]
  grid_ship_placed = [EMPTY,EMPTY,SHIP,EMPTY]
  
  let(:row_label) {['A','B']}
  let(:column_label) {['1','2']}

  describe '#target' do 
    it 'has 0 rows and 0 columns' do 
      expect(Battleship.new(initial_grid,row_label,column_label).cells).to eq(initial_grid)
    end

    it 'has empty 2 rows and 2 columns' do 
      expect(Battleship.new(initial_grid,row_label,column_label).cells).to eq(initial_grid)
    end

    it 'has 1 ship as a coordinate' do 
      expect(Battleship.new(initial_grid,row_label,column_label).place_ship(2)).to eq(grid_ship_placed)
    end

    it 'changes an empty coordinate to a miss' do
      initial_grid = ["E","E","E","E"]
      ship_placed = (Battleship.new(initial_grid,row_label,column_label).place_ship(1))
      expect(Battleship.new(ship_placed,row_label,column_label).target('A1')).to eq(["M","S","E","E"])
      expect(Battleship.new(ship_placed,row_label,column_label).target('A2')).to eq(["M","H","E","E"])
    end

    it 'changes a coordinate in the first row with a ship to a hit' do 
      initial_grid = ["E","E","E","E"]
      ship_placed = (Battleship.new(initial_grid,row_label,column_label).place_ship(1))
      expect(Battleship.new(ship_placed,row_label,column_label).target('A2')).to eq(["E","H","E","E"])
    end

    it 'changes a coordinate with a ship in second row hit' do 
      initial_grid = ["E","E","E","E"]
      ship_placed = (Battleship.new(initial_grid,row_label,column_label).place_ship(3))
      expect(Battleship.new(ship_placed,row_label,column_label).target('B2')).to eq(["E","E","E","H"])
    end

    it 'changes a coordinate with a ship in the third row hit' do 
      row_label = ['A','B','C']
      column_label = ['1','2','3']
      initial_grid = ["E","E","E","E","E","E","E","E","E"]
      ship_placed = (Battleship.new(initial_grid,row_label,column_label).place_ship(3))
      expect(Battleship.new(ship_placed,row_label,column_label).target('B2')).to eq(["E","E","E","S","M","E","E","E","E"])
      expect(Battleship.new(ship_placed,row_label,column_label).target('C2')).to eq(["E","E","E","S","M","E","E","M","E"])
    end

    it 'generates 4 random cells' do 
     grid = Battleship.generate_grid(4) 
     expect(grid.size).to eq(4)
    end

    it 'generates 10 random cells' do 
     grid = Battleship.generate_grid(10) 
     expect(grid.size).to eq(10)
    end
  end
end
