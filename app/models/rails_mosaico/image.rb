module RailsMosaico
  class Image < ApplicationRecord
    belongs_to :gallery,
      foreign_key: :rails_mosaico_gallery_id

    has_attached_file :image, styles: { thumbnail: '90x90' }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

    def as_json
      {
        deleteType: 'DELETE',
        deleteUrl: "#{ENV['URL_BASE']}delete/#{self.id}",
        name: self.image_file_name,
        size: self.image_file_size,
        thumbnailUrl: "#{ENV['URL_BASE']}#{self.image.url(:thumbnail)}",
        url: "#{ENV['URL_BASE']}#{self.image.url}"
      }
    end
  end
end
