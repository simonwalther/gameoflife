require 'spec_helper'
require 'board'

describe Board do
  context 'after created' do
    subject { Board.new(File.expand_path(__FILE__ + '/../../config/alive.txt')) }

    its(:width) { should == 18 }
    its(:height) { should == 10 }
    its(:number_cell) { should == 180 }
    its(:cells) { should_not == nil }
    its(:cells_length) { should == 180 }
  end

  describe 'test: displayboard' do
    let(:board) { Board.new(File.expand_path(__FILE__ + '/../../config/alive.txt')) }

    before(:each) do
      board.displayboard
    end

    it 'should have a no-empty grid' do
      board.grid { should_not == nil }
    end
  end
end
