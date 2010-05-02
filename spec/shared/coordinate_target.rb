share_as :CoordinateTargetShared do
  before :each do
    @dir = dir_class.new(100)
  end
  include DirectionShared
  it 'should have an accessible target, based on the constructor argument' do
    @dir.respond_to?(:target).should == true
    @dir.target.should == 100
  end
  it 'should be constructed with at least a target parameter' do
    lambda { dir_class.new }.should raise_error
    lambda { dir_class.new 45 }.should_not raise_error
    lambda { dir_class.new 45, true }.should_not raise_error
  end
  it 'should be relative if constructed with a false third parameter' do
    direction = dir_class.new(45, false)
    direction.absolute?.should == false
  end
  it 'should be absolute if constructed with a true third parameter' do
    direction = dir_class.new(45, true)
    direction.absolute?.should == true
  end
  it 'should be absolute if constructed with only two parameters' do
    direction = dir_class.new(45)
    direction.absolute?.should == true
  end
  describe '#to_command' do
    it 'should have exactly 1 numerical parameter' do
      extract_coordinates(@dir.to_command).length.should == 1
    end
    it 'should show the provided X value as the next parameter' do
      extract_coordinates(@dir.to_command)[0].should == 100
    end
  end
end