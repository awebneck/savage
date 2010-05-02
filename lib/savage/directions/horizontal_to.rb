module Savage
  module Directions
    class HorizontalTo < CoordinateTarget
      private
        def command_code
          (absolute?) ? 'H' : 'h'
        end
    end
  end
end