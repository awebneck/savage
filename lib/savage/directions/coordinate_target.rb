module Savage
  class CoordinateTarget < Direction
    
    attr_accessor :target
    
    def initialize(target, absolute=false)
      @target = target
      super(absolute)
    end
    
    def to_command
      command_code << @target.to_s
    end
    
    private
      def command_code; ''; end;
  end
end