module Savage
  class SubPath
    include Utils
    include DirectionProxy
    include Transformable

    define_proxies do |sym,const|
      define_method(sym) do |*args|
        raise TypeError if const == "QuadraticCurveTo" && @directions.last.class != Directions::QuadraticCurveTo && [2,3].include?(args.length)
        raise TypeError if const == "CubicCurveTo" && @directions.last.class != Directions::CubicCurveTo && [4,5].include?(args.length)
        (@directions << Savage::Directions.const_get(const).new(*args)).last
      end
    end

    attr_accessor :directions

    def move_to(*args)
      return nil unless @directions.empty?
      (@directions << Directions::MoveTo.new(*args)).last
    end

    def initialize(*args)
      @directions = []
      move_to(*args) if (2..3).include?(args.length)
      yield self if block_given?
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

    def transform(*args)
      directions.each { |dir| dir.transform *args }
    end

    def to_transformable_commands!
      if !fully_transformable?
        pen_x, pen_y = 0, 0
        directions.each_with_index do |dir, index|
          unless dir.fully_transformable?
            directions[index] = dir.to_fully_transformable_dir( pen_x, pen_y )
          end

          if dir.absolute?
            pen_x, pen_y = dir.movement
          else
            dx, dy = dir.movement
            pen_x += dx
            pen_y += dy
          end
        end
      end
    end

    def fully_transformable?
      directions.all? &:fully_transformable?
    end
  end
end
