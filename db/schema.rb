# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_07_21_042950) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "garden_plants", force: :cascade do |t|
    t.integer "seed_sew_type", default: 0, null: false
    t.boolean "direct_seed_recommended", null: false
    t.date "actual_transplant_date"
    t.integer "seedling_days_to_transplant"
    t.date "actual_seed_sewing_date"
    t.date "recommended_seed_sewing_date"
    t.boolean "start_from_seed", default: false, null: false
    t.integer "planting_status", default: 0, null: false
    t.date "recommended_transplant_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "harvest_start"
    t.date "harvest_finish"
    t.integer "harvest_period", default: 0, null: false
    t.bigint "plant_id"
    t.index ["plant_id"], name: "index_garden_plants_on_plant_id"
  end

  create_table "plant_guides", force: :cascade do |t|
    t.string "plant_type"
    t.boolean "direct_seed_recommended"
    t.integer "seedling_days_to_transplant"
    t.integer "days_to_maturity"
    t.integer "days_relative_to_frost_date"
    t.string "harvest_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_plant_guides_on_user_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string "plant_type"
    t.string "name"
    t.integer "days_to_maturity"
    t.integer "hybrid_status", default: 0
    t.boolean "organic", default: false, null: false
    t.integer "days_relative_to_frost_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "harvest_period", default: 0, null: false
    t.index ["user_id"], name: "index_plants_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "zip_code"
    t.string "spring_frost_date"
    t.string "fall_frost_date"
  end

  add_foreign_key "garden_plants", "plants"
  add_foreign_key "plant_guides", "users"
  add_foreign_key "plants", "users"
end
