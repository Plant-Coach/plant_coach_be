class RemoveSeedlingDaysToTransplantFromGardenPlants < ActiveRecord::Migration[5.2]
  def change
    remove_column :garden_plants, :seedling_days_to_transplant
  end
end
