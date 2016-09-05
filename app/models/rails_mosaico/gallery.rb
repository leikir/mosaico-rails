module RailsMosaico
  class Gallery < ApplicationRecord
    has_many :images,
      foreign_key: :rails_mosaico_gallery_id

    belongs_to :rails_mosaico_imageable, polymorphic: true, optional: true

  end
end
