require 'board'
require 'cell'

class Main
  attr_accessor :cell_list, :number_cell, :cell_list_length, :nb_tick

  def initialize
    board = Board.new

    @cell_list = Array.new
    @number_cell = board.number_cell
    @width = board.width
    @nb_tick = nb_tick

    ##### initialize cells #####
    a = 1
    b = 1

    number_cell.times do
      @cell_list << Cell.new(a, b, false)

      a += 1

      if a == (@width + 1)
        a = 1
        b += 1
      end
    end

    cell = cell_list[1]
    @neighbour = cell.neighbour
  end

  def cell_list_length
    @cell_list_length = cell_list.length
  end

  def isalive
    number_cell.times do |z|
      select_this = cell_list[z]

      b = 0
      c = 0

      if select_this.alive == true && select_this != nil
        8.times do |a|
          neighbour_select = cell_list.select { |a| a.posx == select_this.neighbour[b].first && a.posy == select_this.neighbour[b].last }.first

          if neighbour_select != nil

            if neighbour_select.alive == true
              c += 1
            end
          end

          b += 1
        end

        if c == 2 || c == 3
          #la cellule restera vivante
          select_this.alive_next_step = true
        else
          #la cellule meurt
          select_this.alive_next_step = false
        end
      elsif select_this.alive == false && select_this != nil
        8.times do |a|
          neighbour_select = cell_list.select { |a| a.posx == select_this.neighbour[b].first && a.posy == select_this.neighbour[b].last }.first

          if neighbour_select != nil

            if neighbour_select.alive == true
              c += 1
            end
          end

          b += 1
        end

        if c == 3
          #la cellule nait"
          select_this.alive_next_step = true
        else
          #la cellule restera morte
          select_this.alive_next_step = false
        end
      end

      c = 0 #reset
    end

    number_cell.times do |a|
      select_this = cell_list[a]

      select_this.alive = select_this.alive_next_step
      select_this.alive_next_step = nil
    end
  end

  def displaygrid
    board = Board.new
    grid = Array.new

    number_cell.times do |a|
      select_this = cell_list[a]

      if select_this.alive == true
        grid << "@ "
      elsif select_this.alive == false
        grid << "  "
      end
    end

    b = 1

    number_cell.times do |a|
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
    @nb_tick = STDIN.gets.chomp.to_i
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
      select_this = cell_list.select { |a| a.posx == cell_alive.first && a.posy == cell_alive.last }.first
      select_this.alive = true
    end
  end
end

main = Main.new
main.definenbtick
main.definealive

cell_list = main.cell_list
nb_tick = main.nb_tick

cell = cell_list[1]

nb_tick.times do
  main.displaygrid
  main.isalive
  system "clear" or system "cls"
end
