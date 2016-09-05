require "paperclip/railtie"

Paperclip::Railtie.insert

Paperclip::Attachment.default_options[:use_timestamp] = false
