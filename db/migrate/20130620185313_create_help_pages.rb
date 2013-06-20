class CreateHelpPages < ActiveRecord::Migration
  def up
    create_table :help_pages do |t|
      t.string :identf, limit: 20, unique: true, null: false
      t.text :desctiption
      t.string :slug_ca, unique: true
      t.string :slug_en, unique: true
      t.string :slug_es, unique: true
      t.string :slug_it, unique: true
      t.string :slug_fr, unique: true

      t.string :original_locale, limit: 10, null: false

      t.timestamps
    end

    HelpPage.create_translation_table! title: :string, summary: :text

    add_index :help_pages, :slug_ca
    add_index :help_pages, :slug_en
    add_index :help_pages, :slug_es
    add_index :help_pages, :slug_it
    add_index :help_pages, :slug_fr
  end

  def down
    drop_table :help_pages
    HelpPage.drop_translation_table!
  end
end
