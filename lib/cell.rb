class Cell
  attr_accessor :posx, :posy, :alive, :neighbour

  def initialize(posx, posy, alive)
    #positions x and y
    @posx = posx
    @posy = posy
    #alive true or nil
    @alive = alive
    @neighbour = Array.new
  end
end
