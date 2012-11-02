class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :title, limit: 200
      t.string :body, limit: 1000
      t.string :embed, limit: 1000
      t.string :image, limit: 200
      t.integer :position
      t.string :list, limit: 16
      t.timestamps
    end
    add_index :notices, :list
    add_index :notices, :position
  end
end
