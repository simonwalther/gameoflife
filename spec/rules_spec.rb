require 'spec_helper'
require 'rules'

describe Rules do
  context 'after created' do
    subject { Rules.new }
  end

  describe 'test: parse' do
    let(:rules) { Rules.new(File.expand_path(__FILE__ + '/../../config/rules.txt')) }

    before(:each) do
      rules.parse("conway")
    end

    it 'should return the right cases of life' do
      expect(rules.cases_of_life).to eq([2,3])
    end

    it 'should return the right cases of birth' do
      expect(rules.cases_of_birth).to eq([3])
    end
  end

  describe 'test: add' do
    let(:rules) { Rules.new(File.expand_path(__FILE__ + '/../../config/rules.txt')) }

    before(:each) do
      rules.add(File.expand_path(__FILE__ + '/../../config/rules.txt'), "test", 123, 2678)
      rules.parse("test")
    end

    it 'should add the rule with the right cases_of_life' do
      expect(rules.cases_of_life).to eq([1,2,3])
    end

    it 'should add the rule with the right cases_of_birth' do
      expect(rules.cases_of_birth).to eq([2,6,7,8])
    end
  end

  describe 'test: remove' do
    let(:rules) { Rules.new(File.expand_path(__FILE__ + '/../../config/rules.txt')) }

    before(:each) do
      rules.add(File.expand_path(__FILE__ + '/../../config/rules.txt'), "test", 123, 2678)
    end

    it 'should remove the rule' do
      expect{rules.remove(File.expand_path(__FILE__ + '/../../config/rules.txt'), "test")}.to change{File.foreach(File.expand_path(__FILE__ + '/../../config/rules.txt')).count}.by(-3)
    end
  end
end
