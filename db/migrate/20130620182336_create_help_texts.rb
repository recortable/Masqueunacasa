class CreateHelpTexts < ActiveRecord::Migration
  def up
    create_table :help_texts do |t|
      t.string :identf, limit: 20, unique: true, null: false
      t.string :description

      t.timestamps
    end

    add_index :help_texts, :identf

    HelpText.create_translation_table! body: { type: :text, null: false }
  end

  def down
    drop_table :help_texts
    HelpText.drop_translation_table!
  end
end
