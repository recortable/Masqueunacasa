class RemoveNoticesAndNoticesTranslations < ActiveRecord::Migration
  def up
    drop_table :notices
    drop_table :notice_translations
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
