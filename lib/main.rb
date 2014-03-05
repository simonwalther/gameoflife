require 'board'
require 'cell'

class Main
  attr_accessor :number_cell, :cells_length, :nb_tick

  def initialize(board = Board.new)
    # @cells = Array.new
    @number_cell = board.number_cell
    @width = board.width
    @nb_tick = nb_tick
    @cells = board.cells

    ##### initialize @cells #####
    cell = @cells[1]
    @neighbour = cell.neighbour
  end

  def isalive
    cell_with_status_alive = Array.new
    cell_with_status_alive = @cells.select { |a| a.alive == true }
    cell_to_test = Array.new
    neighbour_of_alive = Array.new
    neighbour_of_neighbour_of_alive = Array.new
    select_neighbour_of_alive = Array.new
    select_neighbour_of_neighbour_of_alive = Array.new

    cell_with_status_alive.length.times do |r|
      neighbour_of_alive << cell_with_status_alive[r].neighbour
    end

    neighbour_of_alive.length.times do |g|
      neighbour_of_alive[g].length.times do |k|
        tamp = @cells.select { |a| a.posx == neighbour_of_alive[g][k].first && a.posy == neighbour_of_alive[g][k].last }
        select_neighbour_of_alive << tamp
      end
    end

    neighbour_of_alive = []

    select_neighbour_of_alive.length.times do |q|
      neighbour_of_alive << select_neighbour_of_alive[q].first
    end

    neighbour_of_alive.length.times do |l|
      tamp = @cells.select { |a| a.posx == neighbour_of_alive[l].posx && a.posy == neighbour_of_alive[l].posy }
      select_neighbour_of_neighbour_of_alive << tamp
    end

    select_neighbour_of_neighbour_of_alive.length.times do |f|
      neighbour_of_neighbour_of_alive << select_neighbour_of_alive[f].first
    end

    cell_to_test << cell_with_status_alive << neighbour_of_alive << neighbour_of_neighbour_of_alive
    cell_to_test = cell_to_test.uniq

    cell_to_test.length.times do |z|
      cell_to_test[z].length.times do |r|
        select_this = cell_to_test[z][r]

        b = 0
        c = 0

        if select_this.alive == true && select_this != nil
          8.times do |a|
            neighbour_select = @cells.select { |a| a.posx == select_this.neighbour[b].first && a.posy == select_this.neighbour[b].last }

            if neighbour_select.first != nil
              if neighbour_select.first.alive == true
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
            neighbour_select = @cells.select { |a| a.posx == select_this.neighbour[b].first && a.posy == select_this.neighbour[b].last }

            if neighbour_select.first != nil
              if neighbour_select.first.alive == true
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
    end

    number_cell.times do |a|
      select_this = @cells[a]

      if select_this.alive_next_step == nil
        select_this.alive = false
      else
        select_this.alive = select_this.alive_next_step
      end

      select_this.alive_next_step = nil
    end
  end

  def displaygrid
    board = Board.new
    grid = Array.new

    b = 1

    number_cell.times do |a|
      select_this = @cells[a]

      if select_this.alive == true
        grid << "& "
      elsif select_this.alive == false
        grid << "  "
      end

      if b == board.width
        grid << "\n"
        b = 0
      end

      b += 1
    end
    print "#{grid.join}"
    puts "\n"
  end

  def definenbtick
    print "please enter the number of tick: "
    @nb_tick = STDIN.gets.chomp.to_i
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
end

board = Board.new
main = Main.new(board)
main.definenbtick
main.definealive

nb_tick = main.nb_tick

cell = board.cells[1]

nb_tick.times do
  main.displaygrid
  main.isalive
  system "clear" or system "cls"
  # sleep(1.0)
end
