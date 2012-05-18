class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :user
      t.belongs_to :group
      t.belongs_to :resource, polymorphic: true
      t.belongs_to :reply_to
      t.text :body
      t.timestamps
    end

    add_index :messages, :user_id
    add_index :messages, :group_id
    add_index :messages, [:resource_id, :resource_type]
    add_index :messages, :reply_to_id
  end
end
