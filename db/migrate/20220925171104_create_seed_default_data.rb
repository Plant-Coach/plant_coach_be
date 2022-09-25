class CreateSeedDefaultData < ActiveRecord::Migration[5.2]
  def change
    create_table :seed_default_data do |t|
      t.string :plant_type
      t.integer :days_to_maturity
      t.integer :seed_days_to_transplant

      t.timestamps
    end
  end
end
