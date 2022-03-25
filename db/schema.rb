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

ActiveRecord::Schema.define(version: 2022_03_25_044507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "plants", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "latin_name"
    t.integer "days_to_maturity"
    t.integer "hybrid_status"
    t.boolean "organic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "days_relative_to_frost_date"
  end

  create_table "user_plants", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "plant_id"
    t.boolean "start_from_seed"
    t.index ["plant_id"], name: "index_user_plants_on_plant_id"
    t.index ["user_id"], name: "index_user_plants_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
  end

  add_foreign_key "user_plants", "plants"
  add_foreign_key "user_plants", "users"
end
