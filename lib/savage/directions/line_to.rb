module Savage
  class LineTo < PointTarget
    private
      def command_code
        (absolute?) ? 'L' : 'l'
      end
  end
end