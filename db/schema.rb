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

ActiveRecord::Schema.define(version: 20160128094202) do

  create_table "admins", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "deals", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.text     "description",      limit: 65535
    t.decimal  "price",                          precision: 8, scale: 2
    t.decimal  "discounted_price",               precision: 8, scale: 2
    t.integer  "quantity",         limit: 4,                             default: 0
    t.date     "publish_date"
    t.boolean  "publishable",                                            default: false, null: false
    t.boolean  "live",                                                   default: false, null: false
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
  end

  create_table "orders", force: :cascade do |t|
    t.decimal  "sale_price",           precision: 8, scale: 2
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "user_id",    limit: 4
    t.integer  "deal_id",    limit: 4
    t.integer  "discount",   limit: 4
  end

  add_index "orders", ["deal_id"], name: "index_orders_on_deal_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "orders_count", limit: 4,   default: 0
  end

  add_foreign_key "orders", "deals"
  add_foreign_key "orders", "users"
end
