module Savage
  class PointTarget < Direction
    
    attr_accessor :target_x, :target_y
    
    def initialize(x, y, absolute=false)
      @target_x = x
      @target_y = y
      super(absolute)
    end
    
    def to_command
      command_code << "#{@target_x.to_s} #{@target_y.to_s}"
    end
    
    private
      def command_code; ''; end;
  end
end