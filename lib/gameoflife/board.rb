# encoding: utf-8

class Board
  attr_accessor :cells, :width, :height, :number_cell, :cells_length

  def initialize(board_path)
    alivefile = File.open(board_path, "r+")
    @cells = Array.new
    @height = 0
    @width = 0

    character_alive = Array.new

    if File.zero?(board_path) == true
      number_cell.times do |count|
        alivefile.putc("-")

        if (count + 1) % @width == 0
          alivefile.putc("\n")
        end
      end
      puts 'file ' + board_path + ' has been regenerate'
    end

    g = 0
    alivefile.size.times do
      select_char = alivefile.getc.chr
      if select_char == "O"
        character_alive[g] = true
        g += 1
      elsif select_char == "-"
        g += 1
      elsif select_char == "\n"
        @height += 1
      end
    end

    @width = (g/@height)

    @number_cell = @width * @height

    a = 1
    b = 1

    number_cell.times do |this_cell|
      if character_alive[this_cell]
        @cells << Cell.new(a, b, true)
      else
        @cells << Cell.new(a, b, false)
      end

      if (this_cell + 1) % @width == 0
        a = 0
        b += 1
      end

      a += 1
    end
  end

  def displayboard
    grid = Array.new

    b = 1

    number_cell.times do |a|
      select_this = @cells[a]

      if select_this.alive == true
        grid << "█ "
      elsif select_this.alive == false
        grid << "~~"
      end

      if b == @width
        grid << "\n"
        b = 0
      end

      b += 1
    end

    print "#{grid.join}"
  end

  def cells_length
    cells_length = cells.length
  end

  def return_cell(x, y)
    if x < 1 || x > width
      nil
    elsif y < 1 || y > height
      nil
    else
      cells[(y - 1) * width + (x - 1)]
    end
  end
end
