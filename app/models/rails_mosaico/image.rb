module RailsMosaico
  class Image < ApplicationRecord
    belongs_to :gallery,
      foreign_key: :rails_mosaico_gallery_id

    has_attached_file :image,
      # styles: { thumbnail: '90x90'}, { Proc.new { |attachment| attachment.instance.styles }},
      default_url: "/images/:style/missing.png",
      styles: Proc.new { |attachment| attachment.instance.styles }

    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

    after_create :set_image_url


    def dynamic_style_format_symbol
      URI.escape(@dynamic_style_format.gsub('>', '')).to_sym
    end

    def styles
      unless @dynamic_style_format.blank?
        {
          dynamic_style_format_symbol => @dynamic_style_format,
          thumbnail: '90x90>'
        }
      else
        {}
      end
    end

    def dynamic_attachment_url(format)
      @dynamic_style_format = format
      image.reprocess!(dynamic_style_format_symbol) unless image.exists?(dynamic_style_format_symbol)
      image.url(dynamic_style_format_symbol)
    end

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

    def set_image_url
      self.update(image_url: self.image.url)
    end
  end
end
