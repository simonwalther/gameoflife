require 'gameoflife/board'
require 'gameoflife/cell'

class Game
  attr_accessor :number_cell, :cells_length, :nb_tick

  def initialize(board = Board.new, casses_of_life, casses_of_birth)
    @board = board
    @number_cell = board.number_cell
    @width = board.width
    @cells = board.cells
    @casses_of_life = casses_of_life
    @casses_of_birth = casses_of_birth
    ##### initialize @cells #####
    cell = @cells[1]
    @neighbour = cell.neighbour
  end

  def isalive
    ############# cell to test ############
    cell_with_status_alive = Array.new
    cell_with_status_alive = @cells.select { |a| a.alive == true }
    cell_to_test = Array.new
    neighbour_of_alive = Array.new

    if cell_with_status_alive.empty?
      puts "les cellules sont toutes mortes"
      exit
    end

    cell_with_status_alive.each do |this|
      this.neighbour.length.times do |z|
        tamp = @board.return_cell(this.neighbour[z].first, this.neighbour[z].last)
        neighbour_of_alive << tamp
      end
    end

    neighbour_of_alive = neighbour_of_alive.compact

    cell_to_test = (cell_to_test << cell_with_status_alive << neighbour_of_alive).uniq.compact
    ###################################

    cell_to_test.length.times do |z|
      cell_to_test[z].length.times do |r|
        select_this = cell_to_test[z][r]

        c = 0

        if select_this != nil
          8.times do |a|
            neighbour_select = @board.return_cell(select_this.neighbour[a].first, select_this.neighbour[a].last)
            if neighbour_select != nil
              if neighbour_select.alive == true
                c += 1
              end
            end
          end

          if select_this.alive == true
            @casses_of_life.each do |this|
              if c == this.to_i
                select_this.alive_next_step = true
              end
            end
          elsif select_this.alive == false
            @casses_of_birth.each do |this|
              if c == this.to_i
                select_this.alive_next_step = true
              end
            end
          end

          c = 0
        end
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
end

