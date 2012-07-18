class AddImageCredits < ActiveRecord::Migration
  def change
    add_column :images, :credits, :string, limit: 300
  end
end
