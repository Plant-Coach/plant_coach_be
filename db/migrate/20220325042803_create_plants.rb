class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.string :type
      t.string :name
      t.string :latin_name
      t.integer :days_to_maturity
      t.integer :hybrid_status
      t.boolean :organic
      t.boolean :from_seed

      t.timestamps
    end
  end
end
