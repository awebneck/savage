module Savage
  module Directions
    Point = Struct.new :x, :y
  end

  class Direction

    include Utils
    include Transformable

    def initialize(absolute)
      @absolute = absolute
    end

    def absolute?
      @absolute
    end

    def relative?
      !absolute?
    end

    def to_command
      arr = to_a
      arr[0] + arr[1..-1].map {|i| to_short_f(i)}.join(' ').gsub(/ -/,'-')
    end

    # Public: determine if this direction is fully transformable.
    #         A fully transformable directions can accept any
    #         transform including rotate.
    #
    # Returns: true by default
    def fully_transformable?
      true
    end

    private
      
      def to_short_f n
        f = 1000000.0
        n = (n * f).round / f
        n == n.to_i ? n.to_i : n
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
