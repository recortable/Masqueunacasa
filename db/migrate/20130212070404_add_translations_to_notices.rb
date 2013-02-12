class AddTranslationsToNotices < ActiveRecord::Migration
  def up
    Notice.create_translation_table!({
      title: { type: :string, limit: 200 },
      body: { type: :string, limit: 1000 }
    }, {
      migrate_data: true
    })

    add_column :notices, :original_locale, :string, limit: 4

    remove_column :notices, :title, :body

    Notice.all.each do |notice|
      notice.update_column :original_locale, 'es'
    end
  end

  def down
    add_column :notices, :title, :string, limit: 200
    add_column :notices, :body, :string, limit: 1000

    remove_column :notices, :original_locale

    Notice.drop_translation_table! migrate_data: true
  end
end
