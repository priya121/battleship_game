require 'player'

describe Player do 
  ROWS = ['A','B','C']
  COLUMNS = ['1','2','3']

  it 'asks a player for an input' do 
    input = StringIO.new('A2')
    expect((Player.new(input,ROWS,COLUMNS)).give_coordinate).to eq(1)
  end

  it 'gives an index for a given coordinate' do
    input = StringIO.new('B1')
    expect(Player.new(input,ROWS,COLUMNS).give_coordinate).to eq(3)
  end
end
