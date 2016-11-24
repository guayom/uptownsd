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

ActiveRecord::Schema.define(version: 20161124112959) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "bets", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "game_line_id"
    t.integer  "team_id"
    t.decimal  "risk"
    t.integer  "status",       default: 1, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "kind"
    t.integer  "parlay_id"
  end

  add_index "bets", ["game_line_id"], name: "index_bets_on_game_line_id", using: :btree
  add_index "bets", ["team_id"], name: "index_bets_on_team_id", using: :btree
  add_index "bets", ["user_id"], name: "index_bets_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
  end

  create_table "game_lines", force: :cascade do |t|
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "sport_id"
    t.integer  "league_id"
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.integer  "limit"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "active",                default: false
    t.integer  "team1_odds"
    t.integer  "team2_odds"
    t.datetime "time"
    t.string   "team1_line"
    t.string   "team1_total"
    t.string   "team2_line"
    t.string   "team2_total"
    t.text     "place"
    t.integer  "spread_pts_team_1"
    t.integer  "spread_pts_team_2"
    t.integer  "spread_val_team_1"
    t.integer  "spread_val_team_2"
    t.integer  "over_under_total"
    t.integer  "over_under_val_team_1"
    t.integer  "over_under_val_team_2"
    t.integer  "money_line_team_1"
    t.integer  "money_line_team_2"
    t.integer  "result_team_1"
    t.integer  "result_team_2"
  end

  create_table "game_results", force: :cascade do |t|
    t.integer  "game_line_id", null: false
    t.integer  "team_id",      null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "game_results", ["game_line_id"], name: "index_game_results_on_game_line_id", using: :btree
  add_index "game_results", ["team_id"], name: "index_game_results_on_team_id", using: :btree

  create_table "leagues", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "sport_id"
    t.string   "abbreviation"
  end

  create_table "promotions", force: :cascade do |t|
    t.string   "title"
    t.text     "excerpt"
    t.text     "description"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "active",             default: true
  end

  create_table "slides", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "link"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "slide_text"
  end

  create_table "sports", force: :cascade do |t|
    t.string   "title"
    t.string   "color"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "sport_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "kind",       null: false
    t.integer  "bet_id"
    t.decimal  "amount",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "confirmed"
  end

  add_index "transactions", ["bet_id"], name: "index_transactions_on_bet_id", using: :btree
  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "neteller"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "bets", "game_lines"
  add_foreign_key "bets", "teams"
  add_foreign_key "bets", "users"
  add_foreign_key "game_results", "game_lines"
  add_foreign_key "game_results", "teams"
  add_foreign_key "transactions", "bets"
  add_foreign_key "transactions", "users"
end
