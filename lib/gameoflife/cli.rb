require "thor"
require "gameoflife/board"
require "gameoflife/game"

module Gameoflife
  class Cli < Thor
     # play [--rule=conway] --tick=1000 --result=result.txt file.txt
     # generate --width --height --file=file.txt
     # rules

    DEFAULT_BOARD_PATH = File.expand_path(__FILE__ + '/../../../config/alive.txt')

    desc "generate <BOARD FILE>", "generate the board file with the good width and height"
    option :width, type: :numeric, default: 10, aliases: :w
    option :height, type: :numeric, default: 10, aliases: :h
    def generate(board_path = DEFAULT_BOARD_PATH)
      width = options[:width]
      height = options[:height]

      File.open(board_path, 'w') do |alivefile|
        (width * height).times do |count|
          alivefile.putc("-")

          if (count + 1) % width == 0
            alivefile.putc("\n")
          end
        end
      end

      puts "file '#{board_path}' has been generated"
    end

    desc "play <BOARD FILE>", "generate the board file with another file and run it"
    option :ticks, type: :numeric, default: 500, aliases: :t
    def play(board_path = DEFAULT_BOARD_PATH)
      board = Board.new(board_path)
      game = Game.new(board)

      board.displayboard

      options[:ticks].times do |t|
        puts "t: #{t}"
        game.isalive
        board.displayboard
        sleep(0.15)
        system "clear" or system "cls"
      end
    end
  end
end
