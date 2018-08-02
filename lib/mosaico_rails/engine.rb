module MosaicoRails
  class Engine < ::Rails::Engine
    isolate_namespace MosaicoRails

    initializer "mosaico-rails.assets.precompile" do |app|
      app.config.assets.paths << MosaicoRails::Engine.root.join("lib", "assets", "mosaico")
      app.config.assets.paths << MosaicoRails::Engine.root.join("vendor", "assets", "mosaico")
      app.config.assets.precompile += %w(
        mosaico_rails/editor.css
        mosaico_rails/editor.js
        mosaico/**/*.png
        mosaico/**/*.jpg
        mosaico/**/*.jpeg
        mosaico/**/*.gif
      )
    end

    DEFAULT_JSON_METADATA = {
      created: 1_472_726_174_764,
      key: 'xy6paxp',
      name: 'modern',
      template: 'templates/modern',
      editorversion: '0.14.0',
      templateversion: '1.0.5',
      changed: 1_472_726_187_318
    }.freeze
  end
end
