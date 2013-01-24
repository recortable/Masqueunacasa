class DeleteAllAboutAnnouncements < ActiveRecord::Migration
  def up
    drop_table :announcements
  end

  def down
    create_table :announcements do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :scope, limit: 20
      t.string :title, limit: 300
      t.text :body
      t.datetime :sent_at
      t.timestamps
    end

    add_index :announcements, :user_id
    add_index :announcements, :group_id
  end
end
