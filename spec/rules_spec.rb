require 'spec_helper'
require 'rules'

describe Rules do
  context 'after created' do
    subject { Rules.new(File.expand_path(__FILE__ + '/../../../config/rules.txt')) }

    #its(:width) { should == 30 }
  end
end
