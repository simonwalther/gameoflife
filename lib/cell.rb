class Cell
  attr_accessor :posx, :posy, :alive, :neighbour, :alive_next_step

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
    #alive_next_step
    @alive_next_step = alive_next_step
  end
end
