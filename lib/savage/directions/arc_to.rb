module Savage
  module Directions
    class ArcTo < PointTarget
      attr_accessor :radius, :rotation, :large_arc, :sweep

      def initialize(radius_x, radius_y, rotation, large_arc, sweep, target_x, target_y, absolute=true)
        super(target_x, target_y, absolute)
        @radius = Point.new(radius_x, radius_y)
        @rotation = rotation
        @large_arc = large_arc.is_a?(Numeric) ? large_arc > 0 : large_arc
        @sweep = sweep.is_a?(Numeric) ? sweep > 0 : sweep
      end

      def to_a
        [command_code, @radius.x, @radius.y, @rotation, bool_to_int(@large_arc), bool_to_int(@sweep), target.x, target.y]
      end

      def command_code
        (absolute?) ? 'A' : 'a'
      end

      def transform(scale_x, skew_x, skew_y, scale_y, tx, ty)
        # relative arc_to dont't need to be tranlated
        tx = ty = 0 if relative?
        transform_dot( target,  scale_x, skew_x, skew_y, scale_y, tx, ty)
      end
    end
  end
end
