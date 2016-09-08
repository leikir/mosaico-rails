module MosaicoRails
  class Gallery < ApplicationRecord
    has_many :images,
      foreign_key: :mosaico_rails_gallery_id

    if Rails::VERSION::MAJOR == 5
      belongs_to :mosaico_rails_imageable, polymorphic: true, optional: true
    else
      belongs_to :mosaico_rails_imageable, polymorphic: true
    end

  end
end
