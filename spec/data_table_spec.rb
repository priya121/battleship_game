require 'data_table'

describe Table do 
  let(:output) {StringIO.new('')}
  let(:input) {}
    COLUMNS = ['1','2','3']
    ROWS = ['A','B','C']

  it 'creates the table with coordinates' do 
    Table.new(output,ROWS,COLUMNS).display_grid(['∙'])
    expect(output.string).to include("[\"∙\"]")
  end

  it 'creates a table with y axis letters' do 
    Table.new(output,ROWS,COLUMNS).display_grid('∙')
    expect(output.string).to include("A\t[\"∙\", \"∙\", \"∙\"]\n")
  end

  it 'creates a table with x axis numbers' do 
    Table.new(output,ROWS,COLUMNS).display_grid('∙')
    expect(output.string).to include("[\"1\", \"2\"")
  end

  it 'creates a 3 by 3 table with x and y axes' do
    Table.new(output,ROWS,COLUMNS).display_grid('∙')
    expect(output.string).to include("[\"1\", \"2\", \"3\"]\n")
  end
end

