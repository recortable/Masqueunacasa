class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title, limit: 200
      t.string :image
      t.references :user
      t.integer :imageable_id
      t.string :imageable_type
    end
    # ¿Habría que añadir algún indice más?
    add_index :images, [:imageable_type, :imageable_id]
  end
end
