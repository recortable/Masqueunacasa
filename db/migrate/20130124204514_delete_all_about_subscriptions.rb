class DeleteAllAboutSubscriptions < ActiveRecord::Migration
  def up
    drop_table :subscribers
    [Phase, Category, Proposal, Experiencie].each do |model|
      table = model.table_name
      remove_column table, :subscribers_count
    end
  end

  def down
    create_table "subscribers" do |t|
      t.integer  "document_id"
      t.string   "document_type", :limit => 16
      t.integer  "user_id"
      t.datetime "created_at"
    end

    add_index "subscribers", ["document_type", "document_id"], :name => "index_subscribers_on_document_type_and_document_id"
    add_index "subscribers", ["user_id"], :name => "index_subscribers_on_user_id"

    [Phase, Category, Proposal, Experiencie].each do |model|
      table = model.table_name
      add_column table, :subscribers_count
    end
  end
end
