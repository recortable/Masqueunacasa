class DropNotNullFromHelpTextsTranslationsBody < ActiveRecord::Migration
  def up
    execute "ALTER TABLE help_text_translations ALTER COLUMN body DROP NOT NULL"
  end

  def down
  end
end
