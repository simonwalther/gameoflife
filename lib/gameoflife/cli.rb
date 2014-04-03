require "Thor"

class Cli < Thor
   # play [--rule=conway] --tick=1000 --result=result.txt file.txt
   # generate --width --height --file=file.txt
   # rules

  desc "generate WIDTH HEIGHT", "generate a file with the good width and height"

  def generate(width, height)
    b = 1

    alivefile = File.open(File.expand_path("..",Dir.pwd) + "/config/alive.txt", "w")

    (width.to_i * height.to_i).times do |a|
      alivefile.putc("-")

      if b == width.to_i
        alivefile.putc("\n")
        b = 0
      end

      b += 1
    end

    puts "file alive.txt has been regenerated"
    exit
  end
end

