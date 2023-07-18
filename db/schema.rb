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

ActiveRecord::Schema.define(version: 2023_07_17_223244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "garden_plants", force: :cascade do |t|
    t.string "plant_type"
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

  create_table "harvest_coachings", force: :cascade do |t|
    t.bigint "harvest_guide_id"
    t.bigint "garden_plant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["garden_plant_id"], name: "index_harvest_coachings_on_garden_plant_id"
    t.index ["harvest_guide_id"], name: "index_harvest_coachings_on_harvest_guide_id"
  end

  create_table "harvest_guides", force: :cascade do |t|
    t.string "plant_type"
    t.string "harvest_period"
    t.bigint "plant_coach_guide_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_coach_guide_id"], name: "index_harvest_guides_on_plant_coach_guide_id"
  end

  create_table "plant_coach_guides", force: :cascade do |t|
    t.string "plant_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "seed_coachings", force: :cascade do |t|
    t.date "when_to_remind"
    t.boolean "remind"
    t.bigint "seed_guide_id"
    t.bigint "garden_plant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["garden_plant_id"], name: "index_seed_coachings_on_garden_plant_id"
    t.index ["seed_guide_id"], name: "index_seed_coachings_on_seed_guide_id"
  end

  create_table "seed_guides", force: :cascade do |t|
    t.string "plant_type"
    t.boolean "direct_seed_recommended"
    t.integer "seedling_days_to_transplant"
    t.bigint "plant_coach_guide_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_coach_guide_id"], name: "index_seed_guides_on_plant_coach_guide_id"
  end

  create_table "transplant_coachings", force: :cascade do |t|
    t.date "when_to_remind"
    t.boolean "remind"
    t.bigint "transplant_guide_id"
    t.bigint "garden_plant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["garden_plant_id"], name: "index_transplant_coachings_on_garden_plant_id"
    t.index ["transplant_guide_id"], name: "index_transplant_coachings_on_transplant_guide_id"
  end

  create_table "transplant_guides", force: :cascade do |t|
    t.string "plant_type"
    t.integer "days_to_maturity"
    t.integer "days_relative_to_frost_date"
    t.bigint "plant_coach_guide_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_coach_guide_id"], name: "index_transplant_guides_on_plant_coach_guide_id"
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
  add_foreign_key "harvest_coachings", "garden_plants"
  add_foreign_key "harvest_coachings", "harvest_guides"
  add_foreign_key "harvest_guides", "plant_coach_guides"
  add_foreign_key "plants", "users"
  add_foreign_key "seed_coachings", "garden_plants"
  add_foreign_key "seed_coachings", "seed_guides"
  add_foreign_key "seed_guides", "plant_coach_guides"
  add_foreign_key "transplant_coachings", "garden_plants"
  add_foreign_key "transplant_coachings", "transplant_guides"
  add_foreign_key "transplant_guides", "plant_coach_guides"
end
