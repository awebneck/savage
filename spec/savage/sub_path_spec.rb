require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include Savage

describe SubPath do
  it 'should have a commands list' do
    SubPath.new.respond_to?(:commands).should == true
  end
  it 'should have a move_to method' do
    SubPath.new.respond_to?(:move_to).should == true
  end
  it 'should have a line_to method' do
    SubPath.new.respond_to?(:line_to).should == true
  end
  it 'should have a horizontal_to method' do
    SubPath.new.respond_to?(:horizontal_to).should == true
  end
  it 'should have a vertical_to method' do
    SubPath.new.respond_to?(:vertical_to).should == true
  end
  it 'should have a quadratic_curve_to method' do
    SubPath.new.respond_to?(:quadratic_curve_to).should == true
  end
  it 'should have a cubic_curve_to method' do
    SubPath.new.respond_to?(:cubic_curve_to).should == true
  end
  it 'should have a arc_to method' do
    SubPath.new.respond_to?(:arc_to).should == true
  end
  it 'should have a close_path method' do
    SubPath.new.respond_to?(:close_path).should == true
  end
  it 'should have a closed? method' do
    SubPath.new.respond_to?(:closed?).should == true
  end
  it 'should have a to_command method' do
    SubPath.new.respond_to?(:to_command).should == true
  end
  describe '#closed?' do
    it 'should be true if the last direction in the commands list is of type ClosePath' do
      path = SubPath.new
      path.move_to 100, 300
      path.line_to 243, 21
      path.close_path
      path.closed?.should == true
    end
    it 'should be false if the last direction in the commands list is of any other type or absent' do
      path = SubPath.new
      path.move_to 100, 300
      path.line_to 234, 21
      path.closed?.should == false
      path2 = SubPath.new
      path2.closed?.should == false
    end
  end
  describe '#to_command' do
    it 'should output the concatenation of all the subcommands if no two are the same in sequence' do
      path = SubPath.new
      path.move_to 100, 200
      path.horizontal_to -200
      path.quadratic_curve_to 342, -341.23, 405, 223
      path.line_to -342.002, 231.42
      path.close_path
      path.to_command.should == 'M100 200H-200Q342-341.23 405 223L-342.002 231.42Z'
    end
    it 'should strip the command code if the previous code was the same as the present' do
      path = SubPath.new
      com1 = path.move_to 100, 200
      com2 = path.horizontal_to -200
      com4 = path.line_to -342.002, 231.42
      com4 = path.line_to -234, 502
      path.to_command.should == 'M100 200H-200L-342.002 231.42-234 502'
    end
    it 'should strip the command code if the previous code was a MoveTo and the current code is a LineTo' do
      path = SubPath.new
      com1 = path.move_to 100, 200
      com4 = path.line_to -342.002, 231.42
      com4 = path.line_to -234, 502
      path.to_command.should == 'M100 200-342.002 231.42-234 502'
    end
  end
  describe 'move_to' do
    before :each do
      @path = SubPath.new
    end
    context 'when the command list is empty' do
      it 'should add a MoveTo command on to the commands list' do
        this_move = @path.move_to(100,200)
        @path.commands.should == [this_move]
      end
      it 'should return the newly created MoveTo command' do
        @path.move_to(100,200).class.should == Directions::MoveTo
      end
    end
    context 'when the command list is not empty' do
      it 'does something' do
        first_move = @path.move_to(200,400)
        @path.move_to(100,200)
        @path.commands.should == [first_move]
      end
      it 'should return nil' do
        @path.move_to(200,400)
        @path.move_to(100,200).nil?.should == true
      end
    end
  end
  describe '#commands' do
    it 'should be able to access items via the bracket operator' do
      SubPath.new.commands.respond_to?(:[]).should == true
    end
  end
end
