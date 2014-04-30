class Rules
  attr_accessor :cases_of_life, :cases_of_birth

  def initialize(rules_path)
    @rules_path = rules_path
    @cases_of_life = cases_of_life
    @cases_of_birth = cases_of_birth
  end

  def parse(rules)
    rules_file = File.open(@rules_path, "r+")
    rules_found = false
    read_name = true
    read_cases_of_life = false
    read_cases_of_birth = false
    end_of_cases = false
    name = Array.new
    @cases_of_life = Array.new
    @cases_of_birth = Array.new

    until rules_found == true && end_of_cases == true
      select_char = rules_file.getc.chr

      if rules_file.eof? == true
        puts "ERROR: rules not found"
        exit(0)
      elsif name == nil || @cases_of_life == nil || @cases_of_birth == nil || end_of_cases == false && select_char == "\n"
        puts "ERROR: unexpecting syntax"
        puts "name: #{name}"
        puts "life: #{@cases_of_life}"
        puts "birth: #{@cases_of_birth}"
        exit(0)
      end

      if read_name == true
        name << select_char
      elsif read_name == false
        if name == rules
          rules_found = true

          if read_cases_of_life == true
            @cases_of_life << select_char
          elsif read_cases_of_birth == true
            @cases_of_birth << select_char
          end
        elsif name != rules
          rules_found = false

          if end_of_cases == true
            name = name.clear
            @cases_of_life = @cases_of_life.clear
            @cases_of_birth = @cases_of_birth.clear
            end_of_cases = false
            read_name = true
          end
        end
      end

      ### detection des caracteres delimitant les variables ###
      case select_char
        when "{"
          if (name.is_a? String) == false
            name = name.join
          end
          name = name.chomp('{').gsub!(/\s+/, "")
          read_name = false
          read_cases_of_life = true
        when ","
          read_cases_of_life = false
          read_cases_of_birth = true
        when "}"
          read_cases_of_birth = false
          end_of_cases = true
      end
    end

    @cases_of_life = @cases_of_life.join.chomp(',').split(//)
    @cases_of_life.size.times do |cases|
      cases_of_life[cases] = cases_of_life[cases].to_i
    end

    @cases_of_birth = @cases_of_birth.join.chomp("}").split(//)
    @cases_of_birth.size.times do |cases|
      cases_of_birth[cases] = cases_of_birth[cases].to_i
    end
    puts "name | #{name}"
    puts "life | #{cases_of_life}"
    puts "birth| #{cases_of_birth}"
  end

  def add(rules_path, name, life, birth)
    File.open(rules_path, "a") do |w|
      w.puts "#{name} {#{life},#{birth}}"
    end
  end

  def remove(rules_path, rules)
    File.open(rules_path + ".temp", "w") do |outfile|
      File.foreach(rules_path) do |inputline|
        outfile.puts(inputline) unless inputline =~ /#{rules}/
      end
    end

    FileUtils.rm(rules_path)
    File.rename(rules_path + ".temp", rules_path)
  end
end
