class RemoveExternalImageUrlFromImages < ActiveRecord::Migration
  def up
    remove_column :images, :external_image_url
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
