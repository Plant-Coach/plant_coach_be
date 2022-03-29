class RemoveStartFromSeedFromUserPlants < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_plants, :start_from_seed
  end
end
