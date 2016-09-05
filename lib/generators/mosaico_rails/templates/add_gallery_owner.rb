class AddPolymorphicAssociationToGallery < ActiveRecord::Migration[5.0]
  def change
    add_column :mosaico_rails_galleries, :mosaico_rails_imageable_id, :integer
    add_column :mosaico_rails_galleries, :mosaico_rails_imageable_type, :string
  
    add_index :mosaico_rails_galleries, [:mosaico_rails_imageable_type, :mosaico_rails_imageable_id], name: 'mosaico_rails_gallery_poly_association'
  end
end