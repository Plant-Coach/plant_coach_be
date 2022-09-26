class AddDirectSeedToSeedDefaultData < ActiveRecord::Migration[5.2]
  def change
    add_column :seed_default_data, :direct_seed, :integer
  end
end
