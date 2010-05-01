module Savage
  module Directions
    class QuadraticCurveTo < PointTarget
      attr_accessor :control
    
      def initialize(control_x, control_y, target_x, target_y, absolute=false)
        @control = Point.new(control_x, control_y)
        super(target_x, target_y, absolute)
      end
    
      def to_command(continuous=false)
        command_code(continuous) << ((!continuous) ? "#{@control.x} #{@control.y} #{@target.x} #{@target.y}".gsub(/ -/,'-') : super().gsub(/[A-Za-z]/,''))
      end
    
      private
        def command_code(continuous=false)
          return (absolute?) ? 'Q' : 'q' unless continuous
          (absolute?) ? 'T' : 't'
        end
    end
  end
end