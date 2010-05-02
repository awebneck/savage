require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include Savage

describe SubPath do
  it 'should have a directions list' do
    SubPath.new.respond_to?(:directions).should == true
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
  it 'should be able to be constructed empty' do
    lambda { SubPath.new }.should_not raise_error
  end
  it 'should be able to be constructed with a starting point (absolute move to)' do
    path = SubPath.new(100,200)
    path.directions.length.should == 1
    path.directions.last.class.should == Directions::MoveTo
  end
  it 'should be able to build itself in a block' do
    path = SubPath.new(100,200) do |p|
      p.line_to 300, 400
      p.cubic_curve_to 500,600,700,800,900,1000
      p.arc_to 100,200,123,1,1,300,400
    end
    path.directions[0].class.should == Directions::MoveTo
    path.directions[1].class.should == Directions::LineTo
    path.directions[2].class.should == Directions::CubicCurveTo
    path.directions[3].class.should == Directions::ArcTo
    
    path2 = SubPath.new do |p|
      p.line_to 300, 400
      p.cubic_curve_to 500,600,700,800,900,1000
      p.arc_to 100,200,123,1,1,300,400
    end
    path2.directions[0].class.should == Directions::LineTo
    path2.directions[1].class.should == Directions::CubicCurveTo
    path2.directions[2].class.should == Directions::ArcTo
  end
  describe '#closed?' do
    it 'should be true if the last direction in the directions list is of type ClosePath' do
      path = SubPath.new
      path.move_to 100, 300
      path.line_to 243, 21
      path.close_path
      path.closed?.should == true
    end
    it 'should be false if the last direction in the directions list is of any other type or absent' do
      path = SubPath.new
      path.move_to 100, 300
      path.line_to 234, 21
      path.closed?.should == false
      path2 = SubPath.new
      path2.closed?.should == false
    end
  end
  describe '#to_command' do
    before :each do
      @path = SubPath.new
      @dir_1 = @path.move_to 100, 200
    end
    it 'should output the concatenation of all the subdirections if no two are the same in sequence' do
      dir_2 = @path.horizontal_to -200
      dir_3 = @path.quadratic_curve_to 342, -341.23, 405, 223
      dir_4 = @path.line_to -342.002, 231.42
      dir_5 = @path.close_path
      @path.to_command.should == @dir_1.to_command << dir_2.to_command << dir_3.to_command << dir_4.to_command << dir_5.to_command
    end
    it 'should strip the command code if the previous code was the same as the present' do
      dir_2 = @path.horizontal_to -200
      dir_3 = @path.line_to -342.002, 231.42
      dir_4 = @path.line_to -234, 502
      @path.to_command.should == @dir_1.to_command << dir_2.to_command << dir_3.to_command << dir_4.to_command[1..-1]
    end
    it 'should not strip the command code if the previous code was the same as the present, but of different absoluteness' do
      dir_2 = @path.horizontal_to -200
      dir_3 = @path.line_to -342.002, 231.42
      dir_4 = @path.line_to -234, 502, false
      @path.to_command.should == @dir_1.to_command << dir_2.to_command << dir_3.to_command << dir_4.to_command
    end
    it 'should strip the command code if the previous code was a MoveTo and the current code is an absolute LineTo' do
      dir_2 = @path.line_to -342.002, 231.42
      dir_3 = @path.line_to -234, 502
      @path.to_command.should == @dir_1.to_command << dir_2.to_command[1..-1] << dir_3.to_command[1..-1]
    end
    it 'should not strip the command code if the previous code was a MoveTo and the current code is a relative LineTo' do
      dir_2 = @path.line_to -342.002, 231.42, false
      dir_3 = @path.line_to -234, 502
      @path.to_command.should == @dir_1.to_command << dir_2.to_command << dir_3.to_command
    end
    it 'should add leading whitespace if the first coordinate of the code-stripped direction is not negative' do
      dir_2 = @path.horizontal_to -200
      dir_3 = @path.line_to -342.002, 231.42
      dir_4 = @path.line_to 234, 502
      @path.to_command.should == @dir_1.to_command << dir_2.to_command << dir_3.to_command << dir_4.to_command[1..-1].insert(0,' ')
    end
  end
  describe '#move_to' do
    before :each do
      @path = SubPath.new
    end
    context 'when the command list is empty' do
      it 'should add a MoveTo command on to the directions list' do
        this_move = @path.move_to(100,200)
        @path.directions.should == [this_move]
      end
      it 'should return the newly created MoveTo command' do
        @path.move_to(100,200).class.should == Directions::MoveTo
      end
    end
    context 'when the command list is not empty' do
      it 'does something' do
        first_move = @path.move_to(200,400)
        @path.move_to(100,200)
        @path.directions.should == [first_move]
      end
      it 'should return nil' do
        @path.move_to(200,400)
        @path.move_to(100,200).nil?.should == true
      end
    end
  end
  describe '#directions' do
    it 'should be able to access items via the bracket operator' do
      SubPath.new.directions.respond_to?(:[]).should == true
    end
  end
end
