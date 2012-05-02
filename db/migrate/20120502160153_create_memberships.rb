class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :group
      t.references :user
      t.string :state, limit: 20
      t.timestamps
    end

    add_index :memberships, :group_id
    add_index :memberships, :user_id
  end
end
