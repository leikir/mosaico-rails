class MosaicoRails::GalleriesController <  MosaicoRails::MosaicoRailsController
  before_action :set_default_gallery

  def update
    render json: {}, status: 422  and return if image_params.nil?
    @image = @current_gallery.images.create!(image: image_params) if params[:files]
    render json: { files: [@image.as_json] }
  end

  def show
    # Error management not supported.
    @images_url = @current_gallery.images.as_json
    render json: { files: @images_url }
  end

  private

    def image_params
      params.require(:files)[0]
    end

    def set_default_gallery
      begin
        @current_gallery = current_gallery
      rescue NameError => e
        @current_gallery = MosaicoRails::Gallery.first_or_create
      end
    end
end
