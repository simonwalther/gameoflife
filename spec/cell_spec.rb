require 'spec_helper'
require 'cell'

describe Cell do
  context '4;4 after created' do
    subject { Cell.new(4, 4, true) }

    its(:posx) { should == 4 }
    its(:posy) { should == 4 }

    its(:alive) { should == true }
  end
end
