module MosaicoRails
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    require "rails/generators/active_record"

    argument :owner_class, :type => :string, optional: true
    argument :parent_controller, :type => :string, optional: true

    source_root File.expand_path('../templates', __FILE__)

    def create_initializer_file
      # Paperclip
      copy_file("paperclip.rb", "config/initializers/paperclip.rb")
      
      # MosaicoRails config parameters
      auto_init_line = "# Init Mosaico once, default value is true\n# MosaicoRails.auto_init = true\n"
      parent_controller_line = parent_controller.present? ? "MosaicoRails.parent_controller = '#{parent_controller}'\n" : ''

      if owner_class.present? && owner_class != 'nil'
        owner_class_line = "MosaicoRails.owner_class = '#{owner_class.classify}'\n"
        current_gallery_method = "MosaicoRails.current_gallery_method = :current_gallery\n"
      else
        owner_class_line = ''
        current_gallery_method = ''
      end
      create_file("config/initializers/mosaico-rails.rb",
        owner_class_line + auto_init_line + current_gallery_method + parent_controller_line
      )
    end

    def create_active_record_db
      migration_template "create_table_gallery.rb", "db/migrate/create_table_mosaico_rails_galleries.rb"
      migration_template 'create_table_image.rb', "db/migrate/create_table_mosaico_rails_images.rb"
      if  owner_class.present?
        migration_template 'add_gallery_owner.rb', "db/migrate/add_polymorphic_association_to_gallery.rb"
      end
    end

    def bind_to_owner
      if owner_class
        fname = "app/models/#{owner_class.underscore}.rb"
        if File.exist?(File.join(destination_root, fname))
          inclusion = "has_one :mosaico_rails_gallery, as: :mosaico_rails_imageable, class_name: 'MosaicoRails::Gallery'"
          unless parse_file_for_line(fname, inclusion)
            active_record_needle = (Rails::VERSION::MAJOR == 5) ? 'ApplicationRecord' : 'ActiveRecord::Base'
            inject_into_file fname, inclusion, after: "class #{owner_class} < #{active_record_needle}\n"
          end
        end
      end
    end

    def create_routes
      fname = 'config/routes.rb'
      inject_into_file fname, "\n  mount MosaicoRails::Engine, at: '/'\n", after: "Rails.application.routes.draw do\n"
    end

    private 
      def self.next_migration_number(number)
        ActiveRecord::Generators::Base.next_migration_number(number)
      end

      def parse_file_for_line(filename, str)
        match = false

        File.open(File.join(destination_root, filename)) do |f|
          f.each_line do |line|
            if line =~ /(#{Regexp.escape(str)})/mi
              match = line
            end
          end
        end
        match
      end
  end
end
