require 'battleship'

describe Battleship do
  describe '#grid' do 
    let(:row_coordinates) {["A","B","C","D","E","F","G","H","I","J"]}
    let(:column_coordinates) {["1","2","3","4","5","6","7","8","9","10"]}

    it 'has an empty 0 by 0 grid' do
      expect(Battleship.new([],[]).draw_grid).to eq([])
    end

    it 'has a 10 rows' do 
      expect(Battleship.new(row_coordinates,column_coordinates).draw_grid.size).to eq(10)
    end

    describe '#column_coordinates' do
      it 'has 10 row coordinates labelled A1 to J1' do 
        first_row_coordinates = ["A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "A10"]
        draw_grid = Battleship.new(row_coordinates,column_coordinates)
        expect(draw_grid.first_row).to eq(first_row_coordinates)
      end
    end

    describe '#column_coordinates' do
      it 'has first column coordinates labelled A1 to A10' do 
        first_column_coordinates = ["A1", "B1", "C1", "D1", "E1", "F1", "G1", "H1", "I1", "J1"]
        expect(Battleship.new(row_coordinates,column_coordinates).first_column_coordinates).to eq(first_column_coordinates)
      end
    end

    it 'has second row coordinates labelled B1 to B10' do
      second_row_coordinates = ["B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8", "B9", "B10"]
      draw_grid = Battleship.new(row_coordinates,column_coordinates)
      expect(draw_grid.second_row).to eq(second_row_coordinates)
    end

    describe '#ship' do
      it 'randomly assigns a coordinate representing a ship on the first row, fourth column' do
        first_row = Battleship.new(row_coordinates,column_coordinates).first_row
        expect(Battleship.new(row_coordinates,column_coordinates).battleship_coordinates(first_row)).to eq("A4")
      end

      it 'assigns a ship coordinate on the third row, seventh column' do
        third_row = Battleship.new(row_coordinates,column_coordinates).third_row
        expect(Battleship.new(row_coordinates,column_coordinates).destroyer_coordinates(third_row)).to eq("C7")
      end
    end

    describe '#players' do 
      it 'removes a coordinate from all coorinates once player guesses' do
        third_row = Battleship.new(row_coordinates,column_coordinates).third_row
        amended_third_row = ["C1", "C2", "C3", "C4", "C5", "C6", "C8", "C9", "C10"]
        Battleship.new(row_coordinates,column_coordinates).destroyer_coordinates(third_row)
        expect(Battleship.new(row_coordinates,column_coordinates).player_guess("C7")).to eq(amended_third_row)
      end
    end
  end 
end
