class MosaicoRails::EmailTemplatesController < ApplicationController
  def editor
  end

  def show
    # Error management not supported.
    template_id = params[:id]
    original_template = File.open(
      File.join(
        File.dirname(__FILE__),
        "../../../lib/assets/mosaico/mosaico/templates/#{template_id}/template-#{template_id}.html"
      )
    ).read
    new_template = original_template.gsub(
      /src="img\/(.*\.(png|jpg|jpeg|gif))"/
    ) { |match|
      image_name = "mosaico/templates/#{template_id}/img/#{$1}"
      "src=\"#{ActionController::Base.helpers.image_path(image_name)}\""
    }
    render html: new_template.html_safe
  end

end
