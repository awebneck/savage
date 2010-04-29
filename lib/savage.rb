SAVAGE_PATH = File.dirname(__FILE__) + "/savage/"
[
  'path',
  'direction'
].each do |library|
  require SAVAGE_PATH + library
end