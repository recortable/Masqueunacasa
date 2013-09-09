class AddLocaleToComments < ActiveRecord::Migration
  def change
    add_column :comments, :locale, :string, limit: 6
  end
end
