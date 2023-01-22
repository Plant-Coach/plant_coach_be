class RemoveDirectSeedFromSeedDefaultData < ActiveRecord::Migration[5.2]
  def change
    remove_column :seed_default_data, :direct_seed, :integer
  end
end
