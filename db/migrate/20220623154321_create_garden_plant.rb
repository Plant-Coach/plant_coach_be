class CreateGardenPlant < ActiveRecord::Migration[5.2]
  def change
    create_table :garden_plants do |t|
      t.string :name
      t.integer :days_to_maturity
      t.integer :hybrid_status
      t.integer :days_relative_to_frost_date
      t.string :plant_type
      t.references :user, foreign_key: true
      t.boolean :organic

      t.timestamps
    end
  end
end
