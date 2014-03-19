module Savage
  module Directions
    class ClosePath < Direction

      def initialize(absolute=true)
        super(absolute)
      end

      def to_a
        [command_code]
      end

      def command_code
        (absolute?) ? 'Z' : 'z'
      end

      def movement
        [0, 0]
      end
    end
  end
end
