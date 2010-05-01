share_as :DirectionShared do
  include Command
  it 'should have a to_command method' do
    @dir.respond_to?(:to_command).should == true
  end
  it 'should have an absolute? method' do
    @dir.respond_to?(:absolute?).should == true
  end
  describe '#to_command' do
    it 'should start with a capital letter when absolute' do
      abs_dir = create_absolute
      extract_command(abs_dir.to_command).should == command_code.upcase
    end
    it 'should start with a lower-case letter when not absolute' do
      extract_command(@dir.to_command).should == command_code
    end
    it 'should only have one alphabetical command code' do
      @dir.to_command.match(/[A-Za-z]/).size.should == 1
    end
  end
end