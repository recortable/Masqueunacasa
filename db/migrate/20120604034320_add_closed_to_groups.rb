class AddClosedToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :closed, :boolean, default: false
  end
end
