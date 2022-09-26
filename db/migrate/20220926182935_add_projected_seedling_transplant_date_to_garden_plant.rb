class AddProjectedSeedlingTransplantDateToGardenPlant < ActiveRecord::Migration[5.2]
  def change
    add_column :garden_plants, :projected_seedling_transplant_date, :date
  end
end
