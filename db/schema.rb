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

ActiveRecord::Schema.define(version: 2020_03_27_160407) do

  create_table "cart_items", force: :cascade do |t|
    t.integer "item_id"
    t.integer "user_id"
    t.string "item_name"
    t.float "total_price"
  end

  create_table "discounts", force: :cascade do |t|
    t.string "name"
    t.integer "value"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.integer "stock"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password"
  end

end
