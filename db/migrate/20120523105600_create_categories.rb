class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :phase_id
      t.integer :user_id
      t.string :title_es, limit: 100
      t.string :title_ca, limit: 100
      t.string :slug_es, limit: 100
      t.string :slug_ca, limit: 100
      t.string :question_es, limit: 300
      t.string :question_ca, limit: 300
      t.text :body_ca
      t.text :body_es

      t.timestamps
    end

    add_index :categories, :phase_id
    add_index :categories, :user_id
    add_index :categories, :slug_es, unique: true
    add_index :categories, :slug_ca, unique: true

    add_column :proposals, :category_id, :integer
    add_index :proposals, :category_id
  end
end
