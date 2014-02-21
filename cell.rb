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
