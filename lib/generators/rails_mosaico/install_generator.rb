module RailsMosaico
  class InstallGenerator < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def create_initializer_file
      copy_file("paperclip.rb", "config/initializers/paperclip.rb")
    end  
  end
end