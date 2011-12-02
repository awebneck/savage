require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include Savage

describe Parser do
  it 'should have a parse method' do
    Parser.respond_to?(:parse).should == true
  end
  describe '.parse' do
    it 'should accept a single string as argument' do
      lambda { Parser.parse }.should raise_error
      lambda { Parser.parse("M100 200") }.should_not raise_error
      lambda { Parser.parse(2) }.should raise_error
    end
    it 'should return a path object with one subpath containing one move_to when the string is only a move_to command' do
      path = Parser.parse("M100 200")
      path.class.should == Path
      path.subpaths.length.should == 1
      path.subpaths.last.directions.length.should == 1
      path.subpaths.last.directions.last.class.should == Directions::MoveTo
    end
    
    it 'should handle comma separated coordinates' do
      path = Parser.parse("M100,200")
      path.class.should == Path
      path.subpaths.length.should == 1
      path.subpaths.last.directions.length.should == 1
      path.subpaths.last.directions.last.class.should == Directions::MoveTo
    end
    
    it 'should return a path object with one subpath containing a move_to and a line_to when the string is a move_to command followed by a line_to command' do
      path = Parser.parse("M100 200l-342.65 21")
      path.class.should == Path
      path.subpaths.length.should == 1
      path.subpaths.last.directions.length.should == 2
      path.subpaths.last.directions[0].class.should == Directions::MoveTo
      path.subpaths.last.directions[1].should_not be_absolute
      path.subpaths.last.directions[1].class.should == Directions::LineTo
    end
    it 'should return a path object with one subpath containing a move_to and a horizontal_to when the string is a move_to command followed by a horizontal_to command' do
      path = Parser.parse("M100 200H-342.65")
      path.class.should == Path
      path.subpaths.length.should == 1
      path.subpaths.last.directions.length.should == 2
      path.subpaths.last.directions[0].class.should == Directions::MoveTo
      path.subpaths.last.directions[1].class.should == Directions::HorizontalTo
    end
    it 'should return a path object with one subpath containing a move_to and a vertical_to when the string is a move_to command followed by a vertical_to command' do
      path = Parser.parse("M100 200V-342.65")
      path.class.should == Path
      path.subpaths.length.should == 1
      path.subpaths.last.directions.length.should == 2
      path.subpaths.last.directions[0].class.should == Directions::MoveTo
      path.subpaths.last.directions[1].class.should == Directions::VerticalTo
    end
    it 'should return a path object with one subpath containing a move_to and a full cubic_curve_to when the string is a move_to command followed by a full cubic_curve_to command' do
      path = Parser.parse("M100 200C-342.65-32 1.233-34 255 12")
      path.class.should == Path
      path.subpaths.length.should == 1
      path.subpaths.last.directions.length.should == 2
      path.subpaths.last.directions[0].class.should == Directions::MoveTo
      path.subpaths.last.directions[1].class.should == Directions::CubicCurveTo
      path.subpaths.last.directions[1].command_code.should == 'C'
    end
    it 'should return a path object with one subpath containing a move_to and a short cubic_curve_to when the string is a move_to command followed by a short cubic_curve_to command' do
      path = Parser.parse("M100 200S1.233-34 255 12")
      path.class.should == Path
      path.subpaths.length.should == 1
      path.subpaths.last.directions.length.should == 2
      path.subpaths.last.directions[0].class.should == Directions::MoveTo
      path.subpaths.last.directions[1].class.should == Directions::CubicCurveTo
      path.subpaths.last.directions[1].command_code.should == 'S'
    end
    it 'should return a path object with one subpath containing a move_to and a full quadratic_curve_to when the string is a move_to command followed by a full quadratic_curve_to command' do
      path = Parser.parse("M100 200Q1.233-34 255 12")
      path.class.should == Path
      path.subpaths.length.should == 1
      path.subpaths.last.directions.length.should == 2
      path.subpaths.last.directions[0].class.should == Directions::MoveTo
      path.subpaths.last.directions[1].class.should == Directions::QuadraticCurveTo
      path.subpaths.last.directions[1].command_code.should == 'Q'
    end
    it 'should return a path object with one subpath containing a move_to and a short quadratic_curve_to when the string is a move_to command followed by a short quadratic_curve_to command' do
      path = Parser.parse("M100 200T255 12")
      path.class.should == Path
      path.subpaths.length.should == 1
      path.subpaths.last.directions.length.should == 2
      path.subpaths.last.directions[0].class.should == Directions::MoveTo
      path.subpaths.last.directions[1].class.should == Directions::QuadraticCurveTo
      path.subpaths.last.directions[1].command_code.should == 'T'
    end
    it 'should return a path object with one subpath containing a move_to and an arc_to when the string is a move_to command followed by an arc_to command' do
      path = Parser.parse("M100 200A255 12-123 1 0 23-93.4")
      path.class.should == Path
      path.subpaths.length.should == 1
      path.subpaths.last.directions.length.should == 2
      path.subpaths.last.directions[0].class.should == Directions::MoveTo
      path.subpaths.last.directions[1].class.should == Directions::ArcTo
      path.subpaths.last.directions[1].command_code.should == 'A'
    end
    it 'should return a path object with one subpath containing a move_to, a line_to, and a close_path command when the string is a move_to command followed by a line_to followed by a close_path command' do
      path = Parser.parse("M100 200l-342.65 21Z")
      path.class.should == Path
      path.subpaths.length.should == 1
      path.subpaths.last.directions.length.should == 3
      path.subpaths.last.directions[0].class.should == Directions::MoveTo
      path.subpaths.last.directions[1].class.should == Directions::LineTo
      path.subpaths.last.directions[2].class.should == Directions::ClosePath
      path.subpaths.last.closed?.should == true
    end
    
    it 'should return a path object with one subpath containing two line_to directions when the string is a line_to command followed by implicit coordinates' do
      path = Parser.parse("L100 200 300 400")
      path.class.should == Path
      path.subpaths.length.should == 1
      path.subpaths.last.directions.length.should == 2
      path.subpaths.last.directions[0].class.should == Directions::LineTo
      path.subpaths.last.directions[0].target.x.should == 100
      path.subpaths.last.directions[0].target.y.should == 200
      path.subpaths.last.directions[1].class.should == Directions::LineTo
      path.subpaths.last.directions[1].target.x.should == 300
      path.subpaths.last.directions[1].target.y.should == 400
    end
    it 'should return a path object with one subpath containing two line_to directions when the string is a line_to command followed by implicit coordinates' do
      path = Parser.parse("L100 200 300 400")
      path.class.should == Path
      path.subpaths.length.should == 1
      path.subpaths.last.directions.length.should == 2
      path.subpaths.last.directions[0].class.should == Directions::LineTo
      path.subpaths.last.directions[0].target.x.should == 100
      path.subpaths.last.directions[0].target.y.should == 200
      path.subpaths.last.directions[1].class.should == Directions::LineTo
      path.subpaths.last.directions[1].target.x.should == 300
      path.subpaths.last.directions[1].target.y.should == 400
    end
    it 'should return a path object with one subpath containing a move_to and a line_to direction when the string is a move_to command followed by implicit coordinates' do
      path = Parser.parse("M100 200 300 400")
      path.class.should == Path
      path.subpaths.length.should == 1
      path.subpaths.last.directions.length.should == 2
      path.subpaths.last.directions[0].class.should == Directions::MoveTo
      path.subpaths.last.directions[0].target.x.should == 100
      path.subpaths.last.directions[0].target.y.should == 200
      path.subpaths.last.directions[1].class.should == Directions::LineTo
      path.subpaths.last.directions[1].target.x.should == 300
      path.subpaths.last.directions[1].target.y.should == 400
    end
    it 'should return a path object with one subpath containing a move_to and two line_to directions when the string is a move_to command followed by more than one set of implicit coordinates' do
      path = Parser.parse("M100 200 300 400 500 600 ")
      path.class.should == Path
      path.subpaths.length.should == 1
      path.subpaths.last.directions.length.should == 3
      path.subpaths.last.directions[0].class.should == Directions::MoveTo
      path.subpaths.last.directions[0].target.x.should == 100
      path.subpaths.last.directions[0].target.y.should == 200
      path.subpaths.last.directions[1].class.should == Directions::LineTo
      path.subpaths.last.directions[1].target.x.should == 300
      path.subpaths.last.directions[1].target.y.should == 400
      path.subpaths.last.directions[2].class.should == Directions::LineTo
      path.subpaths.last.directions[2].target.x.should == 500
      path.subpaths.last.directions[2].target.y.should == 600
    end
    it 'should return a path object with two subpaths containing one line_to directions each when the string is two move_to commands each followed by a line_to command' do
      path = Parser.parse("M100 200 332 -12.3M594 230-423 11.1")
      path.class.should == Path
      path.subpaths.length.should == 2
      path.subpaths[0].directions.length.should == 2
      path.subpaths[0].directions[0].class.should == Directions::MoveTo
      path.subpaths[0].directions[0].target.x.should == 100
      path.subpaths[0].directions[0].target.y.should == 200
      path.subpaths[0].directions[1].class.should == Directions::LineTo
      path.subpaths[0].directions[1].target.x.should == 332
      path.subpaths[0].directions[1].target.y.should == -12.3
      path.subpaths[1].directions[0].class.should == Directions::MoveTo
      path.subpaths[1].directions[0].target.x.should == 594
      path.subpaths[1].directions[0].target.y.should == 230
      path.subpaths[1].directions[1].class.should == Directions::LineTo
      path.subpaths[1].directions[1].target.x.should == -423
      path.subpaths[1].directions[1].target.y.should == 11.1
    end
    it 'should generate the same string given to it (assuming float values are used), if not changed in the interim' do
      path_string = "M100.0 200.0A255.0 12.0-123.0 1 0 23.0-93.4L100.0 200.0 300.0 400.0Q1.233-34.0 255.0 12.0T255.0 12.0H-342.65Z"
      path = Parser.parse(path_string)
      path.to_command.should == path_string
    end
    
    it "should be able to parse complex paths" do
      path = Parser.parse("M74.89,146.249c0.042,0.552,0.376,0.685,0.744,0.293m50.543-9.1323c15.445-16.43,32.782-32.859,49.793-49.289		c-6.298,0.001-12.595,0.001-18.893,0c-10.813,10.37-21.759,20.737-32.275,31.107C74.249,134.323,74.424,140.285,74.89,146.249z")
      path.class.should == Path
      path.subpaths.length.should == 2
      path.subpaths[0].directions.length.should == 2
      path.subpaths[1].directions.length.should == 6
    end
		
		it "should support scienfitic notation in paths (eg. 2e-5)" do
			# this is a 100x100 square
			path = Parser.parse "M 0,0 L 1e2,0 100,1000e-1 L 0,100"
			points = path.directions.map{|d| [d.target.x, d.target.y] }
			points.should == [[0.0, 0.0], [100.0, 0.0], [100.0, 100.0], [0.0, 100.0]]
		end
  end
end
