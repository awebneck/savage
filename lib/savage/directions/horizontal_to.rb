module Savage
  module Directions
    class HorizontalTo < CoordinateTarget
      def command_code
        (absolute?) ? 'H' : 'h'
      end

      def transform(scale_x, skew_x, skew_y, scale_y, tx, ty)

        unless skew_y.zero?
          raise 'rotating or skewing (in Y axis) an "horizontal_to" direction is not supported yet.'
        end
        
        self.target *= scale_x
        self.target += tx if absolute?
      end

      def to_fully_transformable_dir( pen_x, pen_y )
        if absolute?
          LineTo.new( target + pen_x, pen_y, true )
        else
          LineTo.new( target, 0, false )
        end
      end

      def movement
        [target, 0]
      end
    end
  end
end
