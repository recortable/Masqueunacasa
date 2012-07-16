class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :document_type, limit: 16
      t.integer :document_id
      t.string :title, limit: 300
      t.boolean :finished, default: false
      t.integer :user_id
      t.timestamps
    end
    add_index :tasks, [:document_type, :document_id]
    add_index :tasks, :finished
  end
end
