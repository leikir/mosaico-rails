class AddImageUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :mosaico_rails_images, :image_url, :string
  end
end
