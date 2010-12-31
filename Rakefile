require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "savage"
    gem.summary = %Q{A little library to manipulate SVG path data}
    gem.description = %Q{A little gem for extracting and manipulating SVG vector path data.}
    gem.email = "jeremy@jeremypholland.com"
    gem.homepage = "http://github.com/awebneck/savage"
    gem.authors = ["Jeremy Holland"]
    gem.add_development_dependency "rspec", ">= 2.3.0"
    gem.add_dependency "activesupport", ">= 2.3.5"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "savage #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
