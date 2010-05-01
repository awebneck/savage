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
