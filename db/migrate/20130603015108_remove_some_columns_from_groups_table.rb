class RemoveSomeColumnsFromGroupsTable < ActiveRecord::Migration
  def up
    remove_column :groups, :banner_image, :type
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
