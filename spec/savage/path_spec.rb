require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include Savage

describe Path do
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
  it 'should have subpaths' do
    Path.new.respond_to?(:subpaths).should == true
  end
  it 'should have a to_command method' do
    Path.new.respond_to?(:to_command).should == true
  end
end