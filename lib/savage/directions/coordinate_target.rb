module Savage
  module Directions
    class CoordinateTarget < Direction

      attr_accessor :target

      def initialize(target, absolute=true)
        @target = target
        super(absolute)
      end

      def to_a
        [command_code, @target.to_s]
      end
    end
  end
end