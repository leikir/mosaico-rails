# Warning: This gem implements only 2 storage adapters:
# + filesystem
# + Amazon   s3

module MosaicoRails
  class Image < ApplicationRecord
    belongs_to :gallery,
      foreign_key: :mosaico_rails_gallery_id

    has_attached_file :image,
      { default_url: "/images/:style/missing.png",
        styles: Proc.new { |attachment| attachment.instance.styles },
      }.merge(MosaicoRails::Engine.config.paperclip_defaults || {}) # Here, merge had to be explicit

    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

    before_create :set_image_url

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
      image.reprocess!(dynamic_style_format_symbol) unless image.exists?(dynamic_style_format_symbol)
      image.url(dynamic_style_format_symbol)
    end

    def as_json(options = {})
      hostname = options[:host] if MosaicoRails::Engine.config.paperclip_defaults[:storage] == :s3
      {
        deleteType: 'DELETE',
        deleteUrl: "#{hostname}delete/#{self.id}",
        name: self.image_file_name,
        size: self.image_file_size,
        thumbnailUrl: "#{hostname}#{self.image.url(:thumbnail)}",
        url: self.image_url # original file
      }
    end

    def set_image_url
      if self.image.options[:storage] == :s3
        img_url = 'https://' +
          MosaicoRails::Engine.config.paperclip_defaults[:s3_region] +
          '/' +
          MosaicoRails::Engine.config.paperclip_defaults[:s3_credentials][:bucket] +
          self.image.path
      elsif self.image.options[:storage] == :filesystem
        img_url = self.image.url.split('?')[0]
      end
      self.image_url = img_url 
    end
  end
end
