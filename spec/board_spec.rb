require 'spec_helper'

describe Board do
  context 'after created' do
    subject { Board.new }

    its(:width) { should == 10 }
    its(:height) { should == 10 }
    its(:numbercell) { should == 100 }
  end
end
