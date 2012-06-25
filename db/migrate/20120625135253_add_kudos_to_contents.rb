class AddKudosToContents < ActiveRecord::Migration
  def change
    add_column :contents, :kudos_count, :integer, default: 0
    add_column :contents, :subscribers_count, :integer, default: 0
    add_column :contents, :view_count, :integer, default: 0
  end
end
