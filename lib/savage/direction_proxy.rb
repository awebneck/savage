module Savage
  module DirectionProxy
    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def define_proxies(&block)
        Directions.constants.each do |constant_sym|
          constant = (constant_sym.is_a?(Symbol)) ? constant_sym.to_s : constant_sym
          unless %w[PointTarget CoordinateTarget Point MoveTo].include? constant
            sym = constant.to_s.gsub(/[A-Z]/) { |p| '_' + p.downcase }[1..-1].to_sym
            block.call(sym,constant)
          end
        end
      end
    end
  end
end
