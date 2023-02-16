class AddDirectSeedUserDecisionToGardenPlants < ActiveRecord::Migration[5.2]
  def change
    add_column :garden_plants, :direct_seeded, :boolean, null: false, default: false
  end
end
