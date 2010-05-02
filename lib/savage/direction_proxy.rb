module Savage
  module DirectionProxy
    def self.included(klass)  
      klass.extend ClassMethods  
    end
    
    module ClassMethods
      def define_proxies(&block)
        Directions.constants.each do |constant|
          unless %w[PointTarget CoordinateTarget Point MoveTo].include? constant
            sym = constant.gsub(/[A-Z]/) { |p| '_' + p.downcase }[1..-1].to_sym
            block.call(sym,constant)
          end
        end
      end
    end
  end
end