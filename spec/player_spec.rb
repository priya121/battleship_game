require 'spec_helper'
require 'player'

describe Player do 
  ROWS = ['A','B','C']
  COLUMNS = ['1','2','3']

  it 'asks a player for an input' do 
    input = StringIO.new("A2\n")
    output = StringIO.new("")
    expect((Player.new(input,output,ROWS,COLUMNS)).give_coordinate).to eq(1)
  end

  it 'gives an index for a given coordinate' do
    input = StringIO.new("B1\n")
    output = StringIO.new("")
    expect(Player.new(input,output,ROWS,COLUMNS).give_coordinate).to eq(3)
  end
end
