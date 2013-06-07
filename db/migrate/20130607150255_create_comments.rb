class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user
      t.integer :document_id
      t.string :document_type
      t.timestamps
    end
    add_index :comments, [:user_id]
    add_index :comments, [:document_id, :document_type]
  end
end
