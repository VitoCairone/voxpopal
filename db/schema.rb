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

ActiveRecord::Schema.define(version: 20160124200111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "choices", force: :cascade do |t|
    t.integer  "issue_id"
    t.integer  "speaker_id"
    t.text     "text"
    t.integer  "voice_tally_1"
    t.integer  "voice_tally_2"
    t.integer  "voice_tally_3"
    t.integer  "current_rank"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "choices", ["issue_id"], name: "index_choices_on_issue_id", using: :btree
  add_index "choices", ["speaker_id"], name: "index_choices_on_speaker_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "speaker_id"
    t.integer  "parent_id"
    t.string   "parent_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "comments", ["parent_type", "parent_id"], name: "index_comments_on_parent_type_and_parent_id", using: :btree
  add_index "comments", ["speaker_id"], name: "index_comments_on_speaker_id", using: :btree

  create_table "issues", force: :cascade do |t|
    t.string   "codename"
    t.integer  "speaker_id"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "issues", ["speaker_id"], name: "index_issues_on_speaker_id", using: :btree

  create_table "proposals", force: :cascade do |t|
    t.string   "code"
    t.integer  "speaker_id"
    t.text     "text"
    t.integer  "upvotes"
    t.integer  "downvotes"
    t.integer  "boost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "proposals", ["speaker_id"], name: "index_proposals_on_speaker_id", using: :btree

  create_table "speaker_histories", force: :cascade do |t|
    t.integer  "speaker_id"
    t.integer  "issue_spare_1_id"
    t.integer  "issue_spare_2_id"
    t.integer  "issue_spare_3_id"
    t.integer  "issue_next_id"
    t.integer  "issue_prev_id"
    t.integer  "issue_prev_position"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "speaker_histories", ["speaker_id"], name: "index_speaker_histories_on_speaker_id", using: :btree

  create_table "speakers", force: :cascade do |t|
    t.string   "codename"
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "starsign"
    t.string   "birth_month"
    t.integer  "birth_year"
    t.integer  "level"
    t.string   "session_token",      limit: 64
    t.string   "recall_token",       limit: 64
    t.boolean  "logged_in"
    t.datetime "last_action"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "speaker_history_id"
    t.boolean  "guest",                         default: true
    t.boolean  "admin",                         default: false
    t.integer  "verification_id"
  end

  add_index "speakers", ["codename"], name: "index_speakers_on_codename", unique: true, using: :btree
  add_index "speakers", ["email"], name: "index_speakers_on_email", using: :btree
  add_index "speakers", ["session_token"], name: "index_speakers_on_session_token", using: :btree
  add_index "speakers", ["speaker_history_id"], name: "index_speakers_on_speaker_history_id", using: :btree
  add_index "speakers", ["verification_id"], name: "index_speakers_on_verification_id", using: :btree

  create_table "verifications", force: :cascade do |t|
    t.integer  "speaker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "verifications", ["speaker_id"], name: "index_verifications_on_speaker_id", using: :btree

  create_table "voices", force: :cascade do |t|
    t.integer  "speaker_id"
    t.integer  "choice_id"
    t.integer  "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "issue_id"
  end

  add_index "voices", ["choice_id"], name: "index_voices_on_choice_id", using: :btree
  add_index "voices", ["issue_id"], name: "index_voices_on_issue_id", using: :btree
  add_index "voices", ["speaker_id"], name: "index_voices_on_speaker_id", using: :btree

  add_foreign_key "choices", "issues"
  add_foreign_key "choices", "speakers"
  add_foreign_key "comments", "speakers"
  add_foreign_key "issues", "speakers"
  add_foreign_key "proposals", "speakers"
  add_foreign_key "speaker_histories", "speakers"
  add_foreign_key "speakers", "speaker_histories"
  add_foreign_key "speakers", "verifications"
  add_foreign_key "verifications", "speakers"
  add_foreign_key "voices", "choices"
  add_foreign_key "voices", "issues"
  add_foreign_key "voices", "speakers"
end
