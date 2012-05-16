class AddMetadataToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :user_name, :string, limit: 50
    add_column :versions, :title, :string, limit: 200
    add_column :versions, :group_id, :integer
  end
end
