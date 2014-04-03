require 'board'
require 'cell'

module Gameoflife
  class Game
    attr_accessor :number_cell, :cells_length, :nb_tick

    def initialize(board = Board.new)
      @board = board
      @number_cell = board.number_cell
      @width = board.width
      @nb_tick = nb_tick
      @cells = board.cells
      boardconfig = File.open(File.expand_path("..",Dir.pwd) + "/config/boardconfig.txt")
      h = 0

      boardconfig.each do |line|
        if h == 5
          casses_of_life = line.chomp
          @casses_of_life = casses_of_life.split(//)
        elsif h == 7
          casses_of_birth = line.chomp
          @casses_of_birth = casses_of_birth.split(//)
        end
        h+= 1
      end

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
      neighbour_of_neighbour_of_alive = Array.new

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

      neighbour_of_alive.length.times do |x|
        neighbour_of_neighbour_of_alive << @board.return_cell(neighbour_of_alive[x].posx, neighbour_of_alive[x].posy)
      end

      cell_to_test = (cell_to_test << cell_with_status_alive << neighbour_of_alive << neighbour_of_neighbour_of_alive).uniq.compact
      ###################################

      cell_to_test.length.times do |z|
        cell_to_test[z].length.times do |r|
          select_this = cell_to_test[z][r]

          b = 0
          c = 0

          if select_this != nil
            8.times do |a|
              neighbour_select = @board.return_cell(select_this.neighbour[b].first, select_this.neighbour[b].last)

              if neighbour_select != nil
                if neighbour_select.alive == true
                  c += 1
                end
              end

              b += 1
            end

            if select_this.alive == true
              @casses_of_life.each do |this|
                if c == this.to_i
                  #la cellule nait"
                  select_this.alive_next_step = true
                end
              end
            elsif select_this.alive == false || select_this != nil
              @casses_of_birth.each do |this|
                if c == this.to_i
                  #la cellule nait"
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

    def definenbtick
      print "please enter the number of tick: "
      @nb_tick = (STDIN.gets.chomp.to_i + 1)
    end
  end

  #########  configure the board size #########
  boardconfig = File.open(File.expand_path("..",Dir.pwd) + "/config/boardconfig.txt")
  h = 0
  wanted_width = 0
  wanted_height = 0

  boardconfig.each do |line|
    if h == 1
      wanted_width = line.chomp.to_i
    elsif h == 3
      wanted_height = line.chomp.to_i
    end
    h+=1
  end
  ################################################
  Cli.start(ARGV)

  game = Game.new(board = Board.new(wanted_width, wanted_height))

  board.definealive
  game.definenbtick
  nb_tick = game.nb_tick

  cell = board.cells[1]

  nb_tick.times do |c|
    puts "tick = #{c}"
    board.displayboard
    game.isalive
    sleep(0.15)
    system "clear" or system "cls"
  end
end
