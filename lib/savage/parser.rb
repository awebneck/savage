module Savage
  class Parser
    DIRECTIONS = {
      :m => {:class => Directions::MoveTo,
             :args => 2},
      :l => {:class => Directions::LineTo,
             :args => 2},
      :h => {:class => Directions::HorizontalTo,
             :args => 1},
      :v => {:class => Directions::VerticalTo,
             :args => 1},
      :c => {:class => Directions::CubicCurveTo,
             :args => 6},
      :s => {:class => Directions::CubicCurveTo,
             :args => 4},
      :q => {:class => Directions::QuadraticCurveTo,
             :args => 4},
      :t => {:class => Directions::QuadraticCurveTo,
             :args => 2},
      :a => {:class => Directions::ArcTo,
             :args => 7}
    }

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
            directions << construct_direction(recurse_code.strip[0].downcase.intern, absolute)
            recurse_code = 'L' if recurse_code.downcase =~ /m/
            first_absolute = false
          end
          
          directions
        end

        def construct_direction(recurse_code, absolute)
          args = @coordinates.shift DIRECTIONS[recurse_code][:args]
          raise TypeError if args.any?(&:nil?)
          DIRECTIONS[recurse_code][:class].new(*args, absolute)
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
