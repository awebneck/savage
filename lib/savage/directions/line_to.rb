module Savage
  module Directions
    class LineTo < PointTarget
      def command_code
        (absolute?) ? 'L' : 'l'
      end

      def transform(scale_x, skew_x, skew_y, scale_y, tx, ty)
        # relative line_to dont't need to be tranlated
        tx = ty = 0 if relative?
        transform_dot( target, scale_x, skew_x, skew_y, scale_y, tx, ty)
      end
    end
  end
end
