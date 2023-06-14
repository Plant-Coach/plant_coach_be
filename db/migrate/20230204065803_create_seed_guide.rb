class CreateSeedGuide < ActiveRecord::Migration[5.2]
  def change
    create_table :seed_guides do |t|
      t.string :plant_type
      t.boolean :direct_seed_recommended
      t.boolean :recommended_transplant_date
      t.boolean :recommended_seed_start_date
      t.integer :seedling_days_to_transplant
      t.references :plant_coach_guide, foreign_key: true

      t.timestamps
    end
  end
end
