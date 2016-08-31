class RailsMosaico::ImagesController < ActionController::Base
  before_action :set_current_gallery

  def index
    @images_url = @gallery.images.as_json
    render json: { files: @images_url }
  end

  def show
    p '~'
    p params
    if params[:method] == 'placeholder'
      p '~'
      p 'hello'
      l, w = params[:params].split(',')

      # render :file => "#{RailsMosaico::Engine.root}/public/placeholder.png", layout: false
      
      # "https://placeholdit.imgix.net/~text?txtsize=33&txt=350x150&w=350 150"
    data = open("https://placeholdit.imgix.net/~text?txt=#{l}×#{w}&w=#{l}&h=#{w}") 
    send_data data, type: image.content_type, disposition: 'inline'
      # send_file "#{RailsMosaico::Engine.root}/public/placeholder.png", type: 'image/png', disposition: 'inline'
      
      # send_data data, type: image.content_type, disposition: 'inline'
    end
  end

  private
  def set_current_gallery
    @gallery = RailsMosaico::Gallery.first
  end
end