class MosaicoRails::GalleriesController <  MosaicoRails::MosaicoRailsController
  before_action :set_default_gallery, only: :update

  def update
    render json: {}, status: 422  and return if image_params.nil?
    @image = @current_gallery.images.create!(image: image_params) if params[:files]
    render json: { files: [@image.as_json] }
  end

  private
    def image_params
      params.require(:files)[0]
    end
end
