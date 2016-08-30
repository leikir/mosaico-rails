require_dependency "blorgh/application_controller"
module RailsMosaico
  class EmailEditorsController < ApplicationController
    
    def show
      # redirect_to '/mosaico/editor.html'
      # render :file => 'public/500.html', :status => 500, :layout => false

      render :file => "#{Rails.root}/public/mosaico/editor.html", :layout => false
    end
  end
end