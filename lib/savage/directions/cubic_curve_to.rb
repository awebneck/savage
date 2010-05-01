module Savage
  class CubicCurveTo < QuadraticCurveTo
    attr_accessor :control_2
    
    def initialize(control_1_x, control_1_y, control_2_x, control_2_y, target_x, target_y, absolute=false)
      @control_2 = Point.new(control_2_x, control_2_y)
      super(control_1_x, control_1_y, target_x, target_y, absolute)
    end
    
    def to_command
      (command_code << "#{@control.x} #{@control.y} #{@control_2.x} #{@control_2.y} #{@target.x} #{@target.y}").gsub(/ -/,'-')
    end
    
    def control_1; @control; end
    def control_1=(value); @control = value; end
    
    private
      def command_code
        (absolute?) ? 'C' : 'c'
      end
  end
end