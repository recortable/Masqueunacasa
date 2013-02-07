class RemoveVersions < ActiveRecord::Migration
  def up
    drop_table :versions
  end

  def down
    create_table :versions do |t|
      t.string   :item_type,     null: false
      t.string   :item_type,     null: false
      t.integer  :item_id,       null: false
      t.string   :event,         null: false
      t.string   :whodunnit
      t.text     :object
      t.datetime :created_at
      t.string   :user_name,     limit: 50
      t.string   :title,         limit: 200
      t.integer  :group_id
      t.string   :document_type
      t.integer  :document_id
      t.string   :parent_title,  limit: 200
    end

    add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"
  end
end
