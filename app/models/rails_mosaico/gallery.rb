module RailsMosaico
  class Gallery < ApplicationRecord
    has_many :images,
      foreign_key: :rails_mosaico_gallery_id
  end
end
