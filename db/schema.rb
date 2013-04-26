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

ActiveRecord::Schema.define(version: 20130426205359) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attempts", force: true do |t|
    t.integer  "user_id"
    t.integer  "vocab_word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_answer_id"
  end

  add_index "attempts", ["user_answer_id"], name: "index_attempts_on_user_answer_id"
  add_index "attempts", ["user_id"], name: "index_attempts_on_user_id"
  add_index "attempts", ["vocab_word_id"], name: "index_attempts_on_vocab_word_id"

  create_table "choices", force: true do |t|
    t.integer  "vocab_word_id"
    t.integer  "attempt_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "vocab_words", force: true do |t|
    t.string   "name"
    t.string   "word_type"
    t.string   "definition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vocab_words", ["word_type"], name: "index_vocab_words_on_word_type"

end
