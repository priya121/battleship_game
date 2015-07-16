require 'data_table'

describe Table do 
  let(:output) {StringIO.new('')}
  let(:coordinates) {['∙','◦','∙','∙']}
  let(:input) {StringIO.new('A2')}
  let(:grid) {Grid.new(2,2,["E","E","E","E"]).place_ship(1)}

    COLUMNS = ['1','2']
    ROWS = ['A','B','C']

  it 'creates the table with coordinates' do 
    Table.new(input,output,ROWS,COLUMNS,2,grid).display_table(['∙'])
    expect(output.string).to include("\t1                       2                       \nA\t∙                   \n")
  end

  it 'creates a table with y axis letters' do 
    Table.new(input,output,ROWS,COLUMNS,2,grid).display_table(['∙'])
    expect(output.string).to include("\t1                       2                       \nA\t∙                   \n")
  end

  it 'creates a table with x axis numbers' do 
    Table.new(input,output,ROWS,COLUMNS,2,grid).display_table(['∙'])
    expect(output.string).to include("\t1                       2                       \nA\t∙                   \n")
  end

  it 'creates a 3 by 3 table with x and y axes' do
    Table.new(input,output,ROWS,COLUMNS,2,grid).display_table(['∙'])
    expect(output.string).to include("\t1                       2                       \nA\t∙                   \n")
  end
  
  it 'takes a 1d array and outputs a 2 by 2 grid' do 
    Table.new(input,output,ROWS,COLUMNS,2,grid).display_table(coordinates)
    expect(output.string).to include("\t1                       2                       \nA\t∙                   \t◦                    \nB\t∙                   \t∙                    \n")
  end

  it 'displays an updated grid once a player has made a guess' do 
    grid = Grid.new(2,2,["E","E","E","E"]).place_ship(1)
    first_move_coordinates = Table.new(input,output,ROWS,COLUMNS,2,grid).player_guess
    expect(output.string).to include("\n\t1                       2                       \nA\t∙                   \tHIT                  \nB\t∙                   \t∙                    \nC\n\n")
  end
end

