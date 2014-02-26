class Board
  attr_accessor :width, :height, :numbercell

  def initialize
    @width = 30
    @height = 30
    @numbercell = @width * @height
  end
end
