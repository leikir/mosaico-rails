class RailsMosaico::EmailTemplatesController < ActionController::Base
  def show
  end

  def versafix
  	original_template = Rails.application.assets.find_asset('rails_mosaico/versafix-1/template-versafix-1.html').to_s
  	new_template = ERB.new original_template.gsub(/<img src="img\/social_def\/(.*\.png|jpg|jpeg|tiff)*.+\/>/, '<%=  ActionController::Base.helpers.image_tag("rails_mosaico/versafix/img/social_def/\1", class:"socialIcon") %>')
  	render html: new_template.result.html_safe
  end
end