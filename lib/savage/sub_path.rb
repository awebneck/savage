module Savage
  class SubPath
    Directions.constants.each do |constant|
      unless %w[PointTarget CoordinateTarget Point MoveTo].include? constant
        sym = constant.gsub(/[A-Z]/) { |p| '_' + p.downcase }[1..-1].to_sym
        define_method(sym) do |*args|
          @commands << ("Directions::" << constant).constantize.new(*args)
        end
      end
    end
    
    attr_accessor :commands
    
    def move_to(*args)
      return @commands << Directions::MoveTo.new(*args) if @commands.empty?
    end
    
    def initialize
      @commands = []
    end
  end
end