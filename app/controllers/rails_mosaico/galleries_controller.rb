module RailsMosaico
  class GalleriesController < ApplicationController
    before_action :set_current_gallery

    def update
      @image = @gallery.moz_images.create!(image: image_params) if params[:files].present?
      render json: { files: [@image.as_json] }
    end

    private

    def set_current_gallery
      @gallery = MozGallery.first
    end
    def image_params
      params.require(:files)[0]
    end
  end
end