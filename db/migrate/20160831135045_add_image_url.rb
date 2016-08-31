class AddImageUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :rails_mosaico_images, :image_url, :string
  end
end
