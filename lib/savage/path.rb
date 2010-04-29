module Savage
  class Path
    def initialize(path_string=nil)
      raise ArgumentError unless path_string.nil? || path_string.kind_of?(String)
      
    end
    
    def commands
      return []
    end
  end
end