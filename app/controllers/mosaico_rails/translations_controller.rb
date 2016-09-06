class MosaicoRails::TranslationsController < ActionController::Base

  def show
    locale = params[:locale] || 'en'
    # TODO : check if file exists
    translations = File.read(MosaicoRails::Engine.root.join("vendor/assets/mosaico/mosaico/dist/lang/mosaico-#{locale}.json"))
    render json: translations
  end

end
