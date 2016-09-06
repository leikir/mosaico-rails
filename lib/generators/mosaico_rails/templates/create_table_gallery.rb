class CreateTableMosaicoRailsGalleries < ActiveRecord::Migration
  def change
    create_table(:mosaico_rails_galleries) do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
