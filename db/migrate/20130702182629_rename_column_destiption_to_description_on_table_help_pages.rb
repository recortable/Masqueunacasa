class RenameColumnDestiptionToDescriptionOnTableHelpPages < ActiveRecord::Migration
  def up
    execute "ALTER TABLE help_pages RENAME COLUMN desctiption TO description"
  end

  def down
  end
end
