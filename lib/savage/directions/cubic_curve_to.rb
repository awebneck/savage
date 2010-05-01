module Savage
  module Directions
    class CubicCurveTo < QuadraticCurveTo
      attr_accessor :control_1
    
      def initialize(control_1_x, control_1_y, control_2_x, control_2_y, target_x, target_y, absolute=false)
        @control_1 = Point.new(control_1_x, control_1_y)
        super(control_2_x, control_2_y, target_x, target_y, absolute)
      end
    
      def to_command(continuous=false)
        command_code(continuous) << ((!continuous) ? "#{@control_1.x} #{@control_1.y} #{@control.x} #{@control.y} #{@target.x} #{@target.y}".gsub(/ -/,'-') : super().gsub(/[A-Za-z]/,''))
      end
    
      def control_2; @control; end
      def control_2=(value); @control = value; end
    
      private
        def command_code(continuous=false)
          return (absolute?) ? 'C' : 'c' unless continuous
          (absolute?) ? 'S' : 's'
        end
    end
  end
end