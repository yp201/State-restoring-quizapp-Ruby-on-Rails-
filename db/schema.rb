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

ActiveRecord::Schema.define(version: 20170920000102) do

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leaderboard_genres", force: :cascade do |t|
    t.string   "genre_id"
    t.text     "ranklist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leaderboard_subgenres", force: :cascade do |t|
    t.string   "subgenre_id"
    t.text     "ranklist"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "subgenre_id"
    t.text     "question"
    t.text     "options"
    t.text     "answer"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "quizzes", force: :cascade do |t|
    t.string   "user_id"
    t.string   "genre_id"
    t.string   "subgenre_id"
    t.integer  "score"
    t.boolean  "ongoing"
    t.integer  "current_question"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "quizname"
    t.string   "genre_name"
    t.boolean  "powerup"
    t.boolean  "fifty_fifty"
  end

  create_table "subgenres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "genre_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
