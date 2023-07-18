class CreatePlantGuide < ActiveRecord::Migration[5.2]
  def change
    create_table :plant_guides do |t|
      t.string :plant_type
      t.boolean :direct_seed_recommended
      t.integer :seedling_days_to_transplant
      t.integer :days_to_maturity
      t.integer :days_relative_to_frost_date
      t.string :harvest_period

      t.timestamps
    end
  end
end
