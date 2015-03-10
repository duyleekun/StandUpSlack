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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150310120039) do

  create_table "tasks", force: true do |t|
    t.text     "description"
    t.integer  "user_id",     limit: 255
    t.integer  "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.text     "name"
    t.string   "token"
    t.string   "slack_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.text     "name"
    t.text     "real_name"
    t.integer  "team_id"
    t.string   "slack_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "im_slack_id"
    t.boolean  "daily_prompt_active",  default: true
    t.boolean  "daily_digest_enabled", default: true
  end

end
