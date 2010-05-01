require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage::Directions

describe ArcTo do
  def dir_class; ArcTo; end
  def create_absolute; ArcTo.new(100,200,300,true,false,400,500,true); end
  def command_code; 'a'; end
  
  before :each do
    @dir = dir_class.new(100,200,300,true,false,400,500)
  end
  
  include DirectionShared
  
  it 'should have a target' do
    @dir.respond_to?(:target).should == true
    @dir.target.class.should == Point
  end
  it 'should have a radius' do
    @dir.respond_to?(:radius).should == true
    @dir.radius.class.should == Point
  end
  it 'should have a large arc based on the constructor argument' do
    @dir.respond_to?(:large_arc).should == true
    @dir.large_arc.should == true
  end
  it 'should have a sweep based on the constructor argument' do
    @dir.respond_to?(:sweep).should == true
    @dir.sweep.should == false
  end
  it 'should have a rotation based on the constructor arugment' do
    @dir.respond_to?(:rotation).should == true
    @dir.rotation.should == 300
  end
  it 'should have an accessible target x, based on the constructor argument' do
    @dir.target.x.should == 400
  end
  it 'should have an accessible target y, based on the constructor argument' do
    @dir.target.y.should == 500
  end
  it 'should have an accessible x radius, based on the constructor argument' do
    @dir.radius.x.should == 100
  end
  it 'should have an accessible y radius, based on the constructor argument' do
    @dir.radius.y.should == 200
  end
  it 'should be constructed with at least x and y radii, rotation, large arc, sweep, and target x and y parameters' do
    lambda { dir_class.new }.should raise_error
    lambda { dir_class.new 45 }.should raise_error
    lambda { dir_class.new 45, 50 }.should raise_error
    lambda { dir_class.new 45, 50, 60 }.should raise_error
    lambda { dir_class.new 45, 50, 60, true }.should raise_error
    lambda { dir_class.new 45, 50, 60, true, true }.should raise_error
    lambda { dir_class.new 45, 50, 60, true, true, 100 }.should raise_error
    lambda { dir_class.new 45, 50, 60, true, true, 100, 200 }.should_not raise_error
  end
  it 'should be absolute if constructed with a true eighth parameter' do
    direction = dir_class.new 45, 50, 60, true, true, 100, 200, true
    direction.absolute?.should == true
  end
  it 'should not be absolute if constructed with a false eighth parameter' do
    direction = dir_class.new 45, 50, 60, true, true, 100, 200, false
    direction.absolute?.should == false
  end
  it 'should not be absolute if constructed with only seven parameters' do
    direction = dir_class.new 45, 50, 60, true, true, 100, 200
    direction.absolute?.should == false
  end
  describe '#to_command' do
    it 'should have exactly 7 numerical parameters' do
      extract_coordinates(@dir.to_command).length.should == 7
    end
    it 'should show the provided x radius value as the first parameter' do
      extract_coordinates(@dir.to_command)[0].should == 100
    end
    it 'should show the provided y radius value as the second parameter' do
      extract_coordinates(@dir.to_command)[1].should == 200
    end
    it 'should show the provided rotation value as the third parameter' do
      extract_coordinates(@dir.to_command)[2].should == 300
    end
    it 'should show the integer interpretation of the provided large arc value as the fourth parameter' do
      extract_coordinates(@dir.to_command)[3].should == 1
    end
    it 'should show the integer interpretation of the provided sweep value as the fifth parameter' do
      extract_coordinates(@dir.to_command)[4].should == 0
    end
    it 'should show the provided target x value as the sixth parameter' do
      extract_coordinates(@dir.to_command)[5].should == 400
    end
    it 'should show the provided target y value as the seventh parameter' do
      extract_coordinates(@dir.to_command)[6].should == 500
    end
  end
end