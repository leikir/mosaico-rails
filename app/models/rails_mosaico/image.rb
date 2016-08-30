module RailsMosaico
  class Image < ApplicationRecord
    belongs_to :gallery

    has_attached_file :image, styles: { sq_300: "300x300>", sq_100: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

    def as_json
      {
        deleteType: 'DELETE',
        deleteUrl: "http://localhost:4001/delete/#{self.id}",
        name: self.image_file_name,
        size: self.image_file_size,
        thumbnailUrl: "http://localhost:4001/#{self.image.url(:sq_300)}",
        url: "http://localhost:4001/#{self.image.url}"
      }
    end
  end
end
