class CreateMosaicoRailsGalleries < ActiveRecord::Migration[5.0]
  def change
    create_table :mosaico_rails_galleries do |t|
      t.timestamps
    end
  end
end
