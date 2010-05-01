module Savage
  class VerticalTo < CoordinateTarget
    private
      def command_code
        (absolute?) ? 'V' : 'v'
      end
  end
end