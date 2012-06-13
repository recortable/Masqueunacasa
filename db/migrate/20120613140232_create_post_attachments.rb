class CreatePostAttachments < ActiveRecord::Migration
  def change
    create_table :post_attachments do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :post_id
      t.string :title, limit: 200
      t.string :file
      t.string :content_type
      t.integer :size

      t.timestamps
    end
  end
end
