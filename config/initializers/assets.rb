Rails.application.config.serve_static_assets = true
Rails.application.config.consider_all_requests_local = true


Rails.application.config.assets.precompile += %w(
  rails_mosaico/*
)
# Rails.application.config.assets.precompile += %w(
#   rails_mosaico/vendor/jquery.min.js
#   rails_mosaico/vendor/jquery-ui.min.js
#   rails_mosaico/vendor/jquery.ui.touch-punch.min.js
#   rails_mosaico/vendor/load-image.all.min.js
#   rails_mosaico/vendor/canvas-to-blob.min.js
#   rails_mosaico/vendor/jquery.iframe-transport.js
#   rails_mosaico/vendor/jquery.fileupload.js
#   rails_mosaico/vendor/jquery.fileupload-process.js
#   rails_mosaico/vendor/jquery.fileupload-image.js
#   rails_mosaico/vendor/jquery.fileupload-process.js
#   rails_mosaico/vendor/knockout-jqueryui.min.js
#   rails_mosaico/vendor/tinymce.min.js
#   rails_mosaico/mosaico.min.js?v=0.14
#   rails_mosaico/mosaico.min.js
#   rails_mosaico/mosaico-material.min.css
#   rails_mosaico/vendor/notoregular/stylesheet.css
#   rails_mosaico/vendor/*
# )

# Rails.application.config.assets.precompile = ['*.js', '*.css', '*.map']
# Rails.application.config.assets.precompile += %w( rails_mosaico/vendor/tinymce.min.js )
