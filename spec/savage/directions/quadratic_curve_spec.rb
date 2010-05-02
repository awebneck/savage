require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage::Directions

describe QuadraticCurveTo do
  def dir_class; QuadraticCurveTo; end
  def create_relative; QuadraticCurveTo.new(100,200,300,400,false); end
  def command_code; 'q'; end
  
  before :each do
    @dir = dir_class.new(100,200,300,400)
  end
  
  include DirectionShared
  
  it 'should have a target' do
    @dir.respond_to?(:target).should == true
    @dir.target.class.should == Point
  end
  it 'should have a control point' do
    @dir.respond_to?(:control).should == true
    @dir.control.class.should == Point
  end
  it 'should have an accessible target x, based on the constructor argument' do
    @dir.target.x.should == 300
  end
  it 'should have an accessible target y, based on the constructor argument' do
    @dir.target.y.should == 400
  end
  it 'should have an accessible first control x, based on the constructor argument' do
    @dir.control.x.should == 100
  end
  it 'should have an accessible first control y, based on the constructor argument' do
    @dir.control.y.should == 200
  end
  it 'should be constructed with at least target x and y, a control 1 x and y, and a control 2 x and y parameters' do
    lambda { dir_class.new }.should raise_error
    lambda { dir_class.new 45 }.should raise_error
    lambda { dir_class.new 45, 50 }.should raise_error
    lambda { dir_class.new 45, 50, 60 }.should raise_error
    lambda { dir_class.new 45, 50, 60, 70 }.should_not raise_error
    lambda { dir_class.new 45, 50, 60, 70, true }.should_not raise_error
  end
  it 'should be relative if constructed with a false fifth parameter' do
    direction = dir_class.new 45, 50, 60, 70, false
    direction.absolute?.should == false
  end
  it 'should be absolute if constructed with a true fifth parameter' do
    direction = dir_class.new 45, 50, 60, 70, true
    direction.absolute?.should == true
  end
  it 'should be absolute if constructed with only four parameters' do
    direction = dir_class.new 45, 50, 60, 70
    direction.absolute?.should == true
  end
  describe '#to_command' do
    it 'should start with a capital T when not absolute' do
      rel_dir = create_relative
      extract_command(rel_dir.to_command(true)).should == 't'
    end
    it 'should start with a lower-case t when absolute' do
      extract_command(@dir.to_command(true)).should == 'T'
    end
    it 'should have exactly 4 numerical parameters' do
      extract_coordinates(@dir.to_command).length.should == 4
    end
    it 'should show the provided control X value as the first parameter' do
      extract_coordinates(@dir.to_command)[0].should == 100
    end
    it 'should show the provided control Y value as the second parameter' do
      extract_coordinates(@dir.to_command)[1].should == 200
    end
    it 'should show the provided target X value as the third parameter' do
      extract_coordinates(@dir.to_command)[2].should == 300
    end
    it 'should show the provided target Y value as the fourth parameter' do
      extract_coordinates(@dir.to_command)[3].should == 400
    end
  end
end