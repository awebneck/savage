begin
  require 'active_support/core_ext/string/inflections'
rescue LoadError, NameError
  require 'activesupport'
end
SAVAGE_PATH = File.dirname(__FILE__) + "/savage/"
[
  'utils',
  'direction',
  'path',
  'parser'
].each do |library|
  require SAVAGE_PATH + library
end
