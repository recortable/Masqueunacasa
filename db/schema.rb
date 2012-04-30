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

ActiveRecord::Schema.define(:version => 20120430074728) do

  create_table "agents", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "description"
    t.string   "type",                   :limit => 32
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "country"
    t.string   "lang"
    t.boolean  "admin",                                :default => false
    t.string   "settings"
    t.string   "email",                                :default => "",    :null => false
    t.string   "encrypted_password",                   :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
  end

  add_index "agents", ["authentication_token"], :name => "index_agents_on_authentication_token", :unique => true
  add_index "agents", ["email"], :name => "index_agents_on_email"
  add_index "agents", ["name"], :name => "index_agents_on_name", :unique => true
  add_index "agents", ["reset_password_token"], :name => "index_agents_on_reset_password_token", :unique => true
  add_index "agents", ["slug"], :name => "index_agents_on_slug", :unique => true
  add_index "agents", ["type"], :name => "index_agents_on_type"

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
    t.integer  "comments_count"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "contents", ["group_id"], :name => "index_contents_on_group_id"
  add_index "contents", ["published_at"], :name => "index_contents_on_published_at"
  add_index "contents", ["slug"], :name => "index_contents_on_slug"
  add_index "contents", ["type"], :name => "index_contents_on_type"
  add_index "contents", ["user_id"], :name => "index_contents_on_user_id"

end
