module MosaicoRails
  class Engine < ::Rails::Engine
    isolate_namespace MosaicoRails
    initializer "mosaico_rails.assets.precompile" do |app|
      app.config.tinymce.install = :compile
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
  end
end
