class CreateTableMosaicoRailsGalleries < ActiveRecord::Migration
  def change
    create_table(:mosaico_rails_galleries) do |t|
      t.timestamps
    end
  end
end
