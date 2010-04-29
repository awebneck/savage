require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include Savage

describe Path do
  it 'should have a commands list' do
    Path.new.respond_to?(:commands).should == true
  end
  it 'should accept no parameters in a constructor for a new, empty path' do
    lambda{ Path.new }.should_not raise_error
  end
  it 'should accept a string parameter to build a path based on existing path data' do
    lambda{ Path.new("M100 200") }.should_not raise_error
  end
  it 'should raise an error if anything besides a string is passed to the constructor' do
    lambda{ Path.new([]) }.should raise_error
    lambda{ Path.new({}) }.should raise_error
    lambda{ Path.new(56) }.should raise_error
    lambda{ Path.new(Object.new) }.should raise_error
  end
  describe '#commands' do
    it 'should be able to access items via the bracket operator' do
      Path.new.commands.respond_to?(:[]).should == true
    end
  end
end
