class AddBlockedToHelpTexts < ActiveRecord::Migration
  def change
    add_column :help_texts, :blocked, :boolean
  end
end
