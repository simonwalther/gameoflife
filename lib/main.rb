require 'board'
require 'cell'

class Main
  attr_accessor :celllist, :numbercell, :celllistlength

  def initialize
    board = Board.new

    @celllist = Array.new
    @numbercell = board.numbercell
    @width = board.width

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

    z = 1
    x = 1

    numbercell.times do
      selected = celllist.select { |a| a.posx == z && a.posy == x }
      slct = selected[0]

      slct.neighbour << [slct.posx,   slct.posy+1]
      slct.neighbour << [slct.posx+1, slct.posy]
      slct.neighbour << [slct.posx+1, slct.posy+1]
      slct.neighbour << [slct.posx,   slct.posy-1]
      slct.neighbour << [slct.posx-1, slct.posy]
      slct.neighbour << [slct.posx-1, slct.posy-1]
      slct.neighbour << [slct.posx+1, slct.posy-1]
      slct.neighbour << [slct.posx-1, slct.posy+1]

      if z == 4 && x == 4
      ############################### case: restera vivante ##############################
        slct.alive = true

        toaliveslct = celllist.select { |a| a.posx == slct.neighbour[0].first && a.posy == slct.neighbour[0].last }
        ngbslct = toaliveslct[0]

        ngbslct.alive = true

        toaliveslct = celllist.select { |a| a.posx == slct.neighbour[1].first && a.posy == slct.neighbour[1].last }
        ngbslct = toaliveslct[0]

        ngbslct.alive = true

      elsif z == 7 && x == 4
      ############################### case: meurt ##############################
        slct.alive = true
      end

      z += 1

      if z == (@width + 1)
        z = 1
        x += 1
      end
    end
    ############################
    cell = celllist[1]
    @neighbour = cell.neighbour
  end

  def celllistlength
    @celllistlength = celllist.length
  end

  def isalive
    z = 1
    x = 1

    numbercell.times do
      selected = celllist.select { |a| a.posx == z && a.posy == x }
      slct = selected[0]

      b = 0
      c = 0

      if slct.alive == true && slct != nil
        8.times do |a|
          neighbourslct = celllist.select { |a| a.posx == slct.neighbour[b].first && a.posy == slct.neighbour[b].last }
          ngbslct = neighbourslct[0]

          if ngbslct != nil

            if ngbslct.alive == true
              c += 1
            end
          end

          b += 1
        end

        if c == 2 || c == 3
          puts "la cellule #{slct.posx};#{slct.posy} restera vivante"
        else
          puts "la cellule #{slct.posx};#{slct.posy} meurt"
        end
      elsif slct.alive == false && slct != nil
        8.times do |a|
          neighbourslct = celllist.select { |a| a.posx == slct.neighbour[b].first && a.posy == slct.neighbour[b].last }
          ngbslct = neighbourslct[0]

          if ngbslct != nil

            if ngbslct.alive == true
              c += 1
            end
          end

          b += 1
        end

        if c == 3
          puts "la cellule #{slct.posx};#{slct.posy} nait"
        else
          puts "la cellule #{slct.posx};#{slct.posy} restera morte"
        end
      end

      c = 0 #reset
      z += 1

      if z == (@width + 1)
        z = 1
        x += 1
      end
    end
  end
end

main = Main.new
celllist = main.celllist

cell = celllist[1]
main.isalive
