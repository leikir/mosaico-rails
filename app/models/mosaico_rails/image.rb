module MosaicoRails
  class Image < ApplicationRecord
    belongs_to :gallery,
      foreign_key: :mosaico_rails_gallery_id

    has_attached_file :image,
      {
        default_url: "/images/:style/missing.png",
        styles: Proc.new { |attachment| attachment.instance.styles },
      }.merge(MosaicoRails::Engine.config.paperclip_defaults || {})

    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

    after_create :set_image_url

    def dynamic_style_format_symbol
      CGI::escape(@dynamic_style_format).to_sym
    end

    def styles
      unless @dynamic_style_format.blank?
        {
          dynamic_style_format_symbol => @dynamic_style_format
        }
      else
        { thumbnail: '90x90>' }
      end
    end

    def dynamic_attachment_url(format)
      @dynamic_style_format = format
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
        s3_url = 'https://' +
          MosaicoRails::Engine.config.paperclip_defaults[:s3_region] +
          '/' +
          MosaicoRails::Engine.config.paperclip_defaults[:s3_credentials][:bucket] +
          self.image.path
        self.update(image_url: s3_url)
      elsif self.image.options[:storage] == :filesystem
        self.update(image_url: self.image.url.split('?')[0])
      end
    end
  end
end
