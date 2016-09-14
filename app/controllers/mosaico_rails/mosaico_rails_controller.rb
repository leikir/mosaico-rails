class MosaicoRails::MosaicoRailsController < Api::V1::BaseController#MosaicoRails.parent_controller.constantize
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

end