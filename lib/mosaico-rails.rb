require "mosaico_rails/engine"

module MosaicoRails
  mattr_accessor :owner_class
  mattr_accessor :auto_init
  mattr_accessor :gallery_parent_controller

  mattr_accessor :current_gallery_method

  self.auto_init = true
  self.gallery_parent_controller = 'ApplicationController'

  MosaicoRails::Engine.configure do
    config.paperclip_defaults = {}
  end
end
