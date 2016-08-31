module RailsMosaico
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    argument :gallery_class, :type => :string, :default => "gallery"
    argument :image_class, :type => :string, :default => "image"
    argument :owner_class, :type => :string, :default => "user"

    source_root File.expand_path('../templates', __FILE__)

    def create_initializer_file
      copy_file("paperclip.rb", "config/initializers/paperclip.rb")
    end

    def create_active_record_db
      migration_template "create_table_gallery.rb.erb", "db/migrate/create_table_#{gallery_class.pluralize}.rb"
      sleep 1 # to increment migration version
      migration_template 'create_table_image.rb.erb', "db/migrate/create_table_#{image_class.pluralize}.rb"
    end

    def create_first_gallery
      if owner_class == '--no-user'
      end
    end

    def create_routes
      fname = 'config/routes.rb'
      inject_into_file fname, after: "Rails.application.routes.draw do\n" do <<-'RUBY'
  mount RailsMosaico::Engine, at: '/'
  RUBY
      end
    end

    private
    def self.next_migration_number(dir)
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    end
  end
end
