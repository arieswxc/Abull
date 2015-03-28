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

ActiveRecord::Schema.define(version: 20150328045101) do

  create_table "accounts", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.decimal  "balance",              precision: 12, scale: 2, default: 0.0
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.decimal  "frost",                precision: 12, scale: 2
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   limit: 255
    t.string   "cell",                   limit: 255
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "bank_cards", force: :cascade do |t|
    t.string   "number",      limit: 255
    t.string   "bank_name",   limit: 255
    t.string   "bank_branch", limit: 255
    t.integer  "user_id",     limit: 4
    t.string   "state",       limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "bank_cards", ["user_id"], name: "index_bank_cards_on_user_id", using: :btree

  create_table "billings", force: :cascade do |t|
    t.integer  "account_id",    limit: 4
    t.decimal  "amount",                    precision: 12, scale: 2, default: 0.0
    t.string   "billing_type",  limit: 255
    t.integer  "billable_id",   limit: 4
    t.string   "billable_type", limit: 255
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
  end

  add_index "billings", ["account_id"], name: "index_billings_on_account_id", using: :btree
  add_index "billings", ["billable_type", "billable_id"], name: "index_billings_on_billable_type_and_billable_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50,    default: ""
    t.text     "comment",          limit: 65535
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "user_id",          limit: 4
    t.string   "role",             limit: 255,   default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",   limit: 4,                   null: false
    t.string   "followable_type", limit: 255,                 null: false
    t.integer  "follower_id",     limit: 4,                   null: false
    t.string   "follower_type",   limit: 255,                 null: false
    t.boolean  "blocked",         limit: 1,   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "funds", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.integer  "user_id",               limit: 4
    t.decimal  "amount",                              precision: 12, scale: 2
    t.decimal  "earning",                             precision: 12, scale: 2, default: 0.0
    t.decimal  "earning_rate",                        precision: 12, scale: 4
    t.string   "state",                 limit: 255
    t.string   "private_check",         limit: 255,                            default: "private"
    t.decimal  "minimum",                             precision: 12, scale: 2
    t.datetime "invest_starting_date"
    t.datetime "created_at",                                                                       null: false
    t.datetime "updated_at",                                                                       null: false
    t.decimal  "expected_earning_rate",               precision: 12, scale: 4
    t.text     "description",           limit: 65535
    t.text     "frontend_risk_method",  limit: 65535
    t.decimal  "initial_amount",                      precision: 12, scale: 2
    t.text     "backend_risk_method",   limit: 65535
    t.integer  "homs_account",          limit: 4
    t.integer  "duration",              limit: 4
    t.string   "genre",                 limit: 255
    t.boolean  "mandate",               limit: 1
    t.integer  "ending_days",           limit: 4
    t.integer  "private_code",          limit: 4
  end

  add_index "funds", ["user_id"], name: "index_funds_on_user_id", using: :btree

  create_table "homs_accounts", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "password",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "fund_id",    limit: 4
  end

  add_index "homs_accounts", ["fund_id"], name: "index_homs_accounts_on_fund_id", using: :btree

  create_table "interests", force: :cascade do |t|
    t.integer  "leverage_time",   limit: 4,                                              null: false
    t.decimal  "amount",                      precision: 12, scale: 2, default: 0.0,     null: false
    t.integer  "duration",        limit: 4,                                              null: false
    t.decimal  "interest_rate",               precision: 12, scale: 2,                   null: false
    t.decimal  "managerment_fee",             precision: 12, scale: 2
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.string   "show",            limit: 255,                          default: "false"
  end

  create_table "invests", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "fund_id",    limit: 4
    t.decimal  "amount",               precision: 12, scale: 2, default: 0.0
    t.datetime "date"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.decimal  "payback",              precision: 12, scale: 2
    t.datetime "close_day"
  end

  add_index "invests", ["fund_id"], name: "index_invests_on_fund_id", using: :btree
  add_index "invests", ["user_id"], name: "index_invests_on_user_id", using: :btree

  create_table "leverages", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.datetime "date"
    t.decimal  "amount",                          precision: 12, scale: 2
    t.text     "description",       limit: 65535
    t.string   "state",             limit: 255
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.integer  "interest_id",       limit: 4
    t.integer  "duration",          limit: 4
    t.integer  "loss_warning_line", limit: 4
    t.integer  "loss_making_line",  limit: 4
    t.integer  "rate",              limit: 4
    t.integer  "total_interests",   limit: 4
    t.integer  "deposit",           limit: 4
    t.integer  "leverage_amount",   limit: 4
  end

  add_index "leverages", ["interest_id"], name: "index_leverages_on_interest_id", using: :btree
  add_index "leverages", ["user_id"], name: "index_leverages_on_user_id", using: :btree

  create_table "news", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.datetime "date"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.string   "photo",          limit: 255
    t.integer  "user_id",        limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "imageable_id",   limit: 255
    t.string   "imageable_type", limit: 255
  end

  add_index "photos", ["user_id"], name: "index_photos_on_user_id", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.datetime "date"
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar",                 limit: 255
    t.string   "cell",                   limit: 255
    t.string   "username",               limit: 255
    t.string   "real_name",              limit: 255
    t.string   "id_card_number",         limit: 255
    t.text     "abstract",               limit: 65535
    t.string   "level",                  limit: 255
    t.date     "birthday"
    t.string   "gender",                 limit: 255
    t.string   "education",              limit: 255
    t.string   "address",                limit: 255
    t.string   "job",                    limit: 255
    t.string   "verify_file",            limit: 255
    t.string   "line_csv",               limit: 255
    t.string   "address_photo",          limit: 255
    t.string   "education_photo",        limit: 255
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "accounts", "users"
  add_foreign_key "bank_cards", "users"
  add_foreign_key "billings", "accounts"
  add_foreign_key "funds", "users"
  add_foreign_key "homs_accounts", "funds"
  add_foreign_key "invests", "funds"
  add_foreign_key "invests", "users"
  add_foreign_key "leverages", "interests"
  add_foreign_key "leverages", "users"
  add_foreign_key "photos", "users"
  add_foreign_key "topics", "users"
end
