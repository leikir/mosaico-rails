$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mosaico_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mosaico-rails"
  s.version     = MosaicoRails::VERSION
  s.authors     = ["leikir"]
  s.email       = ["web@leikir.io"]
  s.homepage    = ""
  s.summary     = "Summary of MosaicoRails."
  s.description = "Description of MosaicoRails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "paperclip", '4.3.7'
  s.add_dependency 'aws-sdk', '< 2.0'

end
