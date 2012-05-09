class AddUserAvatar < ActiveRecord::Migration
  def up
    add_column :users, :avatar_image, :string
  end

  def down
    remove_column :users, :avatar_image
  end
end
