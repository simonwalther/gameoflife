require 'spec_helper'
require 'game'

describe Game do
  context 'after created' do
    subject { Game.new }
  end

  describe 'test: cell' do
    let(:board) { Board.new(File.expand_path(__FILE__ + '/../../config/alive.txt')) }
    let(:game) { Game.new(board, [2, 3], [3]) }

    before(:each) do
      @cells = board.cells
      @cell_neighbour_1 = @cells[((2*board.width)+3)-1]
      @cell_neighbour_2 = @cells[((2*board.width)+4)-1]
      @cell_neighbour_3 = @cells[((2*board.width)+5)-1]
      @cell_neighbour_4 = @cells[((3*board.width)+3)-1]
      @cell             = @cells[((3*board.width)+4)-1]
      @cell_neighbour_5 = @cells[((3*board.width)+5)-1]
      @cell_neighbour_6 = @cells[((4*board.width)+3)-1]
      @cell_neighbour_7 = @cells[((4*board.width)+4)-1]
      @cell_neighbour_8 = @cells[((4*board.width)+5)-1]
    end

    it 'with cell should have right neighbour' do
      expect(@cell.neighbour).to eq([[4, 5], [5, 4], [5, 5], [4, 3], [3, 4], [3, 3], [5, 3], [3, 5]])
    end

    describe 'with alive true and rule conway' do
      before(:each) do
        @cell.alive = true
      end

      describe 'with one neighbour alive' do
        before(:each) do
          @cell_neighbour_1.alive = true
          game.isalive
        end

        it 'should become false' do
          expect(@cell.alive).to eq(false)
        end
      end

      describe 'with two neighbour alive' do
        before(:each) do
          @cell_neighbour_1.alive = true
          @cell_neighbour_2.alive = true
          game.isalive
        end

        it 'should stay true' do
          expect(@cell.alive).to eq(true)
        end
      end

      describe 'with three neighbour alive' do
        before(:each) do
          @cell_neighbour_1.alive = true
          @cell_neighbour_2.alive = true
          @cell_neighbour_3.alive = true
          game.isalive
        end

        it 'should stay true' do
          expect(@cell.alive).to eq(true)
        end
      end

      describe 'with four neighbour alive' do
        before(:each) do
          @cell_neighbour_1.alive = true
          @cell_neighbour_2.alive = true
          @cell_neighbour_3.alive = true
          @cell_neighbour_4.alive = true
          game.isalive
        end

        it 'should stay false' do
          expect(@cell.alive).to eq(false)
        end
      end
    end

    describe 'with alive false' do
      before(:each) do
        @cell.alive = false
      end

      describe 'with two neighbour alive' do
        before(:each) do
          @cell_neighbour_1.alive = true
          @cell_neighbour_2.alive = true
          game.isalive
        end

        it 'should stay false' do
          expect(@cell.alive).to eq(false)
        end
      end

      describe 'with three neighbour alive' do
        before(:each) do
          @cell_neighbour_1.alive = true
          @cell_neighbour_2.alive = true
          @cell_neighbour_3.alive = true
          game.isalive
        end

        it 'should become true' do
          expect(@cell.alive).to eq(true)
        end
      end

      describe 'with four neighbour alive' do
        before(:each) do
          @cell_neighbour_1.alive = true
          @cell_neighbour_2.alive = true
          @cell_neighbour_3.alive = true
          @cell_neighbour_4.alive = true
          game.isalive
        end

        it 'should stay false' do
          expect(@cell.alive).to eq(false)
        end
      end
    end
  end
end
