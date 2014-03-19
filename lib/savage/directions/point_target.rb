module Savage
  module Directions
    class PointTarget < Direction

      attr_accessor :target

      def initialize(x, y, absolute=true)
        @target = Point.new(x,y)
        super(absolute)
      end

      def to_a
        [command_code, @target.x, @target.y]
      end

      def movement
        [target.x, target.y]
      end

    end
  end
end
