class Board
  attr_accessor :cells, :width, :height, :number_cell, :cells_length

  def initialize(width = 30, height = 30)
    @cells = Array.new
    @width = width
    @height = height
    @number_cell = @width * @height

    a = 1
    b = 1

    number_cell.times do
      cells << Cell.new(a, b, false)

      a += 1

      if a == (@width + 1)
        a = 1
        b += 1
      end
    end
  end

  def cells_length
    cells_length = cells.length
  end

  def cells
    @cells
  end

  def cell(x, y)
    cells[(y - 1) * width + (x - 1)]
  end
end
