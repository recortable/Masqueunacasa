class PrepareModelsForGlobalize3 < ActiveRecord::Migration
  def up
    ## CATEGORIES
    remove_column :categories, :title_ca, :name_ca, :summary_ca, :body_ca, :summary_en

    rename_column :categories, :title_es, :title
    rename_column :categories, :name_es, :name
    rename_column :categories, :summary_es, :summary
    rename_column :categories, :body_es, :body

    Category.create_translation_table!({
      title: { type: :string, limit: 300 },
      name: { type: :string, limit: 100 },
      summary: :text,
      body: :text
    }, {
      migrate_data: true
    })

    remove_column :categories, :title, :name, :summary, :body

    ## CONTENTS
    drop_table :contents

    ## EXPERIENCIES
    remove_column :experiencies, :title_ca,
                                 :body_ca,
                                 :summary_ca,
                                 :summary_en

    rename_column :experiencies, :title_es, :title
    rename_column :experiencies, :summary_es, :summary
    rename_column :experiencies, :body_es, :body

    Experiencie.create_translation_table!({
      title: { type: :string, limit: 300 },
      summary: :text,
      body: :text
    }, {
      migrate_data: true
    })

    remove_column :experiencies, :title, :summary, :body

    ## PHASES ##
    remove_column :phases, :title_ca,
                           :title_en,
                           :summary_ca,
                           :summary_en,
                           :question_ca,
                           :question_en

    rename_column :phases, :title_es, :title
    rename_column :phases, :summary_es, :summary
    rename_column :phases, :question_es, :question

    Phase.create_translation_table!({
      title: { type: :string, limit: 50 },
      summary: :text,
      question: { type: :string, limit: 300 }
    }, {
      migrate_data: true
    })

    remove_column :phases, :title, :summary, :question

    ## PROPOSALS ##
    remove_column :proposals, :title_ca,
                              :description_ca,
                              :body_ca,
                              :summary_ca,
                              :summary_en

    rename_column :proposals, :title_es, :title
    rename_column :proposals, :description_es, :description
    rename_column :proposals, :body_es, :body
    rename_column :proposals, :summary_es, :summary

    Proposal.create_translation_table!({
      title: { type: :string, limit: 200 },
      description: { type: :string, limit: 1000 },
      body: :text,
      summary: :text
    }, {
      migrate_data: true
    })

    remove_column :proposals, :title, :description, :body, :summary
  end

  ####################
  ####################
  ####################

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
