module Savage
  module Directions
    class ClosePath < Direction
    
      def initialize(absolute=false)
        super
      end
    
      def to_command
        command_string = (absolute?) ? 'Z' : 'z'
      end
    end
  end
end