class AddExternalImageToImage < ActiveRecord::Migration
  def change
    add_column :images, :external_image_url, :string
    
    add_index :images, :user_id
  end
end
