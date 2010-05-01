require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage

describe ClosePath do
  before :each do
    @dir = ClosePath.new()
  end
  include DirectionShared
  it 'should be constructed with with either no parameters or a single boolean parameter' do
    lambda { ClosePath.new }.should_not raise_error
    lambda { ClosePath.new true }.should_not raise_error
    lambda { ClosePath.new 45, 50 }.should raise_error
  end
  it 'should be absolute if constructed with a true parameter' do
    direction = ClosePath.new(true)
    direction.absolute?.should == true
  end
  it 'should not be absolute if constructed with a false parameter' do
    direction = ClosePath.new(false)
    direction.absolute?.should == false
  end
  it 'should not be absolute if constructed with no parameters' do
    direction = ClosePath.new()
    direction.absolute?.should == false
  end
  describe '#to_command' do
    it 'should be a capital Z when absolute' do
      abs_dir = ClosePath.new true
      abs_dir.to_command.should == 'Z'
    end
    it 'should be a lower-case z when not absolute' do
      @dir.to_command.should == 'z'
    end
  end
end
