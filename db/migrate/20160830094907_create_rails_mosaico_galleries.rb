class CreateRailsMosaicoGalleries < ActiveRecord::Migration[5.0]
  def change
    create_table :rails_mosaico_galleries do |t|
      t.string :name

      t.timestamps
    end
  end
end
