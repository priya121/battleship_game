require 'spec_helper'
require 'grid'

describe '#place_ship and place_destroyer' do 
  EMPTY = "E"

  let(:row_label) {['A','B','C','D','E','F','G']}
  let(:column_label) {['1','2','3','4','5','6','7']}
  let(:input) {StringIO.new('A1')}
  let(:initial_grid) {Grid.generate_empty_cells(row_label,column_label)}

  it 'has 0 rows and 0 columns' do 
    expect(Grid.new(input,initial_grid,row_label,column_label).cells).to eq(initial_grid)
  end

  it 'has empty 2 rows and 2 columns' do 
    expect(Grid.new(input,initial_grid,row_label,column_label).cells).to eq(initial_grid)
  end

  it 'ships are all placed on the grid' do 
    expect(Grid.new(input,initial_grid,row_label,column_label).draw_all_ships).to include(:battleship)
    expect(Grid.new(input,initial_grid,row_label,column_label).draw_all_ships).to include(:destroyer,:destroyer)
    expect(Grid.new(input,initial_grid,row_label,column_label).draw_all_ships).to include(:cruiser,:cruiser,:cruiser)
    expect(Grid.new(input,initial_grid,row_label,column_label).draw_all_ships).to include(:submarine,:submarine,:submarine)
    expect(Grid.new(input,initial_grid,row_label,column_label).draw_all_ships).to include(:aircraft_carrier, :aircraft_carrier, :aircraft_carrier, :aircraft_carrier)
  end

  it 'places all ships vertically' do 
    expect(Grid.new(input,initial_grid,row_label,column_label).draw_all_vertical_ships).to include(:battleship)
    expect(Grid.new(input,initial_grid,row_label,column_label).draw_all_vertical_ships).to include(:destroyer,:destroyer)
    expect(Grid.new(input,initial_grid,row_label,column_label).draw_all_vertical_ships).to include(:cruiser,:cruiser,:cruiser)
    expect(Grid.new(input,initial_grid,row_label,column_label).draw_all_vertical_ships).to include(:submarine,:submarine,:submarine)
    expect(Grid.new(input,initial_grid,row_label,column_label).draw_all_vertical_ships).to include(:aircraft_carrier, :aircraft_carrier, :aircraft_carrier, :aircraft_carrier)
  end

  it 're-randomizes a number if the random number generated is on the edge of the grid' do 
    random_ship_placement = Grid.new(input,initial_grid,row_label,column_label).random_index(9)
    expect(random_ship_placement% column_label.size).not_to eq(0)
  end

  it 're-randomizes a number if the random number generated is on the bottom edge of the grid' do 
    random_ship_placement = Grid.new(input,initial_grid,row_label,column_label).random_index(3)
    expect(random_ship_placement% row_label.size).not_to eq(0)
  end

  it "doesn't place a ship on the edge of a grid if half will be on the next line" do
    random_ship_placement = Grid.new(input,initial_grid,row_label,column_label).random_index(2)
    expect(random_ship_placement[0]% column_label.size).not_to eq(0)
  end

  it "doesn't place a ship on the edge of a grid if half will be on the next line" do
    random_ship_placement = random_index 
    expect(random_index).to eq(4)
  end

  describe '#target' do 
    let(:row_label) {['A','B','C']}
    let(:column_label) {['1','2','3']}
    let(:input) {StringIO.new('A2')}
    let(:initial_grid) {['E','E','E','E','E','E','E','E','E']}
    it 'changes an empty coordinate to a miss' do
      input = StringIO.new('A1')
      ship_placed = Grid.new(input,initial_grid,row_label,column_label).draw_ship(:battleship,5)
      expect(Grid.new(input,ship_placed,row_label,column_label).target(0)).to eq(["◦", "∙", "∙", 
                                                                                  "∙", "∙", "∙",                                                                                         "∙", "∙", "∙"])
    end

    it 'changes a coordinate in the first row with a ship to a hit' do 
      input = StringIO.new('A2')
      ship_placed = (Grid.new(input,initial_grid,row_label,column_label).draw_ship(:battleship,1))
      expect(Grid.new(input,initial_grid,row_label,column_label).target(1)).to eq(["∙", "HIT", "∙", 
                                                                                   "∙", "∙", "∙",                                                                                         "∙", "∙", "∙"])
    end

    it 'changes a coordinate with a ship in second row hit' do 
      input = StringIO.new('B1')
      ship_placed = (Grid.new(input,initial_grid,row_label,column_label).draw_ship(:battleship,3))
      expect(Grid.new(input,ship_placed,row_label,column_label).target(3)).to eq(["∙", "∙", "∙",                                                                                         "HIT", "∙", "∙",                                                                                       "∙", "∙", "∙"])
    end

    it 'changes a coordinate with a ship in the third row hit' do 
      row_label = ['A','B','C']
      column_label = ['1','2','3']
      ship_placed = (Grid.new(input,initial_grid,row_label,column_label).draw_ship(:battleship,4))
      expect(Grid.new(input,ship_placed,row_label,column_label).target(4)).to eq(["∙", "∙", "∙",                                                                                         "∙", "HIT", "∙",                                                                                       "∙", "∙", "∙"])
      expect(Grid.new(input,ship_placed,row_label,column_label).target(7)).to eq(["∙", "∙", "∙",                                                                                         "∙", "HIT", "∙",                                                                                       "∙", "◦", "∙"])
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

    it 'changes a coordinate when a aircraft carrier is hit' do 
      initial_grid = ["E","E","E",
                      "E","E","E",
                      "E","E","E"]
      ship_placed = (Grid.new(input,initial_grid,row_label,column_label).draw_ship(:aircraft_carrier,0))
      expect(Grid.new(input,ship_placed,row_label,column_label).target(0)).to eq(["HA", "∙", "∙",                                                                                        "∙","∙", "∙",
                                                                                  "∙", "∙","∙"])
    end

    it 'changes icon to hit once a player makes a guess' do 
      initial_grid = ["E","E","E",
                      "E","E","E",
                      "E","E","E"]
      input = StringIO.new('A2')
      new_game =  Grid.new(input,initial_grid,row_label,column_label)
      new_game.draw_ship(:battleship,1)
      result = new_game.target(1)
      expect(result).to eq(["∙","HIT","∙",
                            "∙","∙","∙",
                            "∙","∙","∙"])
    end
  end

  describe '#generate empty grid' do
    it "auto genetares an empty grid if one isn't supplied" do
      rows = ['A','B','C']
      columns = ['1','2','3']
      input = StringIO.new('A1')
      expect(Grid.generate_empty_cells(rows,columns)).to eq(["E","E","E",
                                                             "E","E","E",
                                                             "E","E","E"])
    end

    it "auto genetares an empty grid if one isn't supplied" do
      rows= ['A','B','C','D']
      columns = ['1','2','3','4']
      input = StringIO.new('A1')
      expect(Grid.generate_empty_cells(rows,columns).size).to eq(16)
    end
  end

  def draw_all_ships
    @cells = ['E','E','E',
             'E','E','E',
             'E','E','E'] 
    SHIPS.each_with_index do |(_ships,number_of_cells),index|
    index_increment = 0
    random_index_position = rand(0..cells.length)
    number_of_cells.times do |new_ship|
      cells[random_index_position + index_increment] = SHIPS.keys[index]
      index_increment += 1
    end
    end
    cells
  end

  def random_index 
    position_on_grid = 3
    check_ship_on_edge(position_on_grid)
  end
  
  def check_ship_on_edge(position_on_grid)
    @cells = ['E','E','E',
             'E','E','E',
             'E','E','E'] 
      if (position_on_grid) % 3 != 0 && (position_on_grid) % 3 != 0 && @cells[position_on_grid] == "E"
        @position = (position_on_grid)
      else
        @position = 4
        check_ship_on_edge(4)
      end
      @position
    end
end
