module Savage
  class Parser
    class << self
      def parse(parsable)
        raise TypeError if parsable.class != String
        subpaths = extract_subpaths parsable
        raise TypeError if (subpaths.empty?)
        path = Path.new
        path.subpaths = []
        subpaths.each_with_index do |subpath, i|
          path.subpaths << parse_subpath(subpath, i == 0)
        end
        path
      end
      
      private
        def extract_subpaths(parsable)
          subpaths = []
          if move_index = parsable.index(/[Mm]/)
            subpaths << parsable[0...move_index] if move_index > 0
            parsable.scan(/[Mm](?:\d|[eE.,+-]|[LlHhVvQqCcTtSsAaZz]|\W)+/m) do |match_group|
              subpaths << $&
            end
          else
            subpaths << parsable
          end
          subpaths
        end
        
        def parse_subpath(parsable, force_absolute=false)
          subpath = SubPath.new
          subpath.directions = extract_directions parsable, force_absolute
          subpath
        end
        
        def extract_directions(parsable, force_absolute=false)
          directions = []
          i = 0
          parsable.scan(/[MmLlHhVvQqCcTtSsAaZz](?:\d|[eE.,+-]|\W)*/m) do |match_group|
            direction = build_direction $&, force_absolute && i == 0
            if direction.kind_of?(Array)
              directions.concat direction
            else
              directions << direction
            end
            i += 1
          end
          directions
        end

        def build_move_to(absolute)
          x = @coordinates.shift
          y = @coordinates.shift
          raise TypeError if [x, y].any?(&:nil?)
          Directions::MoveTo.new(x, y, absolute)
        end

        def build_line_to(absolute)
          x = @coordinates.shift
          y = @coordinates.shift
          raise TypeError if [x, y].any?(&:nil?)
          Directions::LineTo.new(x, y, absolute)
        end

        def build_horizontal_to(absolute)
          target = @coordinates.shift
          raise TypeError if target.nil?
          Directions::HorizontalTo.new(target, absolute)
        end

        def build_vertical_to(absolute)
          target = @coordinates.shift
          raise TypeError if target.nil?
          Directions::VerticalTo.new(target, absolute)
        end

        def build_cubic_to(absolute)
          control_1_x = @coordinates.shift
          control_1_y = @coordinates.shift
          control_2_x = @coordinates.shift
          control_2_y = @coordinates.shift
          x = @coordinates.shift
          y = @coordinates.shift
          raise TypeError if [x, y, control_1_x, control_1_y, control_2_x, control_2_y].any?(&:nil?)
          Directions::CubicCurveTo.new(control_1_x, control_1_y, control_2_x, control_2_y, x, y, absolute)
        end

        def build_simple_cubic_to(absolute)
          control_2_x = @coordinates.shift
          control_2_y = @coordinates.shift
          x = @coordinates.shift
          y = @coordinates.shift
          raise TypeError if [x, y, control_2_x, control_2_y].any?(&:nil?)
          Directions::CubicCurveTo.new(control_2_x, control_2_y, x, y, absolute)
        end

        def build_quadratic_to(absolute)
          control_x = @coordinates.shift
          control_y = @coordinates.shift
          x = @coordinates.shift
          y = @coordinates.shift
          raise TypeError if [x, y, control_x, control_y].any?(&:nil?)
          Directions::QuadraticCurveTo.new(control_x, control_y, x, y, absolute)
        end

        def build_simple_quadratic_to(absolute)
          x = @coordinates.shift
          y = @coordinates.shift
          raise TypeError if [x, y].any?(&:nil?)
          Directions::QuadraticCurveTo.new(x, y, absolute)
        end

        def build_arc_to(absolute)
          rx = @coordinates.shift
          ry = @coordinates.shift
          rotation = @coordinates.shift
          large_arc = @coordinates.shift > 0
          sweep = @coordinates.shift > 0
          x = @coordinates.shift
          y = @coordinates.shift
          raise TypeError if [x, y, rx, ry, rotation].any?(&:nil?)
          Directions::ArcTo.new(rx, ry, rotation, large_arc, sweep, x, y, absolute)
        end
        
        def build_direction(parsable, force_absolute=false)
          directions = []
          @coordinates = extract_coordinates parsable
          recurse_code = parsable[0,1]
          first_absolute = force_absolute
          
          # we need to handle this separately, since ClosePath doesn't take any coordinates
          if @coordinates.empty? && recurse_code =~ /[Zz]/
            directions << Directions::ClosePath.new(parsable[0,1] == parsable[0,1].upcase)
          end
          
          until @coordinates.empty?
            absolute = (first_absolute || parsable[0,1] == parsable[0,1].upcase)
            direction = case recurse_code
            when /[Mm]/
              recurse_code = 'L'
              build_move_to absolute
            when /[Ll]/
              build_line_to absolute
            when /[Hh]/
              build_horizontal_to absolute
            when /[Vv]/
              build_vertical_to absolute
            when /[Cc]/
              build_cubic_to absolute
            when /[Ss]/
              build_simple_cubic_to absolute
            when /[Qq]/
              build_quadratic_to absolute
            when /[Tt]/
              build_simple_quadratic_to absolute
            when /[Aa]/
              build_arc_to absolute
            when /[^MmLlHhVvCcSsQqTtAaZz]/
              @coordinates = []
              raise TypeError
            end
            directions << direction
            first_absolute = false
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
