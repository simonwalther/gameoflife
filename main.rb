
#!/usr/bin/env ruby

class Board
  attr_accessor :width, :height, :numbercell

  def initialize
    @width = 10
    @height = 10
    @numbercell = @width * @height
  end
end

class Cell
  attr_accessor :posx, :posy, :alive

  def initialize(posx, posy)
    #positions x and y
    @posx = posx
    @posy = posy

    #alive true or nil
    @alive = true
  end
end

board = Board.new

celllist = Array.new
numbercell = board.numbercell

#create cells
numbercell.times do
  celllist << Cell.new(1, 1)
end

puts "#{celllist}"
