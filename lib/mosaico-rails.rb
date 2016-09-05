require "mosaico_rails/engine"
require "tinymce-rails"

module MosaicoRails
  mattr_accessor :owner_class
  mattr_accessor :auto_init

  self.auto_init = true
end
