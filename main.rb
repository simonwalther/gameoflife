#!/usr/bin/env ruby

require_relative 'board'
require_relative 'cell'

board = Board.new
celllist = Array.new
numbercell = board.numbercell

#create cells

a = 1
b = 1

numbercell.times do
  celllist << Cell.new(a, b, false)

  a += 1

  if a == (board.width + 1)
    a = 1
    b += 1
  end
end

puts "#{celllist}"
