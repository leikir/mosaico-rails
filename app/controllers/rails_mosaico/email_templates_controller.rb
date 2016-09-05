class RailsMosaico::EmailTemplatesController < ActionController::Base

  def editor
  end

  def show
    template_id = params[:id]
  	original_template = File.open(
      File.join(
        File.dirname(__FILE__),
        "../../../vendor/assets/mosaico/mosaico/templates/#{template_id}/template-#{template_id}.html"
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
