class CreateLinks < ActiveRecord::Migration
  def change
      create_table :links do |t|
        t.integer :resource_id
        t.integer :resource_type
        t.integer :user_id

        t.string :title, limit: 300
        t.string :url, limit: 500
        t.string :content_type, limit: 32
        t.timestamps
      end

      add_index :links, [:resource_id, :resource_type]
      add_index :links, :user_id
  end
end
