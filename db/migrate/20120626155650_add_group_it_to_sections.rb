class AddGroupItToSections < ActiveRecord::Migration
  def up
    add_column :sections, :group_id, :integer
    migrate_data
  end

  def down
    remove_column :sections, :group_id
  end

  def migrate_data
    Group.all.each do |group|
      add_group_id([group], group.id)
      add_group_id(group.posts, group.id)
      add_group_id(group.pages, group.id)
    end
  end

  def add_group_id(documents, id)
    documents.each do |document|
      document.sections.update_all(group_id: id)
    end
  end
end
