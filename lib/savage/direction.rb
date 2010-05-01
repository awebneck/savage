module Savage
  class Direction
    def initialize(absolute)
      @absolute = absolute
    end
    
    def absolute?
      @absolute
    end
  end
end

require File.dirname(__FILE__) + "/directions/move_to_direction"
require File.dirname(__FILE__) + "/directions/close_path_direction"