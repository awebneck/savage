module Savage
  class Path
    require File.dirname(__FILE__) + "/sub_path"
    
    def initialize(path_string=nil)
      raise ArgumentError unless path_string.nil? || path_string.kind_of?(String)
    end
    
    def subpaths
      return []
    end
    
    def to_command
    end
  end
end