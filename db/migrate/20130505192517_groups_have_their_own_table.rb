class GroupsHaveTheirOwnTable < ActiveRecord::Migration
  def up
    rename_table :agents, :groups
    add_column :groups, :original_locale, :string, limit: 3

    execute "UPDATE sections SET document_type = 'Group' WHERE document_type = 'Agent'"
    execute "UPDATE locations SET resource_type = 'Group' WHERE resource_type = 'Agent'"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
