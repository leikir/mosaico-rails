module RailsMosaico
  class EmailEditorController < ApplicationController
    
    before_action :set_current_gallery
  # load_and_authorize_resource

    def index
      @images_url = @gallery.moz_images.as_json

      # @images_url = @gallery.moz_images.map do |moz_img|
      #   {
      #     deleteType: 'DELETE',
      #     deleteUrl: "#{ENV['URL_BASE']}delete/#{moz_img.id}",
      #     name: moz_img.image_file_name,
      #     size: moz_img.image_file_size,
      #     thumbnailUrl: "#{ENV['URL_BASE']}#{moz_img.image.url(:sq_300)}",
      #     url: "#{ENV['URL_BASE']}#{moz_img.image.url}"
      #   }
      # end
      render json: { files: @images_url }
    end

    private
    def set_current_gallery
      @gallery = MozGallery.first
    end
  end
end

  