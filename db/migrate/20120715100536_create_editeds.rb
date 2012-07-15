class CreateEditeds < ActiveRecord::Migration
  def change
    create_table :editeds do |t|
      t.integer :document_id
      t.string :document_type, limit: 16
      t.integer :user_id
      t.datetime :created_at
    end
    add_index :editeds, [:document_type, :document_id]
    add_index :editeds, :user_id

    [Category, Proposal, Experiencie, Content].each do |klass|
      table = klass.table_name
      add_column table, :editeds_count, :integer, default: 0
      klass.all.each do |model|
        Edited.create!(document: model, user: model.user)
      end
    end
  end
end
