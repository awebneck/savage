module Savage
  class HorizontalTo < CoordinateTarget
    private
      def command_code
        (absolute?) ? 'H' : 'h'
      end
  end
end