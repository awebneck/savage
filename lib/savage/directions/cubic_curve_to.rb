module Savage
  module Directions
    class CubicCurveTo < QuadraticCurveTo
      attr_accessor :control_1

      def initialize(*args)
        raise ArgumentError if args.length < 4
        case args.length
        when 4
          super(args[0],args[1],args[2],args[3],true)
        when 5
          raise ArgumentError if args[4].kind_of?(Numeric)
          super(args[0],args[1],args[2],args[3],args[4])
        when 6
          @control_1 = Point.new(args[0],args[1])
          super(args[2],args[3],args[4],args[5],true)
        when 7
          @control_1 = Point.new(args[0],args[1])
          super(args[2],args[3],args[4],args[5],args[6])
        end
      end

      def to_a
        if @control_1
          [command_code, @control_1.x, @control_1.y, @control.x, @control.y, @target.x, @target.y]
        else
          [command_code, @control.x, @control.y, @target.x, @target.y]
        end
      end

      def control_2; @control; end
      def control_2=(value); @control = value; end

      def command_code
        return (absolute?) ? 'C' : 'c' if @control_1
        (absolute?) ? 'S' : 's'
      end

      def transform(scale_x, skew_x, skew_y, scale_y, tx, ty)
        super
        tx = ty = 0 if relative?
        transform_dot( control_1, scale_x, skew_x, skew_y, scale_y, tx, ty) if control_1
      end

    end
  end
end
