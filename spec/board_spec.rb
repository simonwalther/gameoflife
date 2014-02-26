require 'spec_helper'
require 'board'

describe Board do
  context 'after created' do
    subject { Board.new }

    its(:width) { should == 30 }
    its(:height) { should == 30 }
    its(:numbercell) { should == 900 }
  end
end
