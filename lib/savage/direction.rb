module Savage
  module Directions
    Point = Struct.new :x, :y
  end

  class Direction

    include Utils

    def initialize(absolute)
      @absolute = absolute
    end

    def absolute?
      @absolute
    end

    def to_command
      arr = to_a
      arr[0] + arr[1..-1].join(' ').gsub(/ -/,'-')
    end
  end
end

require File.dirname(__FILE__) + "/directions/close_path"
require File.dirname(__FILE__) + "/directions/coordinate_target"
require File.dirname(__FILE__) + "/directions/horizontal_to"
require File.dirname(__FILE__) + "/directions/vertical_to"
require File.dirname(__FILE__) + "/directions/point_target"
require File.dirname(__FILE__) + "/directions/move_to"
require File.dirname(__FILE__) + "/directions/line_to"
require File.dirname(__FILE__) + "/directions/quadratic_curve_to"
require File.dirname(__FILE__) + "/directions/cubic_curve_to"
require File.dirname(__FILE__) + "/directions/arc_to"