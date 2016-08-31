class RailsMosaico::ImagesController < ActionController::Base
  before_action :set_current_gallery

  def index
    @images_url = @gallery.images.as_json
    render json: { files: @images_url }
  end

  def show
    p params
    if params[:method] == 'placeholder'
      l, w = params[:params].split(',')
      url = URI.encode("https://placeholdit.imgix.net/~text?txt=#{l}×#{w}&w=#{l}&h=#{w}")
      uri = URI.parse(url)
      data = open(uri)
      send_data data.read, type: data.content_type, disposition: 'inline'
    elsif params[:method] == 'resize'
      p '~'
    end
  end

  private
  def set_current_gallery
    @gallery = RailsMosaico::Gallery.first
  end
end