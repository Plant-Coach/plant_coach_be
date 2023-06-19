class AddHarvestPeriodToGardenPlants < ActiveRecord::Migration[5.2]
  def change
    add_column :garden_plants, :harvest_period, :integer, default: 0, null: false
  end
end
