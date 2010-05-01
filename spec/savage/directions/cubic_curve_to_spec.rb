require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage

describe CubicCurveTo do
  def dir_class; CubicCurveTo; end
  def create_absolute; CubicCurveTo.new(100,200,300,400,500,600,true); end
  def command_code; 'c'; end
  
  before :each do
    @dir = dir_class.new(100,200,300,400,500,600)
  end
  
  include DirectionShared
  
  it 'should have a target' do
    @dir.respond_to?(:target).should == true
    @dir.target.class.should == Point
  end
  it 'should have a first control point' do
    @dir.respond_to?(:control_1).should == true
    @dir.control_1.class.should == Point
  end
  it 'should have a first control point' do
    @dir.respond_to?(:control_2).should == true
    @dir.control_2.class.should == Point
  end
  it 'should have an accessible target x, based on the constructor argument' do
    @dir.target.x.should == 500
  end
  it 'should have an accessible target y, based on the constructor argument' do
    @dir.target.y.should == 600
  end
  it 'should have an accessible first control x, based on the constructor argument' do
    @dir.control_1.x.should == 100
  end
  it 'should have an accessible first control y, based on the constructor argument' do
    @dir.control_1.y.should == 200
  end
  it 'should have an accessible second control x, based on the constructor argument' do
    @dir.control_2.x.should == 300
  end
  it 'should have an accessible second control y, based on the constructor argument' do
    @dir.control_2.y.should == 400
  end
  it 'should be constructed with at least target x and y, a control 1 x and y, and a control 2 x and y parameters' do
    lambda { dir_class.new }.should raise_error
    lambda { dir_class.new 45 }.should raise_error
    lambda { dir_class.new 45, 50 }.should raise_error
    lambda { dir_class.new 45, 50, 60 }.should raise_error
    lambda { dir_class.new 45, 50, 60, 70 }.should raise_error
    lambda { dir_class.new 45, 50, 60, 70, 80 }.should raise_error
    lambda { dir_class.new 45, 50, 60, 70, 80, 90 }.should_not raise_error
    lambda { dir_class.new 45, 50, 60, 70, 80, 90, true }.should_not raise_error
  end
  it 'should be absolute if constructed with a true seventh parameter' do
    direction = dir_class.new 45, 50, 60, 70, 80, 90, true
    direction.absolute?.should == true
  end
  it 'should not be absolute if constructed with a false seventh parameter' do
    direction = dir_class.new 45, 50, 60, 70, 80, 90, false
    direction.absolute?.should == false
  end
  it 'should not be absolute if constructed with only six parameters' do
    direction = dir_class.new 45, 50, 60, 70, 80, 90
    direction.absolute?.should == false
  end
  describe '#to_command' do
    it 'should have exactly 6 numerical parameters' do
      extract_coordinates(@dir.to_command).length.should == 6
    end
    it 'should show the provided control 1 X value as the first parameter' do
      extract_coordinates(@dir.to_command)[0].should == 100
    end
    it 'should show the provided control 1 Y value as the second parameter' do
      extract_coordinates(@dir.to_command)[1].should == 200
    end
    it 'should show the provided control 2 X value as the third parameter' do
      extract_coordinates(@dir.to_command)[2].should == 300
    end
    it 'should show the provided control 2 Y value as the fourth parameter' do
      extract_coordinates(@dir.to_command)[3].should == 400
    end
    it 'should show the provided target X value as the fifth parameter' do
      extract_coordinates(@dir.to_command)[4].should == 500
    end
    it 'should show the provided target Y value as the sixth parameter' do
      extract_coordinates(@dir.to_command)[5].should == 600
    end
  end
end