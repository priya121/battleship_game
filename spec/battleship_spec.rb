require 'battleship'

describe Battleship  do 
  EMPTY = "E"
  MISS = "M"
  HIT = "H"
  SHIP = "S"
  initial_grid = [EMPTY,EMPTY,EMPTY,EMPTY]
  grid_ship_placed = [EMPTY,EMPTY,SHIP,EMPTY]

  describe '#target' do 
    it 'has 0 rows and 0 columns' do 
      expect(Battleship.new(initial_grid).cells).to eq(initial_grid)
    end

    it 'has empty 2 rows and 2 columns' do 
      expect(Battleship.new(initial_grid).cells).to eq(initial_grid)
    end

    it 'has 1 ship as a coordinate' do 
      expect(Battleship.new(initial_grid).place_ship(2)).to eq(grid_ship_placed)
    end

    it 'changes an empty coordinate to a miss' do
      initial_grid = ["E","E","E","E"]
      ship_placed = (Battleship.new(initial_grid).place_ship(1))
      expect(Battleship.new(ship_placed).target('A1')).to eq(["M","S","E","E"])
      expect(Battleship.new(ship_placed).target('A3')).to eq(["M","S","M","E"])
    end

    it 'changes a coordinate with a ship to a hit' do 
      initial_grid = ["E","E","E","E"]
      ship_placed = (Battleship.new(initial_grid).place_ship(1))
      expect(Battleship.new(ship_placed).target('A2')).to eq(["E","H","E","E"])
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
