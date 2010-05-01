module Savage
  module Directions
    class MoveTo < PointTarget
      private
        def command_code
          (absolute?) ? 'M' : 'm'
        end
    end
  end
end