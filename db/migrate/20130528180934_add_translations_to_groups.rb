class AddTranslationsToGroups < ActiveRecord::Migration
  def up
    remove_column :groups, :admin, :lang, :password_digest,
      :reset_password_token, :login_count, :last_login_at,
      :summary_ca, :summary_en

    rename_column :groups, :summary_es, :summary

    Group.create_translation_table!({
      title: { type: :string, limit: 300 },
      summary: :text
    }, {
      migrate_data: true
    })

    remove_column :groups, :title, :summary
  end

  def down
    raise ActiveRecord::IreversibleMigration
  end
end
