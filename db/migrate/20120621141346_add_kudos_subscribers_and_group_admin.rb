class AddKudosSubscribersAndGroupAdmin < ActiveRecord::Migration
  def change
    add_column :groups, :root, :boolean, default: false
    Group.first.update_attribute(:root, true)

    create_table :kudos do |t|
      t.integer :document_id
      t.string :document_type, limit: 16
      t.integer :user_id
      t.string :ip, limit: 16
      t.datetime :created_at
    end
    add_index :kudos, [:document_type, :document_id]
    add_index :kudos, :user_id

    create_table :subscribers do |t|
      t.integer :document_id
      t.string :document_type, limit: 16
      t.integer :user_id
      t.datetime :created_at
    end
    add_index :subscribers, [:document_type, :document_id]
    add_index :subscribers, :user_id

    [Phase, Category, Proposal, Experiencie].each do |model|
      table = model.table_name
      add_column table, :kudos_count, :integer, default: 0
      add_column table, :subscribers_count, :integer, default: 0
      add_column table, :view_count, :integer, default: 0
    end

  end
end
