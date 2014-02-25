require 'spec_helper'
require 'main'

describe Main do
  context 'after created' do
    subject { Main.new }
    its(:celllist) { should_not == nil }
  end

  context 'with the celllist length' do
    subject { Main.new }
    its(:celllistlength) { should == 100 }
  end
end
