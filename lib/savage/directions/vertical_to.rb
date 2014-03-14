module Savage
  module Directions
    class VerticalTo < CoordinateTarget
      def command_code
        (absolute?) ? 'V' : 'v'
      end

      def transform(scale_x, skew_x, skew_y, scale_y, tx, ty)

        unless skew_x.zero?
          raise 'rotating or skewing (in X axis) an "vertical_to" direction is not supported yet.'
        end
        
        self.target *= scale_y
        self.target += ty if absolute?
      end

      def to_fully_transformable_dir( pen_x, pen_y )
        if absolute?
          LineTo.new( pen_x, target + pen_y, true )
        else
          LineTo.new( 0, target, false )
        end
      end

      def movement
        [0, target]
      end
    end
  end
end
