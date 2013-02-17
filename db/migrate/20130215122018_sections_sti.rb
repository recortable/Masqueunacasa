class SectionsSti < ActiveRecord::Migration
  def up
    rename_column :sections, :lang, :locale
    add_column :sections, :type, :string, limit: 80
    remove_column :sections, :body_type, :properties

    Section.all.each do |section|
      unless section.image.blank?
        section.type = "ImageSection"
        section.save!
      end
      unless section.body.blank?
        if section.image.blank?
          section.type = "TextSection"
          section.save!
        else
          new_section = section.document.text_sections.build(
            title: section.title,
            body: section.body,
            group_id: section.group_id,
            locale: section.locale
          )
          new_section.save!
          section.update_attributes body: nil
        end
      end
    end
  end

  def down
    rename_column :sections, :locale, :lang
    remove_column :sections, :type
    add_column :sections, :body_type, :string, limit: 16
    add_column :sections, :properties, :text

    TextSection.all.each do |ts|
      ts.update_column :body_type, 'markdown'
    end
  end
end
