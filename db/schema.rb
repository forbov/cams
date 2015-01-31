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

ActiveRecord::Schema.define(version: 20141217095759) do

  create_table "addresses", force: true do |t|
    t.string   "address_line_1",                                       null: false
    t.string   "address_line_2"
    t.string   "city",                                                 null: false
    t.decimal  "postcode",                     precision: 4, scale: 0, null: false
    t.string   "state_code",        limit: 10,                         null: false
    t.string   "address_type_code", limit: 10
    t.integer  "asset_id"
    t.integer  "council_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["asset_id"], name: "index_addresses_on_asset_id", using: :btree
  add_index "addresses", ["council_id"], name: "index_addresses_on_council_id", using: :btree

  create_table "asset_assessments", force: true do |t|
    t.integer  "council_report_id",                             null: false
    t.integer  "asset_id",                                      null: false
    t.integer  "priority_item_id",                              null: false
    t.decimal  "asset_priority_value", precision: 10, scale: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "asset_assessments", ["asset_id"], name: "index_asset_assessments_on_asset_id", using: :btree
  add_index "asset_assessments", ["council_report_id"], name: "index_asset_assessments_on_council_report_id", using: :btree
  add_index "asset_assessments", ["priority_item_id"], name: "index_asset_assessments_on_priority_item_id", using: :btree

  create_table "asset_components", force: true do |t|
    t.integer  "asset_id",     null: false
    t.integer  "component_id", null: false
    t.text     "requirement",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "asset_components", ["asset_id"], name: "index_asset_components_on_asset_id", using: :btree
  add_index "asset_components", ["component_id"], name: "index_asset_components_on_component_id", using: :btree

  create_table "asset_priority_items", force: true do |t|
    t.integer  "asset_id",         null: false
    t.integer  "priority_item_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "asset_priority_items", ["asset_id"], name: "index_asset_priority_items_on_asset_id", using: :btree
  add_index "asset_priority_items", ["priority_item_id"], name: "index_asset_priority_items_on_priority_item_id", using: :btree

  create_table "assets", force: true do |t|
    t.string   "asset_name",                 null: false
    t.string   "asset_type_code", limit: 10, null: false
    t.integer  "council_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["council_id"], name: "index_assets_on_council_id", using: :btree

  create_table "components", force: true do |t|
    t.string   "asset_type_code",     limit: 10, null: false
    t.string   "component_name",                 null: false
    t.string   "component_desc",                 null: false
    t.text     "default_requirement"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "council_asset_types", force: true do |t|
    t.integer  "council_id"
    t.string   "asset_type_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "council_asset_types", ["council_id"], name: "index_council_asset_types_on_council_id", using: :btree

  create_table "council_priority_weights", force: true do |t|
    t.integer  "council_id",                                null: false
    t.integer  "priority_item_id",                          null: false
    t.decimal  "priority_weight",  precision: 10, scale: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "council_priority_weights", ["council_id"], name: "index_council_priority_weights_on_council_id", using: :btree
  add_index "council_priority_weights", ["priority_item_id"], name: "index_council_priority_weights_on_priority_item_id", using: :btree

  create_table "council_reports", force: true do |t|
    t.integer  "council_id",       null: false
    t.string   "report_title",     null: false
    t.text     "report_desc",      null: false
    t.datetime "report_date",      null: false
    t.integer  "user_id",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "report_generated"
  end

  add_index "council_reports", ["council_id"], name: "index_council_reports_on_council_id", using: :btree

  create_table "councils", force: true do |t|
    t.string   "council_name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "priority_item_values", force: true do |t|
    t.integer  "priority_item_id",                          null: false
    t.decimal  "valid_value",      precision: 10, scale: 0, null: false
    t.string   "value_desc",                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "priority_item_values", ["priority_item_id"], name: "index_priority_item_values_on_priority_item_id", using: :btree

  create_table "priority_items", force: true do |t|
    t.string   "priority_category_code",                          null: false
    t.string   "priority_item_desc",                              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "default_weight",         precision: 10, scale: 0, null: false
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.decimal  "price",      precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposed_works", force: true do |t|
    t.integer  "council_report_id",                            null: false
    t.integer  "asset_component_id",                           null: false
    t.string   "proposed_work",                                null: false
    t.string   "priority_level_code",                          null: false
    t.decimal  "work_cost",           precision: 10, scale: 0, null: false
    t.string   "cost_type_code",                               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "proposed_works", ["asset_component_id"], name: "index_proposed_works_on_asset_component_id", using: :btree
  add_index "proposed_works", ["council_report_id"], name: "index_proposed_works_on_council_report_id", using: :btree

  create_table "report_assets", force: true do |t|
    t.integer  "council_report_id", null: false
    t.integer  "asset_id",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "report_assets", ["council_report_id"], name: "index_report_assets_on_council_report_id", using: :btree

  create_table "system_codes", id: false, force: true do |t|
    t.string "system_code_type", limit: 10, null: false
    t.string "system_code",      limit: 20, null: false
    t.string "system_code_desc", limit: 45, null: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                      null: false
    t.string   "password_digest",            null: false
    t.integer  "council_id"
    t.string   "user_role_code",  limit: 10, null: false
    t.string   "first_name",                 null: false
    t.string   "last_name",                  null: false
    t.string   "contact_phone",   limit: 10, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "users", ["council_id"], name: "index_users_on_council_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
