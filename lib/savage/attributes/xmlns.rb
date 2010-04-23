module Savage
  module Attributes
    module Xmlns
      attr_accessor :default_namespace
      
      def initialize
        @default_namespace = 'http://www.w3.org/2000/svg'
      end
      
      def namespaces
        @namespaces.merge :default => @default_namespace
      end
      
      def set_namespace(prefix,uri)
        @namespaces[prefix.intern] = uri.to_s unless prefix.intern == :default
      end
      
    end
  end
end