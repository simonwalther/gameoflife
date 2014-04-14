require "thor"
require "gameoflife/board"
require "gameoflife/game"

module Gameoflife
  class Cli < Thor
     # play [--rule=conway] --tick=1000
     # generate --width --height --file=file.txt
     # rules

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
      nb_ticks = options[:ticks]
      rules = options[:rules]
      rules_file = File.open(rules_path, "r+")
      rules_found = false
      read_name = true
      read_cases_of_life = false
      read_cases_of_birth = false
      end_of_cases = false
      name = Array.new
      cases_of_life = Array.new
      cases_of_birth = Array.new

      ################# rules parser #################
      until rules_found == true && end_of_cases == true || rules_file.eof? == true
        select_char = rules_file.getc.chr

        ### condition suivant l'etape ou l'on se trouve ###
        if read_name == true
          name << select_char
        end

        if name == rules
          rules_found = true
          if read_cases_of_life == true
            cases_of_life << select_char
          elsif read_cases_of_birth == true
            cases_of_birth << select_char
          end
        end

        ### detection des caracteres delimitant les variables ###
        if select_char == "{"
          if (name.is_a? String) == false
            name = name.join
            name = name.chomp('{').gsub!(/\s+/, "")
          else
            name = name.chomp('{').gsub!(/\s+/, "")
          end
          read_name = false
          read_cases_of_life = true
        elsif select_char == ","
          read_cases_of_life = false
          read_cases_of_birth = true
        elsif select_char == "}"
          read_cases_of_birth = false
          end_of_cases = true
        elsif end_of_cases == true && rules_found == false
          name = name.clear
          cases_of_life = cases_of_life.clear
          cases_of_birth = cases_of_birth.clear
          end_of_cases = false
          read_name = true
        end
      end

      cases_of_life = cases_of_life.join.chomp(',').split(//)
      cases_of_birth = cases_of_birth.join.chomp("}").split(//)
      puts "[NAME = #{name}] [LIFE = #{cases_of_life}] [BIRTH = #{cases_of_birth}]"
      ################# end of rules parser #################
      game = Game.new(board, cases_of_life, cases_of_birth)

      if options[:dry]
        sleep_time = 0
      end

      board.displayboard

      nb_ticks.times do |current_tick|
        sleep(sleep_time)
        system "clear" or system "cls"

        if options[:dry] == false
          puts "current_tick: #{current_tick}"
        else
          progress = ((current_tick+1)*100)/nb_ticks
          puts "progress: #{progress} %"
        end

        game.isalive

        if options[:dry] == false || (current_tick+1) == nb_ticks
          board.displayboard
        end
      end
    end

    desc "rules <RULES_PATH> <NAME> <CASES_OF_LIFE> <CASES_OF_BIRTH>", "define a rule in the rules.txt file"
    option :name, aliases: :n, :required => true
    option :life, aliases: :l, :required => true
    option :birth, aliases: :b, :required => true

    def rules(rules_path = DEFAULT_RULES_PATH)
      File.open(rules_path, "a") do |w|
        w.puts "#{options[:name]} {#{options[:life]},#{options[:birth]}}"
      end
    end
  end
end
