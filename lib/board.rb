# encoding: utf-8

class Board
  attr_accessor :cells, :width, :height, :number_cell, :cells_length

  def initialize(width = 50, height = 50)
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
    b = 1

    alivefile = File.open("alive.txt", "r+")
      if File.zero?("alive.txt") == true
        number_cell.times do |a|
          alivefile.putc("-")

          if b == @width
            alivefile.putc("\n")
            b = 0
          end

          b += 1
        end
        puts "file alive.txt has been regenerate"
        exit
      end

    alivefile.rewind

    g = 0
    alivefile.size.times do
      select_char = alivefile.getc.chr
      if select_char == "O"
        g += 1
        @cells[g].alive = true
      elsif select_char == "-"
        g += 1
      end
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
