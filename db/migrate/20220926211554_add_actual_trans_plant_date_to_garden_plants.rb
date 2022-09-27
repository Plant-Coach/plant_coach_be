class AddActualTransPlantDateToGardenPlants < ActiveRecord::Migration[5.2]
  def change
    add_column :garden_plants, :actual_transplant_date, :date
  end
end
