$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_mosaico/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_mosaico"
  s.version     = RailsMosaico::VERSION
  s.authors     = ["yyaegash"]
  s.email       = ["yoko.yaeg@gmail.com"]
  s.homepage    = ""
  s.summary     = "Summary of RailsMosaico."
  s.description = "Description of RailsMosaico."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "paperclip"
  s.add_dependency "tinymce-rails"

end
