class AddBlockedToHelpPages < ActiveRecord::Migration
  def change
    add_column :help_pages, :blocked, :boolean
  end
end
