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

ActiveRecord::Schema.define(:version => 20120516193703) do

  create_table "contents", :force => true do |t|
    t.string   "title_es"
    t.string   "title_ca"
    t.string   "title_en"
    t.string   "slug"
    t.string   "type",           :limit => 32
    t.integer  "user_id"
    t.integer  "group_id"
    t.date     "published_at"
    t.text     "body_es"
    t.text     "body_ca"
    t.text     "body_en"
    t.integer  "comments_count",               :default => 0
    t.text     "embed"
    t.string   "image"
    t.string   "link_url"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "contents", ["group_id"], :name => "index_contents_on_group_id"
  add_index "contents", ["published_at"], :name => "index_contents_on_published_at"
  add_index "contents", ["slug"], :name => "index_contents_on_slug"
  add_index "contents", ["type"], :name => "index_contents_on_type"
  add_index "contents", ["user_id"], :name => "index_contents_on_user_id"

  create_table "groups", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
    t.string  "slug"
    t.string  "description_es", :limit => 1024
    t.string  "description_ca", :limit => 1024
    t.string  "description_en", :limit => 1024
    t.string  "banner_image"
    t.string  "avatar_image"
    t.float   "latitude"
    t.float   "longitude"
    t.string  "city"
    t.string  "country"
    t.string  "lang"
    t.string  "settings"
    t.string  "website"
    t.string  "twitter"
    t.string  "facebook"
  end

  add_index "groups", ["name"], :name => "index_groups_on_name", :unique => true
  add_index "groups", ["slug"], :name => "index_groups_on_slug", :unique => true

  create_table "memberships", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.string   "state",      :limit => 20
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "memberships", ["group_id"], :name => "index_memberships_on_group_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "phases", :force => true do |t|
    t.string   "name_es",        :limit => 50
    t.string   "name_ca",        :limit => 50
    t.text     "description_es"
    t.text     "description_ca"
    t.string   "slug_es",        :limit => 50
    t.string   "slug_ca",        :limit => 50
    t.integer  "position"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "phases", ["slug_ca"], :name => "index_phases_on_slug_ca"
  add_index "phases", ["slug_es"], :name => "index_phases_on_slug_es"

  create_table "proposals", :force => true do |t|
    t.string   "title_es",       :limit => 200
    t.string   "title_ca",       :limit => 200
    t.string   "slug_es",        :limit => 200
    t.string   "slug_ca",        :limit => 200
    t.integer  "user_id"
    t.integer  "phase_id"
    t.integer  "group_id"
    t.boolean  "published",                      :default => true
    t.string   "description_es", :limit => 1000
    t.string   "description_ca", :limit => 1000
    t.text     "body_es"
    t.text     "body_ca"
    t.text     "settings"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "proposals", ["slug_ca"], :name => "index_proposals_on_slug_ca"
  add_index "proposals", ["slug_es"], :name => "index_proposals_on_slug_es"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "country"
    t.string   "lang"
    t.boolean  "admin",                  :default => false
    t.string   "settings"
    t.string   "email",                  :default => "",    :null => false
    t.string   "password_digest",        :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "login_count",            :default => 0
    t.datetime "last_login_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "avatar_image"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",                 :null => false
    t.integer  "item_id",                   :null => false
    t.string   "event",                     :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.string   "user_name",  :limit => 50
    t.string   "title",      :limit => 200
    t.integer  "group_id"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
