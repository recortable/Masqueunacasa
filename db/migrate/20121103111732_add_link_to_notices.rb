class AddLinkToNotices < ActiveRecord::Migration
  def change
    add_column :notices, :link, :string, limit: 400
  end
end
