require 'spec_helper'

describe Cell do
  context 'after created' do
    subject { Cell.new(1, 1) }

    its(:posx) { should == 1 }
    its(:posy) { should == 1 }

    its(:alive) { should == true }
  end
end
