class RailsMosaico::GalleriesController < ActionController::Base
  before_action :set_current_gallery

  def update
    @image = @gallery.images.create!(image: image_params) if params[:files].present?
    render json: { files: [@image.as_json] }
  end

  private

  def set_current_gallery
    @gallery = RailsMosaico::Gallery.first_or_create
  end
  def image_params
    params.require(:files)[0]
  end
end
