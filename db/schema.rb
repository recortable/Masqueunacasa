# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130603015108) do

  create_table "categories", :force => true do |t|
    t.integer  "phase_id"
    t.integer  "user_id"
    t.string   "slug_es",           :limit => 100
    t.string   "slug_ca",           :limit => 100
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.string   "body_type",         :limit => 16
    t.integer  "position"
    t.integer  "kudos_count",                      :default => 0
    t.integer  "view_count",                       :default => 0
    t.integer  "editorships_count",                :default => 0
    t.string   "image"
    t.string   "slug_en",           :limit => 100
    t.string   "slug_it",           :limit => 100
    t.string   "slug_fr",           :limit => 100
    t.string   "original_locale",   :limit => 4
  end

  add_index "categories", ["phase_id"], :name => "index_categories_on_phase_id"
  add_index "categories", ["slug_ca"], :name => "index_categories_on_slug_ca", :unique => true
  add_index "categories", ["slug_en"], :name => "index_categories_on_slug_en"
  add_index "categories", ["slug_es"], :name => "index_categories_on_slug_es", :unique => true
  add_index "categories", ["slug_fr"], :name => "index_categories_on_slug_fr"
  add_index "categories", ["slug_it"], :name => "index_categories_on_slug_it"
  add_index "categories", ["user_id"], :name => "index_categories_on_user_id"

  create_table "category_translations", :force => true do |t|
    t.integer  "category_id"
    t.string   "locale"
    t.string   "title",       :limit => 300
    t.string   "name",        :limit => 100
    t.text     "summary"
    t.text     "body"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "category_translations", ["category_id"], :name => "index_category_translations_on_category_id"
  add_index "category_translations", ["locale"], :name => "index_category_translations_on_locale"

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "editorships", :force => true do |t|
    t.integer  "document_id"
    t.string   "document_type", :limit => 16
    t.integer  "user_id"
    t.datetime "created_at"
  end

  add_index "editorships", ["document_type", "document_id"], :name => "index_editorships_on_document_type_and_document_id"
  add_index "editorships", ["user_id"], :name => "index_editorships_on_user_id"

  create_table "experiencie_translations", :force => true do |t|
    t.integer  "experiencie_id"
    t.string   "locale"
    t.string   "title",          :limit => 300
    t.text     "summary"
    t.text     "body"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "experiencie_translations", ["experiencie_id"], :name => "index_experiencie_translations_on_experiencie_id"
  add_index "experiencie_translations", ["locale"], :name => "index_experiencie_translations_on_locale"

  create_table "experiencies", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "slug_es",           :limit => 300
    t.string   "slug_ca",           :limit => 300
    t.boolean  "published",                        :default => true
    t.integer  "proposals_count",                  :default => 0
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.string   "body_type",         :limit => 16
    t.integer  "kudos_count",                      :default => 0
    t.integer  "view_count",                       :default => 0
    t.integer  "editorships_count",                :default => 0
    t.string   "slug_en",           :limit => 100
    t.string   "slug_it",           :limit => 100
    t.string   "slug_fr",           :limit => 100
    t.string   "original_locale",   :limit => 4
  end

  add_index "experiencies", ["group_id"], :name => "index_experiencies_on_group_id"
  add_index "experiencies", ["slug_ca"], :name => "index_experiencies_on_slug_ca"
  add_index "experiencies", ["slug_en"], :name => "index_experiencies_on_slug_en"
  add_index "experiencies", ["slug_es"], :name => "index_experiencies_on_slug_es"
  add_index "experiencies", ["slug_fr"], :name => "index_experiencies_on_slug_fr"
  add_index "experiencies", ["slug_it"], :name => "index_experiencies_on_slug_it"
  add_index "experiencies", ["user_id"], :name => "index_experiencies_on_user_id"

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "group_translations", :force => true do |t|
    t.integer  "group_id"
    t.string   "locale"
    t.string   "title",      :limit => 300
    t.text     "summary"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "group_translations", ["group_id"], :name => "index_group_translations_on_group_id"
  add_index "group_translations", ["locale"], :name => "index_group_translations_on_locale"

  create_table "groups", :force => true do |t|
    t.string   "name",              :limit => 50
    t.string   "slug",              :limit => 50
    t.string   "avatar_image"
    t.string   "email"
    t.text     "settings"
    t.integer  "kudos_count",                     :default => 0
    t.integer  "view_count",                      :default => 0
    t.integer  "user_id"
    t.integer  "memberships_count"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "original_locale",   :limit => 3
  end

  add_index "groups", ["email"], :name => "index_agents_on_email"
  add_index "groups", ["slug"], :name => "index_agents_on_slug"

  create_table "images", :force => true do |t|
    t.string  "title",              :limit => 200
    t.string  "image"
    t.integer "user_id"
    t.integer "imageable_id"
    t.string  "imageable_type"
    t.integer "position"
    t.string  "external_image_url"
    t.string  "credits",            :limit => 300
  end

  add_index "images", ["imageable_type", "imageable_id"], :name => "index_images_on_imageable_type_and_imageable_id"
  add_index "images", ["user_id"], :name => "index_images_on_user_id"

  create_table "kudos", :force => true do |t|
    t.integer  "document_id"
    t.string   "document_type", :limit => 16
    t.integer  "user_id"
    t.string   "ip",            :limit => 16
    t.datetime "created_at"
  end

  add_index "kudos", ["document_type", "document_id"], :name => "index_kudos_on_document_type_and_document_id"
  add_index "kudos", ["user_id"], :name => "index_kudos_on_user_id"

  create_table "links", :force => true do |t|
    t.integer  "user_id"
    t.string   "title",         :limit => 300
    t.string   "url",           :limit => 500
    t.string   "content_type",  :limit => 32
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "document_id"
    t.string   "document_type", :limit => 32
  end

  add_index "links", ["user_id"], :name => "index_links_on_user_id"

  create_table "locations", :force => true do |t|
    t.string   "resource_type", :limit => 16
    t.integer  "resource_id"
    t.integer  "user_id"
    t.string   "title",         :limit => 200
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "memberships", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "memberships", ["group_id"], :name => "index_memberships_on_group_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.integer  "reply_to_id"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "messages", ["group_id"], :name => "index_messages_on_group_id"
  add_index "messages", ["reply_to_id"], :name => "index_messages_on_reply_to_id"
  add_index "messages", ["resource_id", "resource_type"], :name => "index_messages_on_resource_id_and_resource_type"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "notice_translations", :force => true do |t|
    t.integer  "notice_id"
    t.string   "locale"
    t.string   "title",      :limit => 200
    t.string   "body",       :limit => 1000
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "notice_translations", ["locale"], :name => "index_notice_translations_on_locale"
  add_index "notice_translations", ["notice_id"], :name => "index_notice_translations_on_notice_id"

  create_table "notices", :force => true do |t|
    t.string   "embed",           :limit => 1000
    t.string   "image",           :limit => 200
    t.integer  "position"
    t.string   "list",            :limit => 16
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "link",            :limit => 400
    t.string   "original_locale", :limit => 4
  end

  add_index "notices", ["list"], :name => "index_notices_on_list"
  add_index "notices", ["position"], :name => "index_notices_on_position"

  create_table "phase_translations", :force => true do |t|
    t.integer  "phase_id"
    t.string   "locale"
    t.string   "title",      :limit => 50
    t.text     "summary"
    t.string   "question",   :limit => 300
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "phase_translations", ["locale"], :name => "index_phase_translations_on_locale"
  add_index "phase_translations", ["phase_id"], :name => "index_phase_translations_on_phase_id"

  create_table "phases", :force => true do |t|
    t.string   "slug_es",         :limit => 50
    t.string   "slug_ca",         :limit => 50
    t.integer  "position"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.integer  "kudos_count",                    :default => 0
    t.integer  "view_count",                     :default => 0
    t.string   "slug_en",         :limit => 50
    t.string   "slug_it",         :limit => 100
    t.string   "slug_fr",         :limit => 100
    t.string   "original_locale", :limit => 4
  end

  add_index "phases", ["slug_ca"], :name => "index_phases_on_slug_ca"
  add_index "phases", ["slug_en"], :name => "index_phases_on_slug_en"
  add_index "phases", ["slug_es"], :name => "index_phases_on_slug_es"
  add_index "phases", ["slug_fr"], :name => "index_phases_on_slug_fr"
  add_index "phases", ["slug_it"], :name => "index_phases_on_slug_it"

  create_table "post_attachments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "post_id"
    t.string   "title",        :limit => 200
    t.string   "file"
    t.string   "content_type"
    t.integer  "size"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "proposal_translations", :force => true do |t|
    t.integer  "proposal_id"
    t.string   "locale"
    t.string   "title",       :limit => 200
    t.string   "description", :limit => 1000
    t.text     "body"
    t.text     "summary"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "proposal_translations", ["locale"], :name => "index_proposal_translations_on_locale"
  add_index "proposal_translations", ["proposal_id"], :name => "index_proposal_translations_on_proposal_id"

  create_table "proposals", :force => true do |t|
    t.string   "slug_es",            :limit => 200
    t.string   "slug_ca",            :limit => 200
    t.integer  "user_id"
    t.integer  "phase_id"
    t.integer  "group_id"
    t.boolean  "published",                         :default => true
    t.text     "settings"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.integer  "category_id"
    t.string   "body_type",          :limit => 16
    t.integer  "position"
    t.integer  "kudos_count",                       :default => 0
    t.integer  "view_count",                        :default => 0
    t.integer  "editorships_count",                 :default => 0
    t.integer  "experiencies_count",                :default => 0
    t.string   "slug_en",            :limit => 100
    t.string   "slug_it",            :limit => 100
    t.string   "slug_fr",            :limit => 100
    t.string   "original_locale",    :limit => 4
  end

  add_index "proposals", ["category_id"], :name => "index_proposals_on_category_id"
  add_index "proposals", ["slug_ca"], :name => "index_proposals_on_slug_ca"
  add_index "proposals", ["slug_en"], :name => "index_proposals_on_slug_en"
  add_index "proposals", ["slug_es"], :name => "index_proposals_on_slug_es"
  add_index "proposals", ["slug_fr"], :name => "index_proposals_on_slug_fr"
  add_index "proposals", ["slug_it"], :name => "index_proposals_on_slug_it"

  create_table "relations", :force => true do |t|
    t.integer  "experiencie_id"
    t.integer  "proposal_id"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "phase_id"
    t.integer  "category_id"
  end

  add_index "relations", ["experiencie_id"], :name => "index_relations_on_experiencie_id"
  add_index "relations", ["proposal_id"], :name => "index_relations_on_proposal_id"
  add_index "relations", ["user_id"], :name => "index_relations_on_user_id"

  create_table "sections", :force => true do |t|
    t.string   "locale",        :limit => 2
    t.integer  "position",                     :null => false
    t.string   "title",         :limit => 200
    t.text     "body"
    t.string   "image"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "document_id"
    t.string   "document_type", :limit => 16
    t.integer  "group_id"
    t.string   "type",          :limit => 80
  end

  add_index "sections", ["document_type", "document_id", "locale"], :name => "index_sections_on_document_type_and_document_id_and_lang"
  add_index "sections", ["document_type", "document_id"], :name => "index_sections_on_document_type_and_document_id"
  add_index "sections", ["position"], :name => "index_sections_on_position"

  create_table "users", :force => true do |t|
    t.string   "name",                 :limit => 50
    t.string   "summary",              :limit => 500
    t.string   "slug",                 :limit => 50
    t.boolean  "admin"
    t.string   "email"
    t.string   "avatar_image"
    t.string   "password_digest"
    t.string   "reset_password_token"
    t.integer  "login_count"
    t.datetime "last_login_at"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

end
