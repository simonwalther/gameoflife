require 'board'
require 'cell'

class Main
  attr_accessor :celllist, :numbercell, :celllistlength

  def initialize
    board = Board.new

    @celllist = Array.new
    @numbercell = board.numbercell

    ##### initialize cells #####
    a = 1
    b = 1

    numbercell.times do
      @celllist << Cell.new(a, b, false)

      a += 1

      if a == (board.width + 1)
        a = 1
        b += 1
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
    selected = celllist.select { |a| a.posx == 1 && a.posy == 1 }

    puts "selected: #{selected}"
    slct = selected[0]

    puts "slctposx: #{slct.posx}"
    puts "slctposy: #{slct.posy}"
    @neighbour << [slct.posx,   slct.posy+1]
    @neighbour << [slct.posx+1, slct.posy]
    @neighbour << [slct.posx+1, slct.posy+1]
    @neighbour << [slct.posx,   slct.posy-1]
    @neighbour << [slct.posx-1, slct.posy]
    @neighbour << [slct.posx-1, slct.posy-1]
    @neighbour << [slct.posx+1, slct.posy-1]
    @neighbour << [slct.posx-1, slct.posy+1]

    puts "neighbour: #{@neighbour}"

    8.times do |a|
      neightbourslct = celllist.select { |a| a.posx == neighbour[@posx] && a.posy == neighbour[@posy] }

      if neightbourslct[@alive] == true
        b += 1
      end
    end

    if b == 2
      puts "restera vivante"
    end
  end
end

main = Main.new
celllist = main.celllist

cell = celllist[1]
main.isalive
