module Savage
  module Directions
    class ClosePath < Direction
    
      def initialize(absolute=true)
        super(absolute)
      end
    
      def to_command
        command_code
      end
      
      def command_code
        (absolute?) ? 'Z' : 'z'
      end
    end
  end
end