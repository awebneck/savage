require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage::Directions

describe CubicCurveTo do
  def dir_class; CubicCurveTo; end
  def create_relative; CubicCurveTo.new(100,200,300,400,500,600,false); end
  def command_code; 'c'; end

  before :each do
    @dir = dir_class.new(100,200,300,400,500,600)
  end

  include Command
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
    @dir.target.x.should == 500
  end
  it 'should have an accessible target y, based on the constructor argument' do
    @dir.target.y.should == 600
  end
  it 'should have an accessible second control x, based on the constructor argument' do
    @dir.control_2.x.should == 300
  end
  it 'should have an accessible second control y, based on the constructor argument' do
    @dir.control_2.y.should == 400
  end
  context 'when in verbose format' do
    it 'should be constructed with at least target x and y, control 1 x and y, and control 2 x and y parameters' do
      lambda { dir_class.new }.should raise_error
      lambda { dir_class.new 45 }.should raise_error
      lambda { dir_class.new 45, 50 }.should raise_error
      lambda { dir_class.new 45, 50, 60 }.should raise_error
      lambda { dir_class.new 45, 50, 60, 70, 80 }.should raise_error
      lambda { dir_class.new 45, 50, 60, 70, 80, 90 }.should_not raise_error
      lambda { dir_class.new 45, 50, 60, 70, 80, 90, true }.should_not raise_error
    end
    it 'should be relative if constructed with a false seventh parameter' do
      direction = dir_class.new 45, 50, 60, 70, 80, 90, false
      direction.absolute?.should == false
    end
    it 'should be absolute if constructed with a true seventh parameter' do
      direction = dir_class.new 45, 50, 60, 70, 80, 90, true
      direction.absolute?.should == true
    end
    it 'should be absolute if constructed with only six parameters' do
      direction = dir_class.new 45, 50, 60, 70, 80, 90
      direction.absolute?.should == true
    end
    it 'should have an accessible first control x, based on the constructor argument' do
      @dir.control_1.x.should == 100
    end
    it 'should have an accessible first control y, based on the constructor argument' do
      @dir.control_1.y.should == 200
    end
    describe '#to_command' do
      it 'should start with a lower-case c when not absolute' do
        extract_command(CubicCurveTo.new(100,200,300,400,500,600,false).to_command).should == 'c'
      end
      it 'should start with a capital C when absolute' do
        extract_command(@dir.to_command).should == 'C'
      end
      it 'should have exactly 6 numerical parameters' do
        extract_coordinates(@dir.to_command).length.should == 6
      end
      it 'should show the provided first control X value as the first parameter' do
        extract_coordinates(@dir.to_command)[0].should == 100
      end
      it 'should show the provided first control Y value as the second parameter' do
        extract_coordinates(@dir.to_command)[1].should == 200
      end
      it 'should show the provided second control X value as the third parameter' do
        extract_coordinates(@dir.to_command)[2].should == 300
      end
      it 'should show the provided second control Y value as the fourth parameter' do
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
  context 'when in shorthand format' do
    before :each do
      @dir = CubicCurveTo.new(100,200,300,400)
    end
    it 'should be constructed with at least target x and y parameters' do
      lambda { dir_class.new }.should raise_error
      lambda { dir_class.new 45 }.should raise_error
      lambda { dir_class.new 45, 50 }.should raise_error
      lambda { dir_class.new 45, 50, 60 }.should raise_error
      lambda { dir_class.new 45, 50, 60, 70 }.should_not raise_error
      lambda { dir_class.new 45, 50, 60, 70, true }.should_not raise_error
    end
    it 'should be relative if constructed with a false third parameter' do
      direction = dir_class.new 45, 50, 60, 70, false
      direction.absolute?.should == false
    end
    it 'should be absolute if constructed with a true third parameter' do
      direction = dir_class.new 45, 50, 60, 70, true
      direction.absolute?.should == true
    end
    it 'should be absolute if constructed with only two parameters' do
      direction = dir_class.new 45, 50, 60, 70
      direction.absolute?.should == true
    end
    it 'should have an nil first control, based on the constructor argument' do
      @dir.control_1.should == nil
    end
    describe '#to_command' do
      it 'should start with a lower-case s when not absolute' do
        extract_command(CubicCurveTo.new(100,200,300,400,false).to_command).should == 's'
      end
      it 'should start with a capital S when absolute' do
        extract_command(@dir.to_command).should == 'S'
      end
      it 'should have exactly 2 numerical parameters' do
        extract_coordinates(@dir.to_command).length.should == 4
      end
      it 'should show the provided second control X value as the first parameter' do
        extract_coordinates(@dir.to_command)[0].should == 100
      end
      it 'should show the provided second control Y value as the second parameter' do
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
end
