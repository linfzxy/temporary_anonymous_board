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

ActiveRecord::Schema.define(version: 20170321001224) do

  create_table "iptables", force: :cascade do |t|
    t.string  "ip"
    t.integer "counter"
    t.integer "lowerbounder"
    t.boolean "banned"
    t.index ["ip"], name: "index_iptables_on_ip"
  end

  create_table "messages", force: :cascade do |t|
    t.text    "content"
    t.string  "author"
    t.integer "ctime"
    t.string  "ip"
    t.integer "replycount"
    t.integer "lastreply"
    t.index ["lastreply"], name: "index_messages_on_lastreply"
  end

  create_table "replies", force: :cascade do |t|
    t.integer  "message"
    t.string   "author"
    t.text     "content"
    t.integer  "ctime"
    t.string   "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message"], name: "index_replies_on_message"
  end

  create_table "users", force: :cascade do |t|
    t.string  "nickname"
    t.string  "verifyword"
    t.string  "ip"
    t.integer "activitydate"
    t.index ["activitydate"], name: "index_users_on_activitydate"
    t.index ["nickname"], name: "index_users_on_nickname"
  end

end
