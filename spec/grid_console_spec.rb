require 'grid_console'

describe Console do 
  describe '#display' do
    let(:input) {StringIO.new("A1\n")}
    let(:output) {StringIO.new("")}

    it 'displays an empty world' do 
      grid = Grid.new(2,2,["E","E","E","E"]).cells
      Console.new(input,output,grid,2,2).display(grid)
      expect(output.string).to eq("∙∙∙∙")
    end

    it 'displays a missed guess at A1' do 
      ship_placed= Grid.new(2,2,["E","E","E","E"]).place_ship(1)
      grid_after_guess = Grid.new(2,2,ship_placed).target('A1')
      Console.new(input,output,grid_after_guess,2,2).display(grid_after_guess)
      expect(output.string).to eq("◦∙∙∙")
    end

    it 'takes a players guess and outputs icons' do
      grid = Grid.new(2,2,["E","E","E","E"]).place_ship(1)
      Console.new(input,output,grid,2,2).player_guess
      expect(output.string).to include("◦∙∙∙")
    end

    it "asks the user to guess a coordinate" do
      grid = Grid.new(2,2,["E","E","E","E"]).place_ship(1)
      Console.new(input,output,grid,2,2).player_guess
      expect(output.string).to include("Guess a coordinate:")
    end
  end
end
