class RemoveFromSeedFromPlants < ActiveRecord::Migration[5.2]
  def change
    remove_column :plants, :from_seed
  end
end
