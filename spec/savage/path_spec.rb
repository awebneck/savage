require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include Savage

describe Path do
  it 'should accept no parameters in a constructor for a new, empty path' do
    lambda{ Path.new }.should_not raise_error
  end
  it 'should be able to be constructed with a starting point (absolute move to)' do
    path = Path.new(100,200)
    path.subpaths.length.should == 1
    path.subpaths.last.directions.length.should == 1
    path.subpaths.last.directions.last.class.should == Directions::MoveTo
  end
  it 'should be able to build itself in a block' do
    path = Path.new(100,200) do |p|
      p.line_to 300, 400
      p.cubic_curve_to 500,600,700,800,900,1000
      p.arc_to 100,200,123,1,1,300,400
    end
    path.subpaths.last.directions[0].class.should == Directions::MoveTo
    path.subpaths.last.directions[1].class.should == Directions::LineTo
    path.subpaths.last.directions[2].class.should == Directions::CubicCurveTo
    path.subpaths.last.directions[3].class.should == Directions::ArcTo
    
    path2 = Path.new do |p|
      p.line_to 300, 400
      p.cubic_curve_to 500,600,700,800,900,1000
      p.arc_to 100,200,123,1,1,300,400
    end
    path2.subpaths.last.directions[0].class.should == Directions::LineTo
    path2.subpaths.last.directions[1].class.should == Directions::CubicCurveTo
    path2.subpaths.last.directions[2].class.should == Directions::ArcTo
  end
  it 'should have a directions list' do
    Path.new.respond_to?(:directions).should == true
  end
  it 'should have a move_to method' do
    Path.new.respond_to?(:move_to).should == true
  end
  it 'should have a line_to method' do
    Path.new.respond_to?(:line_to).should == true
  end
  it 'should have a horizontal_to method' do
    Path.new.respond_to?(:horizontal_to).should == true
  end
  it 'should have a vertical_to method' do
    Path.new.respond_to?(:vertical_to).should == true
  end
  it 'should have a quadratic_curve_to method' do
    Path.new.respond_to?(:quadratic_curve_to).should == true
  end
  it 'should have a cubic_curve_to method' do
    Path.new.respond_to?(:cubic_curve_to).should == true
  end
  it 'should have a arc_to method' do
    Path.new.respond_to?(:arc_to).should == true
  end
  it 'should have a close_path method' do
    Path.new.respond_to?(:close_path).should == true
  end
  it 'should have a closed? method' do
    Path.new.respond_to?(:closed?).should == true
  end
  it 'should have subpaths' do
    Path.new.respond_to?(:subpaths).should == true
  end
  it 'should have a to_command method' do
    Path.new.respond_to?(:to_command).should == true
  end
  describe '#move_to' do
    it 'should create a new subpath with that movement therein' do
      path = Path.new
      path.move_to(200,300)
      path.subpaths.length.should == 2
      path.subpaths.last.directions.length.should == 1
      path.subpaths.last.directions.last.class.should == Directions::MoveTo
    end
  end
  describe '#to_command' do
    it 'should concatenate all its subpaths command strings' do
      path = Path.new(100,200) do |p|
        p.line_to 300, 400
        p.cubic_curve_to 500,600,700,800,900,1000
        p.arc_to 100,200,123,1,1,300,400
        p.close_path
        p.move_to 499, 232
        p.line_to 2433.4, -231
        p.line_to -233, 122
      end
      concatenated = path.subpaths.collect { |subpath| subpath.to_command }.join
      path.to_command.should == concatenated
    end
  end
end