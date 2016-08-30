module RailsMosaico
  class Engine < ::Rails::Engine
    isolate_namespace RailsMosaico

    initializer "static assets" do |app|
      app.middleware.insert_before(::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public")
    end
  end
end
