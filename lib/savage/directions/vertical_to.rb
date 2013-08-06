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
    end
  end
end
