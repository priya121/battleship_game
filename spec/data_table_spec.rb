require 'data_table'

describe Table do 
  let(:output) {StringIO.new('')}
  let(:input) {}
    COLUMNS = ['1','2','3']
    ROWS = ['A','B','C']

  it 'creates an empty table' do
    grid = Table.new(output,0,0,ROWS,COLUMNS).table_grid(1,1)
    expect(grid).to eq([[]])
  end

  it 'creates the table with coordinates' do 
    Table.new(output,1,1,ROWS,COLUMNS).display_grid(['∙'])
    expect(output.string).to include("[\"∙\"]")
  end

  it 'creates a table with y axis letters' do 
    Table.new(output,2,2,ROWS,COLUMNS).display_grid('∙')
    expect(output.string).to include("A\t[\"∙\", \"∙\"]\n")
  end

  it 'creates a table with x axis numbers' do 
    Table.new(output,2,2,ROWS,COLUMNS).display_grid('∙')
    expect(output.string).to include("[\"1\", \"2\"")
  end

  it 'creates a 3 by 3 table with x and y axes' do
    Table.new(output,3,3,ROWS,COLUMNS).display_grid('∙')
    expect(output.string).to include("[\"1\",\"2\",\"3\"]\n")
  end
end

