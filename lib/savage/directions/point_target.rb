module Savage
  class PointTarget < Direction
    
    attr_accessor :target
    
    def initialize(x, y, absolute=false)
      @target = Point.new(x,y)
      super(absolute)
    end
    
    def to_command
      command_code << "#{@target.x.to_s} #{@target.y.to_s}"
    end
    
    private
      def command_code; ''; end;
  end
end