class CreateEditorships < ActiveRecord::Migration
  def change
    create_table :editorships do |t|
      t.integer :document_id
      t.string :document_type, limit: 16
      t.integer :user_id
      t.datetime :created_at
    end

    add_index :editorships, [:document_type, :document_id]
    add_index :editorships, :user_id

    [Category, Proposal, Experiencie, Content].each do |klass|
      table = klass.table_name
      add_column table, :editorships_count, :integer, default: 0
      klass.all.each do |model|
        Editorship.create!(document: model, user: model.user)
      end
    end

  end
end
