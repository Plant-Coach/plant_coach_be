class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.string :plant_type
      t.string :name
      t.integer :days_to_maturity
      t.integer :hybrid_status, default: 0
      t.boolean :organic, null: false, default: false
      t.integer :days_relative_to_frost_date

      t.timestamps
    end
  end
end
