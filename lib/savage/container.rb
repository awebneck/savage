module Savage
  class Container < ::Savage::VisualElement
    attr_accessor :children
    
    def initialize
      @children = []
    end
  end
end