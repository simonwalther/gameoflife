require 'spec_helper'
require 'board'

describe Board do
  context 'after created' do
    subject { Board.new }

    its(:width) { should == 30 }
    its(:height) { should == 30 }
    its(:number_cell) { should == 900 }
    its(:cells) { should_not == nil }
    its(:cells_length) { should == 900 }
  end
end
