module Savage
  module Directions
    class HorizontalTo < CoordinateTarget
      def command_code
        (absolute?) ? 'H' : 'h'
      end
    end
  end
end