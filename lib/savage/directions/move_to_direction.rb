module Savage
  class MoveToDirection < Direction
    
    attr_accessor :target_x, :target_y
    
    def initialize(x, y, absolute=false)
      @absolute = absolute
      @target_x = x
      @target_y = y
    end
    
    def absolute?
      @absolute
    end
    
    def to_command
      command_string = (absolute?) ? 'M' : 'm'
      command_string << "#{@target_x.to_s} #{@target_y.to_s}"
    end
  end
end