class Table
  def initialize(output,rows,columns)
    @output = output
    @rows = rows
    @columns = columns
  end


  def display_grid(cells)
    grid = Array.new(@rows.size) {Array.new(@columns.size,cells)}
    @output.print "\t"
    @output.print @columns
    @output.puts "\n"
    grid.each_with_index do |row, index|
      @output.print @rows[index]
      @output.print "\t"
      @output.print row
      @output.puts "\n"
    end
  end
end

