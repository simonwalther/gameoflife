class Cell
  attr_accessor :posx, :posy, :alive, :neighbour, :alivenextstep

  def initialize(posx, posy, alive)
    #positions x and y
    @posx = posx
    @posy = posy
    #alive true or nil
    @alive = alive
    #neighbour
    @neighbour = [
      [posx,   posy+1],
      [posx+1, posy],
      [posx+1, posy+1],
      [posx,   posy-1],
      [posx-1, posy],
      [posx-1, posy-1],
      [posx+1, posy-1],
      [posx-1, posy+1]
    ]
    #alivenextstep
    @alivenextstep = alivenextstep
  end
end
