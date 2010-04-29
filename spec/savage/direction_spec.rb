require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include Savage

describe Direction do
  it 'should have a to_command method' do
    Direction.new.respond_to?(:to_command).should == true
  end
  it 'should have an absolute? method' do
    Direction.new.respond_to?(:absolute?).should == true
  end
end
