module Savage
  class SubPath
    Directions.constants.each do |constant|
      unless %w[PointTarget CoordinateTarget Point MoveTo].include? constant
        sym = constant.gsub(/[A-Z]/) { |p| '_' + p.downcase }[1..-1].to_sym
        define_method(sym) do |*args|
          new_command = ("Savage::Directions::" << constant).constantize.new(*args)
          @commands << new_command
          new_command
        end
      end
    end
    
    attr_accessor :commands
    
    def move_to(*args)
      return nil unless @commands.empty?
      new_move = Directions::MoveTo.new(*args)
      @commands <<  new_move
      new_move
    end
    
    def initialize
      @commands = []
    end
    
    # FIXME - refactor this monstrosity
    def to_command
      prev_command = nil
      command = ''
      @commands.each do |dir|
        this_command = dir.to_command
        if dir.class == prev_command || (dir.class == Directions::LineTo && prev_command == Directions::MoveTo)
          this_command.gsub!(/^[A-Za-z]/,'')
          this_command = " " << this_command unless this_command.match(/^-/)
        end
        prev_command = dir.class
        command << this_command
      end
      command
    end
    
    def closed?
      @commands.last.kind_of? Directions::ClosePath
    end
  end
end