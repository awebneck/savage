module Savage
  module Directions
    class QuadraticCurveTo < PointTarget
      attr_accessor :control

      def initialize(*args)
        raise ArgumentError if args.length < 2
        case args.length
        when 2
          super(args[0],args[1],true)
        when 3
          raise ArgumentError if args[2].kind_of?(Numeric)
          super(args[0],args[1],args[2])
        when 4
          @control = Point.new(args[0],args[1])
          super(args[2],args[3],true)
        when 5
          @control = Point.new(args[0],args[1])
          super(args[2],args[3],args[4])
        end
      end

      def to_a
        if @control
          [command_code, @control.x, @control.y, @target.x, @target.y]
        else
          [command_code, @target.x, @target.y]
        end
      end

      def command_code
        return (absolute?) ? 'Q' : 'q' if @control
        (absolute?) ? 'T' : 't'
      end

      def transform(scale_x, skew_x, skew_y, scale_y, tx, ty)
        # relative line_to dont't need to be tranlated
        tx = ty = 0 if relative?
        transform_dot( target,  scale_x, skew_x, skew_y, scale_y, tx, ty)
        transform_dot( control, scale_x, skew_x, skew_y, scale_y, tx, ty)
      end
    end
  end
end
