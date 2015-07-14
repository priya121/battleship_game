require 'grid'

describe Grid do 
  initial_grid = ["E","E","E","E"]

  describe '#target' do 
    it 'has 0 rows and 0 columns' do 
      expect(Grid.new(0,0,initial_grid).cells).to eq(["E","E","E","E"])
    end

    it 'has empty 2 rows and 2 columns' do 
      expect(Grid.new(2,2,initial_grid).cells).to eq(["E","E","E","E"])
    end

    it 'has 1 ship as a coordinate' do 
      expect(Grid.new(2,2,initial_grid).place_ship(2)).to eq(["E","E","S","E"])
    end

    it 'changes an empty coordinate to a miss' do
      initial_grid = ["E","E","E","E"]
      ship_placed = (Grid.new(2,2,initial_grid).place_ship(1))
      expect(Grid.new(2,2,ship_placed).target('A1')).to eq(["M","S","E","E"])
      expect(Grid.new(2,2,ship_placed).target('A3')).to eq(["M","S","M","E"])
    end

    it 'changes a coordinate with a ship to a hit' do 
      initial_grid = ["E","E","E","E"]
      ship_placed = (Grid.new(2,2,initial_grid).place_ship(1))
      expect(Grid.new(2,2,ship_placed).target('A2')).to eq(["E","H","E","E"])
    end
  end
end
