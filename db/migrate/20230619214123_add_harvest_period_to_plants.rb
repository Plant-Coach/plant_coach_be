class AddHarvestPeriodToPlants < ActiveRecord::Migration[5.2]
  def change
    add_column :plants, :harvest_period, :integer, null: false, default: 0
  end
end
