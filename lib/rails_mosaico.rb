require "rails_mosaico/engine"
require "tinymce-rails"

module RailsMosaico
  mattr_accessor :owner_class
  mattr_accessor :auto_init

  self.auto_init = true
end
