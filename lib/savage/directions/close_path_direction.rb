module Savage
  class ClosePathDirection < Direction
    
    def initialize(absolute=false)
      super
    end
    
    def to_command
      command_string = (absolute?) ? 'Z' : 'z'
    end
  end
end