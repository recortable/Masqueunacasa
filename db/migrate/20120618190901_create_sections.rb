class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :proposal_id
      t.string :lang, limit: 2
      t.integer :position, null: false

      t.string :title, limit: 200
      t.text :body
      t.string :body_type, limit: 16

      t.string :image
      t.text :properties

      t.timestamps
    end
    add_index :sections, :proposal_id
    add_index :sections, [:proposal_id, :lang]
    add_index :sections, :position
  end
end
