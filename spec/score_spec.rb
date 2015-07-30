require 'score' 
require 'grid' 

describe Score do 
  describe '#ships_left_on_grid' do 
    let(:row_label) {['A','B']}
    let(:column_label) {['1','2']}
    let(:input) {StringIO.new('A2')}
    let(:initial_grid) {["E","E","E","E","E","E","E","E","E"]}

    it 'checks if there are any ships left on the grid' do 
      grid_with_battleship = Grid.new(input,initial_grid,row_label,column_label).draw_ship(:battleship,1)
      score = Score.new(grid_with_battleship)
      expect(score.ships_left_on_grid).to eq(true)
    end

    it 'checks if there are any destroyers left on the grid' do 
      grid_with_destroyer = Grid.new(input,initial_grid,row_label,column_label).draw_ship(:destroyer,0)
      result = Score.new(grid_with_destroyer).destroyer_coordinates_left_on_grid
      expect(result).to eq(true)
    end

    it 'counts all the battleships left on the grid' do  
      grid_with_destroyer = [:destroyer,:destroyer,"E","E","E","E","E","E","E"]
      score = Score.new(grid_with_destroyer)
      expect(score.battleship_coordinates_left_on_grid).to eq(false)
    end

    it 'checks if any subamarines are left on the grid' do 
      grid_with_submarine = [:submarine,:submarine,":submarine","E","E","E","E","E","E"]
      result = Score.new(grid_with_submarine).submarine_coordinates_left_on_grid
      expect(result).to eq(true)
    end
  end
end
