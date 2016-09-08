module MosaicoRails
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    # protect_from_forgery with: :exception
    before_action :set_current_gallery

    def set_current_gallery
      @gallery = MosaicoRails::Gallery.first_or_create
    end
  end
end
