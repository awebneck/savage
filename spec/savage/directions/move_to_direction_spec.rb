require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage

describe MoveToDirection do
  before :each do
    @abs_dir = MoveToDirection.new(100,200,true)
    @nonabs_dir = MoveToDirection.new(100,200)
  end
  it 'should have a to_command method' do
    @nonabs_dir.respond_to?(:to_command).should == true
  end
  it 'should have an absolute? method' do
    @nonabs_dir.respond_to?(:absolute?).should == true
  end
  it 'should be constructed with at least an x and y parameter' do
    lambda { MoveToDirection.new }.should raise_error
    lambda { MoveToDirection.new 45 }.should raise_error
    lambda { MoveToDirection.new 45, 50 }.should_not raise_error
  end
  it 'should be absolute if constructed with a true third parameter' do
    direction = MoveToDirection.new(45, 50, true)
    direction.absolute?.should == true
  end
  it 'should not be absolute if constructed with a false third parameter' do
    direction = MoveToDirection.new(45, 50, false)
    direction.absolute?.should == false
  end
  it 'should not be absolute if constructed with only two parameters' do
    direction = MoveToDirection.new(45, 45)
    direction.absolute?.should == false
  end
  describe '#to_command' do
    it 'should start with a capital M when absolute' do
      (@abs_dir.to_command =~ /^M/).should_not be_nil
    end
    it 'should start with a lower-case m when not absolute' do
      (@nonabs_dir.to_command =~ /^m/).should_not be_nil
    end
    it 'should show the provided X value as the next parameter' do
      match = @nonabs_dir.to_command.match /^[a-zA-Z]([0-9]+(.[0-9]+)?)/
      match.should_not be_nil
      $1.to_f.should == 100
    end
    it 'should show the provided Y value as the final parameter' do
      match = @nonabs_dir.to_command.match /^[a-zA-Z]([0-9]+(.[0-9]+)?) ([0-9]+(.[0-9]+)?)$/
      match.should_not be_nil
      $3.to_f.should == 200
    end
  end
end
