require 'spec_helper'
require 'main'

describe Main do
  context 'after created' do
    subject { Main.new }
    its(:celllist) { should_not == nil }
    its(:celllistlength) { should == 100 }
  end

  context 'Cell 4;4' do
    subject { Cell.new(4, 4, true) }
    its(:neighbour) { should =~ [[4, 5], [5, 4], [5, 5], [4, 3], [3, 4], [3, 3], [5, 3], [3, 5]] }
  end
end
