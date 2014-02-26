class Board
  attr_accessor :width, :height, :number_cell

  def initialize
    @width = 30
    @height = 30
    @number_cell = @width * @height
  end
end
