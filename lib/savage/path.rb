module Savage
  class Path
    require File.dirname(__FILE__) + "/direction_proxy"
    require File.dirname(__FILE__) + "/sub_path"

    include Utils
    include DirectionProxy
    include Transformable

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

    def transform(*args)
      dup.tap do |path|
        path.to_transformable_commands!
        path.subpaths.each {|subpath| subpath.transform *args }
      end
    end

    # Public: make commands within transformable commands
    #         H/h/V/v is considered not 'transformable'
    #         because when they are rotated, they will
    #         turn into other commands
    def to_transformable_commands!
      subpaths.each &:to_transformable_commands!
    end

    def fully_transformable?
      subpaths.all? &:fully_transformable?
    end

  end
end
