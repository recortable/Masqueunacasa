class IncreaseLengthOfColumnIdentfOnTableHelpPages < ActiveRecord::Migration
  def up
    execute "ALTER TABLE help_pages ALTER COLUMN identf TYPE varchar(30)"
  end

  def down
  end
end
