module RailsMosaico
  class Engine < ::Rails::Engine
    isolate_namespace RailsMosaico

    initializer "rails_mosaico.assets.precompile" do |app|
      app.config.tinymce.install = :compile
      app.config.assets.paths << RailsMosaico::Engine.root.join("vendor", "assets", "mosaico")
      app.config.assets.precompile += %w(
        rails_mosaico/editor.css
        rails_mosaico/editor.js
        mosaico/**/*.png
        mosaico/**/*.jpg
        mosaico/**/*.jpeg
        mosaico/**/*.gif
      )
    end
  end
end
