class AddSocialToGroups < ActiveRecord::Migration
  def change
    change_column :groups, :description_es, :string, limit: 1024
    change_column :groups, :description_ca, :string, limit: 1024
    change_column :groups, :description_en, :string, limit: 1024
    add_column :groups, :website, :string
    add_column :groups, :twitter, :string
    add_column :groups, :facebook, :string
  end
end
