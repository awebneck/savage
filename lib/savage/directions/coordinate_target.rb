module Savage
  module Directions
    class CoordinateTarget < Direction

      attr_accessor :target

      def initialize(target, absolute=true)
        @target = target
        super(absolute)
      end

      def to_a
        [command_code, @target]
      end

      def fully_transformable?
        false
      end
    end
  end
end
