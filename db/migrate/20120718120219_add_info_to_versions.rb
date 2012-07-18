class AddInfoToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :document_type, :string
    add_column :versions, :document_id, :integer
    add_column :versions, :parent_title, :string, limit: 200

    migrate_data if Version.new.respond_to?(:parent_title)
  end

  def migrate_data
    Version.all.each do |version|
      item = version.item
      if item
        if version.item_type == 'Section' || version.item_type == 'Task'
          version.title = item.version_title.truncate(200)
          version.document = item.document 
          version.parent_title = item.document.title.truncate(200) if version.document
        elsif version.item_type == 'Content'
          group = item.group
          if group
            version.group = group
            version.parent_title = group.title.truncate(200)
          end
        else
          version.parent_title = 'Habitapedia'
        end
      end

      version.save
    end
  end
end
