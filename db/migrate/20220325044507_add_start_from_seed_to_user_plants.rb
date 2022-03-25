class AddStartFromSeedToUserPlants < ActiveRecord::Migration[5.2]
  def change
    add_column :user_plants, :start_from_seed, :boolean
  end
end
