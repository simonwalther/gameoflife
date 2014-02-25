require 'spec_helper'
require 'cell'

describe Cell do
  context 'after created' do
    subject { Cell.new(1, 1, false) }

    its(:posx) { should == 1 }
    its(:posy) { should == 1 }

    its(:alive) { should == false }
  end
end
