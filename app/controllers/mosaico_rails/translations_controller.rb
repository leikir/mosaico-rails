class MosaicoRails::TranslationsController < ApplicationController

  def show
    locale = params[:locale] || 'en'

    translate_file = MosaicoRails::Engine.root.join("vendor/assets/mosaico/mosaico/dist/rs/lang/mosaico-#{locale}.json")

    translations = if File.exists?(translate_file)
      JSON.parse(File.read(translate_file))
    else
      JSON.parse(File.read(MosaicoRails::Engine.root.join("vendor/assets/mosaico/mosaico/dist/rs/lang/mosaico-en.json")))
    end

    template_translations_file = MosaicoRails::Engine.root.join("lib/assets/mosaico/mosaico/templates/modern/modern-#{locale}.json")
    if File.exists?(template_translations_file)
      translations.merge!({"template" => JSON.parse(File.read(template_translations_file))})
    end

    render text: translations.to_json
  end

end
