require_relative '../spec_helper'

include Savage

describe Transformable do
  it 'should apply to Path, SubPath and Direction' do
    [Path, SubPath, Direction, Directions::LineTo].each do |cls|
      expect(cls.ancestors).to include(Transformable)
      expect(cls.public_instance_methods).to include(:transform)
    end
  end

  describe 'fully transformable paths' do
  end

  describe Path do
    it 'can transform' do
      path = Parser.parse %Q{C211.003,239.997,253.003,197.997,304.003,197.997}
      path.scale( 0.5, -0.5 )
      path.translate( 0, 100 )
      path.to_command.should == "C105.5015-19.9985 126.5015 1.0015 152.0015 1.0015"
    end

    it 'should transform subpaths recursively' do
      path = Parser.parse('M 0 100 L 100 200 L 200 200 H 30 M 0 100 Z')
      path.translate( 100, -135 )
      path.subpaths.first.to_command.should == "M100-35 200 65 300 65 330 65"
      path.subpaths[1].to_command.should == "M100-35Z"
    end

    it 'should be not fully transformable with H/V directions' do
      path = Parser.parse('M 0 100 L 100 200 L 200 200 H 30 M 0 100 Z')
      path.fully_transformable?.should be_false
      path.to_transformable_commands!
    end

    it 'can transform relative Horizontal and Vertical subpaths' do
      path = Parser.parse('m 50 50 h 100 v 100 h -100 v -100')
      path.rotate( 90, 100, 100 )
      path.to_command.should == "M50-250l0-100 100 0 0 100-100 0"
    end

    it 'can transform absolute Horizontal and Vertical subpaths' do
      path = Parser.parse('M 50 50 H 150 V 150 H 50 V 50')
      path.rotate( 90, 100, 100 )
      path.to_command.should == "M50-250 50-400 150-350 150-250 50-250"
    end
  end

  describe SubPath do
    it 'should transfrom subpaths recursively' do
      path = Parser.parse('M 0 100 L 100 200 L 200 200 H 30 M 0 100 Z')
      subpath = path.subpaths.first
      subpath.translate( 10, 15 )
      subpath.directions.first.to_command.should == "M10 115"
      subpath.directions[1].to_command.should == "L110 215"
      subpath.directions[2].to_command.should == "L210 215"
      subpath.directions[3].to_command.should == "H40"
    end

    it 'can turn to fully transformable directions' do
      subpath = Parser.parse('m 50 50 h 100 v 100 h -100 v -100').subpaths.first
      subpath.fully_transformable?.should be_false

      subpath.to_transformable_commands!
      subpath.to_command.should == 'M50 50l100 0 0 100-100 0 0-100'

    end
  end

  describe Directions::LineTo do
    it 'could be translate' do
      x, y = 50, 80
      dir = Directions::LineTo.new(x, y)
      dir.translate( 130, 601 )
      dir.target.x.should == 180
      dir.target.y.should == 681
    end

    it 'should ignore translating if relative' do
      x, y = 50, 80
      dir = Directions::LineTo.new(x, y, false)
      dir.translate( 130, 601 )
      # notice: not changed
      dir.target.x.should == 50
      dir.target.y.should == 80
    end

    it 'could be rotated' do
      x, y = 50, 80
      dir = Directions::LineTo.new(x, y)
      dir.rotate(90)
      dir.target.x.should == 80
      dir.target.y.round.should == -50
    end
  end
end


