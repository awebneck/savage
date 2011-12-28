module Savage
  class Parser
    class << self
      def parse(parsable)
        raise TypeError if parsable.class != String
        subpaths = extract_subpaths parsable
        raise TypeError if (subpaths.empty?)
        path = Path.new
        path.subpaths = []
        subpaths.each do |subpath|
          path.subpaths << parse_subpath(subpath)
        end
        path
      end
      
      private
        def extract_subpaths(parsable)
          subpaths = []
          if move_index = parsable.index(/[Mm]/)
            subpaths << parsable[0...move_index] if move_index > 0
            parsable.scan /[Mm](?:\d|[eE.,+-]|[LlHhVvQqCcTtSsAaZz]|\W)+/m do |match_group|
              subpaths << $&
            end
          else
            subpaths << parsable
          end
          subpaths
        end
        
        def parse_subpath(parsable)
          subpath = SubPath.new
          subpath.directions = extract_directions parsable
          subpath
        end
        
        def extract_directions(parsable)
          directions = []
          parsable.scan /[MmLlHhVvQqCcTtSsAaZz](?:\d|[eE.,+-]|\W)*/m do |match_group|
            direction = build_direction $&
            if direction.kind_of?(Array)
              directions.concat direction
            else
              directions << direction
            end
          end
          directions
        end
        
        def build_direction(parsable)
          directions = []
          coordinates = extract_coordinates parsable
          absolute = (parsable[0,1] == parsable[0,1].upcase) ? true : false
          recurse_code = parsable[0,1]
          
          # we need to handle this separately, since ClosePath doesn't take any coordinates
          if coordinates.empty? && recurse_code =~ /[Zz]/
            directions << Directions::ClosePath.new(absolute)
          end
          
          until coordinates.empty?
            case recurse_code
            when /[Mm]/
              x = coordinates.shift
              y = coordinates.shift
              raise TypeError if x.nil? || y.nil?
              directions << Directions::MoveTo.new(x,y,absolute)
              recurse_code = 'L'
            when /[Ll]/
              x = coordinates.shift
              y = coordinates.shift
              raise TypeError if x.nil? || y.nil?
              directions << Directions::LineTo.new(x,y,absolute)
            when /[Hh]/
              target = coordinates.shift
              raise TypeError if target.nil?
              directions << Directions::HorizontalTo.new(target,absolute)
            when /[Vv]/
              target = coordinates.shift
              raise TypeError if target.nil?
              directions << Directions::VerticalTo.new(target,absolute)
            when /[Cc]/
              control_1_x = coordinates.shift
              control_1_y = coordinates.shift
              control_2_x = coordinates.shift
              control_2_y = coordinates.shift
              x = coordinates.shift
              y = coordinates.shift
              raise TypeError if x.nil? || y.nil? || control_1_x.nil? || control_1_y.nil? || control_2_x.nil? || control_2_y.nil?
              directions << Directions::CubicCurveTo.new(control_1_x,control_1_y,control_2_x,control_2_y,x,y,absolute)
            when /[Ss]/
              control_2_x = coordinates.shift
              control_2_y = coordinates.shift
              x = coordinates.shift
              y = coordinates.shift
              raise TypeError if x.nil? || y.nil? || control_2_x.nil? || control_2_y.nil?
              directions << Directions::CubicCurveTo.new(control_2_x,control_2_y,x,y,absolute)
            when /[Qq]/
              control_x = coordinates.shift
              control_y = coordinates.shift
              x = coordinates.shift
              y = coordinates.shift
              raise TypeError if x.nil? || y.nil? || control_x.nil? || control_y.nil?
              directions << Directions::QuadraticCurveTo.new(control_x,control_y,x,y,absolute)
            when /[Tt]/
              x = coordinates.shift
              y = coordinates.shift
              raise TypeError if x.nil? || y.nil?
              directions << Directions::QuadraticCurveTo.new(x,y,absolute)
            when /[Aa]/
              rx = coordinates.shift
              ry = coordinates.shift
              rotation = coordinates.shift
              large_arc = (coordinates.shift > 0) ? true : false
              sweep = (coordinates.shift > 0) ? true : false
              x = coordinates.shift
              y = coordinates.shift
              raise TypeError if x.nil? || y.nil? || rx.nil? || ry.nil? || rotation.nil?
              directions << Directions::ArcTo.new(rx,ry,rotation,large_arc,sweep,x,y,absolute)
            when /[^MmLlHhVvCcSsQqTtAaZz]/
              coordinates = []
              raise TypeError
            end
          end
          
          directions
        end
        
        def extract_coordinates(command_string)
          coordinates = []
          command_string.scan(/-?\d+(\.\d+)?([eE][+-]?\d+)?/) do |match_group|
            coordinates << $&.to_f
          end
          coordinates
        end
    end
  end
end
