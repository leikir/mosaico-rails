class CreateTableMosaicoRailsImages < ActiveRecord::Migration
  def change
    create_table(:mosaico_rails_images) do |t|
      t.integer  "mosaico_rails_image_id"
      t.integer  "mosaico_rails_gallery_id"
      t.datetime "created_at",         null: false
      t.datetime "updated_at",         null: false
      t.string   "image_file_name"
      t.string   "image_content_type"
      t.integer  "image_file_size"
      t.datetime "image_updated_at"
      t.string "image_url"

      t.index ["mosaico_rails_image_id"], name: "index_mosaico_image_on_mosaico_gallery_id", using: :btree
    end
  end
end
