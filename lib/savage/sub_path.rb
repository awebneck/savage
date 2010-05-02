module Savage
  class SubPath
    include Utils
    
    Directions.constants.each do |constant|
      unless %w[PointTarget CoordinateTarget Point MoveTo].include? constant
        sym = constant.gsub(/[A-Z]/) { |p| '_' + p.downcase }[1..-1].to_sym
        define_method(sym) do |*args|
          (@directions << constantize("Savage::Directions::" << constant).new(*args)).last
        end
      end
    end
    
    attr_accessor :directions
    
    def move_to(*args)
      return nil unless @directions.empty?
      (@directions << Directions::MoveTo.new(*args)).last
    end
    
    def initialize
      @directions = []
    end
    
    def to_command
      @directions.to_enum(:each_with_index).collect { |dir, i|
        command_string = dir.to_command
        if i > 0
          prev_command_code = @directions[i-1].command_code
          if dir.command_code == prev_command_code || (prev_command_code.match(/^[Mm]$/) && dir.command_code == 'L') 
            command_string.gsub!(/^[A-Za-z]/,'')
            command_string.insert(0,' ') unless command_string.match(/^-/)
          end
        end
        command_string
      }.join
    end
    
    def commands
      @directions
    end
    
    def closed?
      @directions.last.kind_of? Directions::ClosePath
    end
  end
end