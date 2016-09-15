# Warning: This gem implements only 2 storage adapters:
# + filesystem
# + Amazon   s3

module MosaicoRails
  class Image < ApplicationRecord
    belongs_to :gallery,
      foreign_key: :mosaico_rails_gallery_id

    has_attached_file :image, {
      styles: Proc.new { |attachment| attachment.instance.styles }
    }.merge(MosaicoRails::Engine.config.paperclip_defaults || {}) # Here, merge had to be explicit

    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

    after_create :set_image_url

    def dynamic_style_format_symbol
      CGI::escape(@dynamic_style_format).to_sym
    end

    def styles
      if @dynamic_style_format.present?
        { dynamic_style_format_symbol => @dynamic_style_format }
      else
        { thumbnail: '90x90>' }
      end
    end

    def dynamic_attachment_url(width, height, method)
      @dynamic_style_format = "#{width}x#{height}#{method}"
      image.reprocess!(dynamic_style_format_symbol)
      image.url(dynamic_style_format_symbol)
    end

    def as_json(options = {})
      {
        deleteType: 'DELETE',
        deleteUrl: "delete/#{self.id}",
        name: self.image_file_name,
        size: self.image_file_size,
        thumbnailUrl: "#{self.image.url(:thumbnail)}",
        url: self.image_url # original file
      }
    end

    def set_image_url
      if self.image.options[:storage] == :s3
        img_url = self.image.url
      elsif self.image.options[:storage] == :filesystem
        img_url = self.image.url.split('?')[0]
      end
      self.update(image_url: img_url)
    end
  end
end
