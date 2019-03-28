class MosaicoRails::ImagesController < ApplicationController

  def show
    head :no_content and return unless (params[:params] && params[:method])

    width, height = params[:params].gsub('null', '0').split(',')

    if params[:method] == 'placeholder'
      url = URI.encode("https://via.placeholder.com/#{width}×#{height}.png")
      uri = URI.parse(url)
      data = open(uri)
      send_data data.read, type: data.content_type, disposition: 'inline'
    elsif params[:method] == 'resize' || params[:method] == 'cover'
      method = params[:method] == 'resize' ? '>' : '#'
      head :no_content and return unless (image = MosaicoRails::Image.find_by(image_url: params[:src]))
      data = image.dynamic_attachment_url(width, height, method)
      redirect_to data
    end
  end

end
