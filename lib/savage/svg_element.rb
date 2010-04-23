module Savage
  class SvgElement
    attr_accessor :svg_id, :xml_base, :xml_lang
    
    def initialize
      @xml_lang = 'en'
    end
    
    def preserve_whitespace=(value)
      @xml_space = value ? true : nil
    end
    
    def preserve_whitespace
      @xml_space
    end
    
    class << self
      def new_from_xml(element)
        new_instance = self.new
        new_instance.preserve_whitespace = true if element['xml:space'] == 'preserve'
        new_instance.xml_lang = element['xml:lang']
      end
    end
  end
end