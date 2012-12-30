require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage::Directions

describe ClosePath do
  before :each do
    @dir = ClosePath.new()
  end
  def create_relative; ClosePath.new(false); end
  def command_code; 'z'; end
  include Command
  it_behaves_like 'Direction'
  it 'should be constructed with with either no parameters or a single boolean parameter' do
    lambda { ClosePath.new }.should_not raise_error
    lambda { ClosePath.new true }.should_not raise_error
    lambda { ClosePath.new 45, 50 }.should raise_error
  end
  it 'should be relative if constructed with a false parameter' do
    direction = ClosePath.new(false)
    direction.absolute?.should == false
  end
  it 'should be absolute if constructed with a false parameter' do
    direction = ClosePath.new(true)
    direction.absolute?.should == true
  end
  it 'should be absolute if constructed with no parameters' do
    direction = ClosePath.new()
    direction.absolute?.should == true
  end
end
