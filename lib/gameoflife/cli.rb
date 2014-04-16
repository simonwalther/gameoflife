require "thor"
require "gameoflife/board"
require "gameoflife/game"
require "gameoflife/rules"

module Gameoflife
  class Cli < Thor
    DEFAULT_BOARD_PATH = File.expand_path(__FILE__ + '/../../../config/alive.txt')
    DEFAULT_RULES_PATH = File.expand_path(__FILE__ + '/../../../config/rules.txt')

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
    option :dry, type: :boolean, default: false, aliases: :d
    option :sleep_time, type: :numeric, default: 0.15, aliases: :s
    option :rules, type: :string, default: "conway", aliases: :r

    def play(board_path = DEFAULT_BOARD_PATH, rules_path = DEFAULT_RULES_PATH)
      board = Board.new(board_path)
      sleep_time = options[:sleep_time]
      nb_ticks = (options[:ticks] + 1)

      rules = Rules.new(rules_path)
      rules.parse(options[:rules])
      @cases_of_birth = rules.cases_of_birth
      @cases_of_life = rules.cases_of_life

      game = Game.new(board, @cases_of_life, @cases_of_birth)

      if options[:dry]
        sleep_time = 0
      end

      nb_ticks.times do |current_tick|
        sleep(sleep_time)
        system "clear" or system "cls"

        if options[:dry] == false
          puts "current_tick: #{current_tick}"
        else
          progress = ((current_tick+1)*100)/nb_ticks
          puts "progress: #{progress} %"
        end

        if options[:dry] == false || (current_tick+1) == nb_ticks
          board.displayboard
        end

        game.isalive
      end
    end

    desc "rules <RULES_PATH> <NAME> <CASES_OF_LIFE> <CASES_OF_BIRTH>", "define a rule in the rule file"
    option :name, type: :string, aliases: :n
    option :life, type: :numeric, aliases: :l
    option :birth, type: :numeric, aliases: :b

    def add_rules(rules_path = DEFAULT_RULES_PATH)
      rules = Rules.new(rules_path)
      rules.add(rules_path, options[:name], options[:life], options[:birth])
    end

    desc "remove_rules <RULES_PATH> <NAME>", "remove a rule from a rule file"
    option :name, type: :string, aliases: :n, :require => true
    def remove_rules(rules_path = DEFAULT_RULES_PATH)
      rules = Rules.new(rules_path)
      rules.remove(rules_path, options[:name])
    end
  end
end
