class MosaicoRails::TranslationsController < ApplicationController

  def show
    locale = params[:locale] || 'en'
    translate_file = MosaicoRails::Engine.root.join("vendor/assets/mosaico/mosaico/dist/lang/mosaico-#{locale}.json")
    translations = File.exists?(translate_file) ? translate_file : 'vendor/assets/mosaico/mosaico/dist/lang/mosaico-en.json'
    render :file => translations
  end

end
