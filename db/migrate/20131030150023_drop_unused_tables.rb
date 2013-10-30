class RemoveUnusedTables < ActiveRecord::Migration
  def up
    drop_table :post_attachments
    drop_table :messages
    drop_table :ckeditor_assets
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

