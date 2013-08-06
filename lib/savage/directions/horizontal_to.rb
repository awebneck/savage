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
    end
  end
end
