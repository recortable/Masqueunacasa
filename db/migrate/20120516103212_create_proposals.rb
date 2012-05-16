class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :title_es, limit: 200
      t.string :title_ca, limit: 200
      t.string :slug_es, limit: 200
      t.string :slug_ca, limit: 200
      t.integer :user_id
      t.integer :phase_id
      t.integer :group_id
      t.boolean :published, default: true
      t.string :description_es, limit: 1000
      t.string :description_ca, limit: 1000
      t.text :body_es
      t.text :body_ca
      t.text :settings
      t.timestamps
    end

    add_index :proposals, :slug_es
    add_index :proposals, :slug_ca
  end
end
