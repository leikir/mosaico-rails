class AddPolymorphicAssociationToGallery < ActiveRecord::Migration[5.0]
  def change
    add_column :rails_mosaico_galleries, :rails_mosaico_imageable_id, :integer
    add_column :rails_mosaico_galleries, :rails_mosaico_imageable_type, :string
  
    add_index :rails_mosaico_galleries, [:rails_mosaico_imageable_type, :rails_mosaico_imageable_id], name: 'rails_mosaico_gallery_poly_association'
  end
end