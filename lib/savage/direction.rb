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

require File.dirname(__FILE__) + "/directions/point_target"
require File.dirname(__FILE__) + "/directions/move_to"
require File.dirname(__FILE__) + "/directions/line_to"
require File.dirname(__FILE__) + "/directions/close_path"