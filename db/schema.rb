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

ActiveRecord::Schema.define(version: 2022_09_25_035225) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "garden_coachings", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "days_to_remind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "garden_plant_actions", force: :cascade do |t|
    t.bigint "garden_plant_id"
    t.bigint "garden_plant_coaching_id"
    t.index ["garden_plant_coaching_id"], name: "index_garden_plant_actions_on_garden_plant_coaching_id"
    t.index ["garden_plant_id"], name: "index_garden_plant_actions_on_garden_plant_id"
  end

  create_table "garden_plant_coachings", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "days_to_remind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "garden_plants", force: :cascade do |t|
    t.string "name"
    t.integer "days_to_maturity"
    t.integer "hybrid_status"
    t.integer "days_relative_to_frost_date"
    t.string "plant_type"
    t.bigint "user_id"
    t.boolean "organic", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "recommended_transplant_date"
    t.integer "planting_status", default: 0, null: false
    t.boolean "start_from_seed", default: false, null: false
    t.date "recommended_seed_sewing_date"
    t.date "actual_seed_sewing_date"
    t.date "seedling_days_to_transplant"
    t.index ["user_id"], name: "index_garden_plants_on_user_id"
  end

  create_table "garden_user_coachings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "garden_coaching_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["garden_coaching_id"], name: "index_garden_user_coachings_on_garden_coaching_id"
    t.index ["user_id"], name: "index_garden_user_coachings_on_user_id"
  end

  create_table "planting_guides", force: :cascade do |t|
    t.string "plant_type"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plants", force: :cascade do |t|
    t.string "name"
    t.integer "days_to_maturity"
    t.integer "hybrid_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "days_relative_to_frost_date"
    t.string "plant_type"
    t.bigint "user_id"
    t.boolean "organic", default: false, null: false
    t.index ["user_id"], name: "index_plants_on_user_id"
  end

  create_table "seed_actions", force: :cascade do |t|
    t.bigint "garden_plant_id"
    t.bigint "seed_coaching_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["garden_plant_id"], name: "index_seed_actions_on_garden_plant_id"
    t.index ["seed_coaching_id"], name: "index_seed_actions_on_seed_coaching_id"
  end

  create_table "seed_coachings", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "days_to_remind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "zip_code"
    t.string "spring_frost_dates"
    t.string "fall_frost_dates"
  end

  add_foreign_key "garden_plant_actions", "garden_plant_coachings"
  add_foreign_key "garden_plant_actions", "garden_plants"
  add_foreign_key "garden_plants", "users"
  add_foreign_key "garden_user_coachings", "garden_coachings"
  add_foreign_key "garden_user_coachings", "users"
  add_foreign_key "plants", "users"
  add_foreign_key "seed_actions", "garden_plants"
  add_foreign_key "seed_actions", "seed_coachings"
end
