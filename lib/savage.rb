SAVAGE_PATH = File.dirname(__FILE__) + "/savage/"
[
].each do |library|
  require SAVAGE_PATH + library
end