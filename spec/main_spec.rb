require 'spec_helper'

describe Board do
  context 'after created' do
    subject { Board.new }

    its(:width) { should == 10 }
    its(:height) { should == 10 }
    its(:numbercell) { should == 100 }
  end
end

describe Cell do
  context 'after created' do
    subject { Cell.new(1, 1) }

    its(:posx) { should == 1 }
    its(:posy) { should == 1 }

    its(:alive) { should == true }
  end
end
