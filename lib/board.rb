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

  def definealive
    puts "please enter alive @cells position"
    puts "to stop enter two times 'stop'"
    inputx = nil
    inputy = nil
    cell_alives = Array.new

    until inputx == "stop" || inputy == "stop" do
      pos = Array.new
      print "position x: "
      inputx = STDIN.gets.chomp
      print "position y: "
      inputy = STDIN.gets.chomp

      if inputx != "stop" && inputy != "stop"
        pos << inputx.to_i << inputy.to_i
        cell_alives << pos
      end
    end

    puts "#{cell_alives}"

    cell_alives.each do |cell_alive|
      select_this = @cells.select { |a| a.posx == cell_alive.first && a.posy == cell_alive.last }.first
      select_this.alive = true
    end
  end

  def displayboard
    grid = Array.new

    b = 1

    number_cell.times do |a|
      select_this = @cells[a]

      if select_this.alive == true
        grid << "& "
      elsif select_this.alive == false
        grid << "  "
      end

      if b == @width
        grid << "\n"
        b = 0
      end

      b += 1
    end
    print "#{grid.join}"
    puts "\n"
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
