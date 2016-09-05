module MosaicoRails
  class Gallery < ApplicationRecord
    has_many :images,
      foreign_key: :mosaico_rails_gallery_id

    belongs_to :mosaico_rails_imageable, polymorphic: true, optional: true

  end
end
