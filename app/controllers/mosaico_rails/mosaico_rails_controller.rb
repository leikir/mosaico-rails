class MosaicoRails::MosaicoRailsController < MosaicoRails.parent_controller.constantize
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  def set_default_gallery
    begin
      @current_gallery = current_gallery
    rescue NameError => e
      @current_gallery = MosaicoRails::Gallery.first_or_create
    end
  end
end