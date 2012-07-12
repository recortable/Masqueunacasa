class DestroyTableUsers < ActiveRecord::Migration
  def up
    drop_table :users
    drop_table :groups
  end

  def down
    create_table :users
    create_table :groups
  end
end
