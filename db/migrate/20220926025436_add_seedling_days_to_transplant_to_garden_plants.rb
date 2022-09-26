class AddSeedlingDaysToTransplantToGardenPlants < ActiveRecord::Migration[5.2]
  def change
    add_column :garden_plants, :seedling_days_to_transplant, :integer
  end
end
