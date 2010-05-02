module Savage
  module Directions
    class ClosePath < Direction
    
      def initialize(absolute=true)
        super(absolute)
      end
    
      def to_command
        command_string = (absolute?) ? 'Z' : 'z'
      end
    end
  end
end