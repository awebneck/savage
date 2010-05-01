module Savage
  class QuadraticCurveTo < PointTarget
    attr_accessor :control
    
    def initialize(control_x, control_y, target_x, target_y, absolute=false)
      @control = Point.new(control_x, control_y)
      super(target_x, target_y, absolute)
    end
    
    def to_command
      (command_code << "#{@control.x} #{@control.y} #{@target.x} #{@target.y}").gsub(/ -/,'-')
    end
    
    private
      def command_code
        (absolute?) ? 'Q' : 'q'
      end
  end
end