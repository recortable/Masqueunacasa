class CreateGroups < ActiveRecord::Migration
  def change
    create_table(:groups) do |t|
      t.belongs_to :user
      t.string :name
      t.string :slug
      t.string :description_es
      t.string :description_ca
      t.string :description_en
      t.string :banner_image
      t.string :avatar_image
      t.float  :latitude
      t.float  :longitude
      t.string :city
      t.string :country
      t.string :lang
      t.string :settings
    end

    add_index :groups, :name, unique: true
    add_index :groups, :slug, unique: true
  end
end



