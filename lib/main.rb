require 'board'
require 'cell'

class Main
  attr_accessor :celllist, :numbercell, :celllistlength, :nbtick

  def initialize
    board = Board.new

    @celllist = Array.new
    @numbercell = board.numbercell
    @width = board.width
    @nbtick = nbtick

    ##### initialize cells #####
    a = 1
    b = 1

    numbercell.times do
      @celllist << Cell.new(a, b, false)

      a += 1

      if a == (@width + 1)
        a = 1
        b += 1
      end
    end

    cell = celllist[1]
    @neighbour = cell.neighbour
  end

  def celllistlength
    @celllistlength = celllist.length
  end

  def isalive
    # z = 1
    # x = 1

    numbercell.times do |z|
      select_this = celllist[z]

      b = 0
      c = 0

      if select_this.alive == true && select_this != nil
        8.times do |a|
          neighbour_select = celllist.select { |a| a.posx == select_this.neighbour[b].first && a.posy == select_this.neighbour[b].last }.first

          if neighbour_select != nil

            if neighbour_select.alive == true
              c += 1
            end
          end

          b += 1
        end

        if c == 2 || c == 3
          #la cellule restera vivante
          select_this.alivenextstep = true
        else
          #la cellule meurt
          select_this.alivenextstep = false
        end
      elsif select_this.alive == false && select_this != nil
        8.times do |a|
          neighbour_select = celllist.select { |a| a.posx == select_this.neighbour[b].first && a.posy == select_this.neighbour[b].last }.first

          if neighbour_select != nil

            if neighbour_select.alive == true
              c += 1
            end
          end

          b += 1
        end

        if c == 3
          #la cellule nait"
          select_this.alivenextstep = true
        else
          #la cellule restera morte
          select_this.alivenextstep = false
        end
      end

      c = 0 #reset
    end

    numbercell.times do |a|
      select_this = celllist[a]

      select_this.alive = select_this.alivenextstep
      select_this.alivenextstep = nil
    end
  end

  def displaygrid
    board = Board.new
    grid = Array.new

    numbercell.times do |a|
      select_this = celllist[a]

      if select_this.alive == true
        grid << "@ "
      elsif select_this.alive == false
        grid << "- "
      end
    end

    b = 1

    numbercell.times do |a|
      print "#{grid[a]}"

      if b == board.width
        puts "\n"
        b = 0
      end

      b += 1
    end
  end

  def definenbtick
    print "please enter the number of tick: "
    @nbtick = STDIN.gets.chomp.to_i
  end

  def definealive
    puts "please enter alive cells position"
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
      select_this = celllist.select { |a| a.posx == cell_alive.first && a.posy == cell_alive.last }.first
      select_this.alive = true
    end
  end
end

main = Main.new
main.definenbtick
main.definealive

celllist = main.celllist
nbtick = main.nbtick

cell = celllist[1]

nbtick.times do
  main.displaygrid
  main.isalive
  system "clear" or system "cls"
end
