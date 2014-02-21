class Board
  attr_accessor :width, :height, :numbercell

  def initialize
    @width = 10
    @height = 10
    @numbercell = @width * @height
  end
end
