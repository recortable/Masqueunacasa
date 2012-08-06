class RemoveColorFromPhases < ActiveRecord::Migration
  def up
    remove_column :phases, :color
  end

  def down
    add_column :phases, :color, :string, limit: 16
  end
end
