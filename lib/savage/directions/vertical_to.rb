module Savage
  module Directions
    class VerticalTo < CoordinateTarget
      private
        def command_code
          (absolute?) ? 'V' : 'v'
        end
    end
  end
end