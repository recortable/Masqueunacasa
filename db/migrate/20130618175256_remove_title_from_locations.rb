class RemoveTitleFromLocations < ActiveRecord::Migration
  def up
    remove_column :locations, :title
  end

  def down
    add_column :locations, :string, limit: 200
  end
end
