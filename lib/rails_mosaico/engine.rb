module RailsMosaico
  class Engine < ::Rails::Engine
    isolate_namespace RailsMosaico


    # config.mobile_app_name = "mobile_raisemore"
    # config.mobile_app_containing_directory = File.join(root, "vendor").to_s
    # config.mobile_app_path = File.join(root, "vendor", "mobile_raisemore").to_s
    # config.mobile_theme_path = File.join(root, "public", "mobilethemes").to_s
    # config.mobile_repo_url = "git@bitbucket.org:raisemore/mobile_raisemore.git"
    # config.local_asset_js_path = File.join(root, "vendor", "assets", "javascripts", "mobile").to_s
    # config.local_asset_css_path = File.join(root, "vendor", "assets", "stylesheets", "mobile").to_s
    # config.local_public_mobile_path = File.join(root, "public", "mobile").to_s
    config.public_file_server = true
  end
end
