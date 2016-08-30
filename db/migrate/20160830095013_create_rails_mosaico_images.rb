class CreateRailsMosaicoImages < ActiveRecord::Migration[5.0]
  def change
    create_table :rails_mosaico_images do |t|
      t.references :gallery, foreign_key: true
      t.string   "image_file_name"
      t.string   "image_content_type"
      t.integer  "image_file_size"
      t.datetime "image_updated_at"
      t.timestamps
    end
  end
end
