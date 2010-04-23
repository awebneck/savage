require 'nokogiri'

SAVAGE_PATH = File.dirname(__FILE__) + "/savage/"
[
  "parser",
  "document",
  "visual_element",
  "container",
  "svg",
  "primitives/circle"
].each do |library|
  require SAVAGE_PATH + library
end