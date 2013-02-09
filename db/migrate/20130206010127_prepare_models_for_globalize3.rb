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
    remove_column :contents, :title_ca,
                             :title_en,
                             :body_ca,
                             :body_en,
                             :summary_ca,
                             :summary_en

    rename_column :contents, :title_es, :title
    rename_column :contents, :body_es, :body
    rename_column :contents, :summary_es, :summary

    Content.create_translation_table!({
      title: { type: :string, limit: 300 },
      summary: :text,
      body: :text
    }, {
      migrate_data: true
    })

    remove_column :contents, :title, :body, :summary

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

    ## AGENTS ##
    remove_column :agents, :summary_ca, :summary_en
    rename_column :agents, :summary_es, :summary

    Agent.create_translation_table!({
      summary: { type: :string, limit: 500 }
    }, {
      migrate_data: true
    })

    remove_column :agents, :summary
  end

  ####################
  ####################
  ####################

  def down
    ## AGENTS ##
    add_column :agents, :summary, :string, limit: 500

    Agent.drop_translation_table! migrate_data: true

    rename_column :agents, :summary, :summary_es
    add_column :agents, :summary_ca, :string, limit: 500
    add_column :agents, :summary_en, :string, limit: 500

    ## POPOSALS ##
    add_column :proposals, :title, :string, limit: 200
    add_column :proposals, :description, :string, limit: 1000
    add_column :proposals, :body, :text
    add_column :proposals, :summary, :text

    Proposal.drop_translation_table! migrate_data: true

    rename_column :proposals, :title, :title_es
    rename_column :proposals, :description, :description_es
    rename_column :proposals, :body, :body_es
    rename_column :proposals, :summary, :summary_es

    add_column :proposals, :title_ca, :string, limit: 200
    add_column :proposals, :description_ca, :string, limit: 1000
    add_column :proposals, :body_ca, :text
    add_column :proposals, :summary_ca, :text
    add_column :proposals, :summary_en, :text

    ## PHASES ##
    add_column :phases, :title, :string, limit: 50
    add_column :phases, :summary, :text
    add_column :phases, :question, :string, limit: 300

    Phase.drop_translation_table! migrate_data: true

    rename_column :phases, :title, :title_es
    rename_column :phases, :summary, :summary_es
    rename_column :phases, :question, :question_es

    add_column :phases, :title_ca, :string, limit: 50
    add_column :phases, :title_en, :string, limit: 50
    add_column :phases, :summary_ca, :text
    add_column :phases, :summary_en, :text
    add_column :phases, :question_ca, :string, limit: 300
    add_column :phases, :question_en, :string, limit: 300

    ## EXPERIENCIES
    add_column :experiencies, :title, :string, limit: 300
    add_column :experiencies, :summary, :text
    add_column :experiencies, :body, :text

    Experiencie.drop_translation_table! migrate_data: true

    rename_column :experiencies, :title, :title_es
    rename_column :experiencies, :summary, :summary_es
    rename_column :experiencies, :body, :body_es
    add_column :experiencies, :title_ca, :string, limit: 300
    add_column :experiencies, :summary_ca, :text
    add_column :experiencies, :body_ca, :text
    add_column :experiencies, :summary_en, :text

    ## CONTENTS
    add_column :contents, :title, :string, limit: 300
    add_column :contents, :summary, :text
    add_column :contents, :body, :text

    Content.drop_translation_table! migrate_data: true

    rename_column :contents, :title, :title_es
    rename_column :contents, :summary, :summary_es
    rename_column :contents, :body, :body_es
    add_column :contents, :title_ca, :string, limit: 300
    add_column :contents, :summary_ca, :text
    add_column :contents, :body_ca, :text
    add_column :contents, :title_en, :string, limit: 300
    add_column :contents, :summary_en, :text
    add_column :contents, :body_en, :text

    ## CATEGORIES
    add_column :categories, :title, :string, limit: 300
    add_column :categories, :name, :string, limit: 100
    add_column :categories, :summary, :text
    add_column :categories, :body, :text

    Category.drop_translation_table! migrate_data: true

    rename_column :categories, :title, :title_es
    rename_column :categories, :name, :name_es
    rename_column :categories, :summary, :summary_es
    rename_column :categories, :body, :body_es
    add_column :categories, :title_ca, :string, limit: 300
    add_column :categories, :name_ca, :string, limit: 100
    add_column :categories, :summary_ca, :text
    add_column :categories, :body_ca, :text
    add_column :categories, :summary_en, :text
  end
end
