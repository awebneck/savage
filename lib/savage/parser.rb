module Savage
  class Parser
    class << self
      def parse(string_or_io)
        document = Nokogiri::XML.parse(string_or_io)
        return false unless document.root.name == "svg"
        svg = SVG.new_from_xml(document.root)
        savage_doc = Document.new
        savage_doc.svg = svg
        savage_doc.svg.children = sub_parse(document.root)
        savage_doc
      end
      
      def sub_parse(parent)
        children = []
        parent.children.each do |child|
          case child.name
          when "circle"
            child_object = Primitives::Circle.new_from_xml(child)
          end
          child_object.children = sub_parse(child) if child_object.kind_of? Container
          children << child_object
        end
        children
      end
    end
  end
end