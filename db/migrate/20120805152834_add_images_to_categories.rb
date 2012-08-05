class AddImagesToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :image, :string
    add_column :phases, :color, :string, limit: 16
  end
end
