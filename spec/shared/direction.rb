share_as :DirectionShared do
  it 'should have a to_command method' do
    @dir.respond_to?(:to_command).should == true
  end
  it 'should have an absolute? method' do
    @dir.respond_to?(:absolute?).should == true
  end
end

share_as :TargetedShared do
  it 'should have an accessible target x, based on the constructor argument' do
    @dir.respond_to?(:target_x).should == true
    @dir.target_x.should == 100
  end
  it 'should have an accessible target y, based on the constructor argument' do
    @dir.respond_to?(:target_y).should == true
    @dir.target_y.should == 200
  end
end