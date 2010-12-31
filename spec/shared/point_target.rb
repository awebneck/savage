share_as :PointTargetShared do
  before :each do
    @dir = dir_class.new(100,200)
  end
  include Command
  include DirectionShared
  it 'should have a target' do
    @dir.respond_to?(:target).should == true
    @dir.target.class.should == Point
  end
  it 'should have an accessible target x, based on the constructor argument' do
    @dir.target.x.should == 100
  end
  it 'should have an accessible target y, based on the constructor argument' do
    @dir.target.y.should == 200
  end
  it 'should be constructed with at least an x and y parameter' do
    lambda { dir_class.new }.should raise_error
    lambda { dir_class.new 45 }.should raise_error
    lambda { dir_class.new 45, 50 }.should_not raise_error
  end
  it 'should be relative if constructed with a false third parameter' do
    direction = dir_class.new(45, 50, false)
    direction.absolute?.should == false
  end
  it 'should be absolute if constructed with a true third parameter' do
    direction = dir_class.new(45, 50, true)
    direction.absolute?.should == true
  end
  it 'should be absolute if constructed with only two parameters' do
    direction = dir_class.new(45, 45)
    direction.absolute?.should == true
  end
  describe '#to_command' do
    it 'should have exactly 2 numerical parameters' do
      extract_coordinates(@dir.to_command).length.should == 2
    end
    it 'should show the provided X value as the next parameter' do
      extract_coordinates(@dir.to_command)[0].should == 100
    end
    it 'should show the provided Y value as the final parameter' do
      extract_coordinates(@dir.to_command)[1].should == 200
    end
  end
end
