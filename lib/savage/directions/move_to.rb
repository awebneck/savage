module Savage
  module Directions
    class MoveTo < PointTarget
      def command_code
        (absolute?) ? 'M' : 'm'
      end
    end
  end
end