class AddHarvestDatesToGardenPlants < ActiveRecord::Migration[5.2]
  def change
    add_column :garden_plants, :harvest_start, :date
    add_column :garden_plants, :harvest_finish, :date
  end
end
