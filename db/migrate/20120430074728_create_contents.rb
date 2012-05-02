class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title_es
      t.string :title_ca
      t.string :title_en
      t.string :slug
      t.string :type, limit: 32
      t.references :user
      t.references :group
      t.date :published_at
      t.text :body_es
      t.text :body_ca
      t.text :body_en
      t.integer :comments_count, default: 0
      t.text :embed
      t.string :image
      t.string :link_url
      t.timestamps
    end

    add_index :contents, :user_id
    add_index :contents, :group_id
    add_index :contents, :slug
    add_index :contents, :type
    add_index :contents, :published_at
  end
end
