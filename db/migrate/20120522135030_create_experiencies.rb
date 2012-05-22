class CreateExperiencies < ActiveRecord::Migration
  def change
    create_table :experiencies do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :title_es, limit: 300
      t.string :title_ca, limit: 300
      t.string :slug_es, limit: 300
      t.string :slug_ca, limit: 300
      t.text :body_es
      t.text :body_ca
      t.boolean :published, default: true
      t.integer :proposals_count
      t.timestamps
    end
  end
end
