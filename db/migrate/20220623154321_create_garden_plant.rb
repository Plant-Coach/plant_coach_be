class CreateGardenPlant < ActiveRecord::Migration[5.2]
  def change
    create_table :garden_plants do |t|
      t.string :name
      t.integer :days_to_maturity
      t.integer :hybrid_status, null: false, default: 0
      t.integer :days_relative_to_frost_date
      t.string :plant_type
      t.references :user, foreign_key: true
      t.boolean :organic, null: false, default: false
      t.integer :seed_sew_type, null: false, default: 0
      t.boolean :direct_seed_recommended, null: false
      t.date :actual_transplant_date
      t.integer :seedling_days_to_transplant
      t.date :actual_seed_sewing_date
      t.date :recommended_seed_sewing_date
      t.boolean :start_from_seed, null: false, default: false
      t.integer :planting_status, null: false, default: 0
      t.date :recommended_transplant_date


      t.timestamps
    end
  end
end
