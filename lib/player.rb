class Player

  def initialize(input,rows,columns)
    @row_label = rows
    @column_label = columns
    @input = input
  end

  def give_coordinate
    coordinate_guess = @input.gets.to_s
    index_of_coordinate(coordinate_guess)
  end

  def index_of_coordinate(guess)
    column_number = "#{guess.split(//)[1] + guess.split(//)[2]}".to_i - 1
    row_letter = guess.split(//)[0]
    @row_label.each_with_index do |row,i|
      if row_letter == row
        column_number += (@column_label.length * i) 
      end
    end
    column_number
  end

end
