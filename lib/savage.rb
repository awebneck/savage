SAVAGE_PATH = File.dirname(__FILE__) + "/savage/"
[
  'utils',
  'direction',
  'path'
  
].each do |library|
  require SAVAGE_PATH + library
end