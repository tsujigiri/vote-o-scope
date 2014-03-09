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

ActiveRecord::Schema.define(version: 20140309105355) do

  create_table "answers", force: true do |t|
    t.integer "party_id"
    t.integer "question_id"
    t.integer "answer",      default: 0, null: false
    t.text    "reasoning"
  end

  create_table "parties", force: true do |t|
    t.string "name"
  end

  create_table "questions", force: true do |t|
    t.string "short"
    t.text   "long"
  end

  create_table "users", force: true do |t|
    t.string  "email",                default: "", null: false
    t.string  "encrypted_password",   default: "", null: false
    t.string  "authentication_token"
    t.integer "party_id"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
