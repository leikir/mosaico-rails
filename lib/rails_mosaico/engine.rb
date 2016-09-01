module RailsMosaico
  class Engine < ::Rails::Engine
    isolate_namespace RailsMosaico

    # initializer "static assets" do |app|
    #   app.middleware.insert_before(::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public")
    # end
    initializer "rails_mosaico.assets.precompile" do |app|
      app.config.assets.precompile += %w(rails_mosaico/* *.png *.jpg *.jpeg)
    end
  end
end
