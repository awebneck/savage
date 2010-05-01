require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage

describe Point do
  it 'should have an x' do
    Point.new.respond_to?(:x).should == true;
  end
  it 'should have an y' do
    Point.new.respond_to?(:y).should == true;
  end
end