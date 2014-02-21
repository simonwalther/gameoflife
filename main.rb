#!/usr/bin/env ruby

require_relative 'board'
require_relative 'cell'

board = Board.new

celllist = Array.new
numbercell = board.numbercell

#create cells
numbercell.times do
  celllist << Cell.new(1, 1)
end

puts "#{celllist}"
