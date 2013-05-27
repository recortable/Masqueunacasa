class User < Agent
  def self.current_user
    nil
  end
end

class SectionsSti < ActiveRecord::Migration
  def up
    rename_column :sections, :lang, :locale
    add_column :sections, :type, :string, limit: 80
    remove_column :sections, :body_type, :properties

    execute "DELETE FROM sections WHERE document_type = 'Content'"

    Section.all.each do |section|
      if section.image.present? and section.body.present?
        section.type = "ImageSection"
        new_section = section.document.text_sections.build(
          title: section.title,
          body: section.body,
          group_id: section.group_id,
          locale: section.locale
        )
        section.body = nil
        section.save!
        new_section.save!

      elsif section.image.present? and section.body.blank?
        section.type = "ImageSection"
        section.save!

      elsif section.image.blank? and section.body.present?
        section.type = "TextSection"
        section.save!
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
