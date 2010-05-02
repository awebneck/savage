module Savage
  class Path
    require File.dirname(__FILE__) + "/direction_proxy"
    require File.dirname(__FILE__) + "/sub_path"
    
    include Utils
    include DirectionProxy
    
    attr_accessor :subpaths
    
    define_proxies do |sym,const|
      define_method(sym) do |*args|
        @subpaths.last.send(sym,*args)
      end 
    end
    
    def initialize(*args)
      @subpaths = [SubPath.new]
      @subpaths.last.move_to(*args) if (2..3).include?(*args.length)
      yield self if block_given?
    end
    
    def directions
      directions = []
      @subpaths.each { |subpath| directions.concat(subpath.directions) }
      directions
    end
    
    def move_to(*args)
      unless (@subpaths.last.directions.empty?)
        (@subpaths << SubPath.new(*args)).last
      else
        @subpaths.last.move_to(*args)
      end
    end
    
    def closed?
      @subpaths.last.closed?
    end
    
    def to_command
      @subpaths.collect { |subpath| subpath.to_command }.join
    end
  end
end