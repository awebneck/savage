shared_examples "Direction" do
  include Command
  it 'should have a to_command method' do
    @dir.respond_to?(:to_command).should == true
  end
  it 'should have an absolute? method' do
    @dir.respond_to?(:absolute?).should == true
  end
  it 'should have a command_code method' do
    @dir.respond_to?(:command_code).should == true
  end
  describe '#to_command' do
    it "should start with the command\'s command code" do
      @dir.to_command[0,1].should == @dir.command_code
    end
    it 'should only have one alphabetical command code' do
      @dir.to_command.match(/[A-Za-z]/).size.should == 1
    end
  end
  describe '#command_code' do
    it 'should start with a lower-case letter when not absolute' do
      rel_dir = create_relative
      rel_dir.command_code.should == command_code.downcase
    end
    it 'should start with a capital letter when absolute' do
      @dir.command_code.should == command_code.upcase
    end
  end
end