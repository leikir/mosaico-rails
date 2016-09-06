class MosaicoRails::ImagesController < ActionController::Base
  before_action :set_current_gallery

  def index
    @images_url = @gallery.images.as_json(host: request.host)
    render json: { files: @images_url }
  end

  def show
    if params[:method] == 'placeholder'
      width, height = params[:params].split(',')
      url = URI.encode("https://placeholdit.imgix.net/~text?txt=#{width}×#{height}&w=#{width}&h=#{height}")
      uri = URI.parse(url)
      data = open(uri)
      send_data data.read, type: data.content_type, disposition: 'inline'
    elsif params[:method] == 'resize' || params[:method] == 'cover'
      method = params[:method] == 'resize' ? '>' : '#'
      
      target_url = URI.parse(params[:src]).path
      image = MosaicoRails::Image.find_by(image_url: target_url)
      width, height = params[:params].gsub('null', '0').split(',')
      data = image.dynamic_attachment_url("#{width}x#{height}#{method}")
      redirect_to data
    end
  end

  private
  def set_current_gallery
    @gallery = MosaicoRails::Gallery.first_or_create
  end
end