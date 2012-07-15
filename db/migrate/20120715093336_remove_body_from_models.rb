class RemoveBodyFromModels < ActiveRecord::Migration
  def up
    remove_column :categories, :body_es
    remove_column :categories, :body_ca
    remove_column :categories, :summary_en


  end

  def down
  end
end
