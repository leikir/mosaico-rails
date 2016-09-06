module MosaicoRails
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    argument :owner_class, :type => :string, optional: true#, :default => "user"
    argument :gallery_class, :type => :string, :default => "gallery"
    argument :image_class, :type => :string, :default => "image"

    source_root File.expand_path('../templates', __FILE__)

    def create_initializer_file
      p owner_class
      p gallery_class
      p image_class
      copy_file("paperclip.rb", "config/initializers/paperclip.rb")
      if owner_class
        create_file("config/initializers/mosaico-rails.rb", "MosaicoRails.owner_class = '#{owner_class.classify}'\n# Init Mosaico once, default value is true\n# MosaicoRails.auto_init: true")
      else
        create_file("config/initializers/mosaico-rails.rb", "# Init Mosaico once, default value is true\n# MosaicoRails.auto_init: true")
      end
    end

    def create_active_record_db
      migration_template "create_table_gallery.rb.erb", "db/migrate/create_table_#{gallery_class.pluralize}.rb"
      sleep 1 # to increment migration version
      migration_template 'create_table_image.rb.erb', "db/migrate/create_table_#{image_class.pluralize}.rb"
      unless owner_class.nil?
        sleep 1
        unless owner_class
          p owner_class
          migration_template 'add_gallery_owner.rb', "db/migrate/add_polymorphic_association_to_gallery.rb"
        end
      end
    end

    def bind_to_owner
      unless owner_class
      else
        fname = "app/models/#{owner_class.underscore}.rb"
        if File.exist?(File.join(destination_root, fname))
          inclusion = "has_one :mosaico_rails_gallery, as: :mosaico_rails_imageable, class_name: 'MosaicoRails::Gallery'"
          unless parse_file_for_line(fname, inclusion)
            active_record_needle = (Rails::VERSION::MAJOR == 5) ? 'ApplicationRecord' : 'ActiveRecord::Base'
            inject_into_file fname, after: "class #{owner_class} < #{active_record_needle}\n" do <<-'RUBY'
  has_one :mosaico_rails_gallery, as: :mosaico_rails_imageable, class_name: 'MosaicoRails::Gallery'
  RUBY
            end
          end
        end
      end
    end

    def create_routes
      fname = 'config/routes.rb'
      inject_into_file fname, after: "Rails.application.routes.draw do\n" do <<-'RUBY'
  mount MosaicoRails::Engine, at: '/'
  RUBY
      end
    end

    private
    def self.next_migration_number(dir)
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    end
  end
end
