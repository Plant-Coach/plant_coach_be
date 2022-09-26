class RemoveSeedDaysToTransplantFromSeedDefaultData < ActiveRecord::Migration[5.2]
  def change
    remove_column :seed_default_data, :seed_days_to_transplant
  end
end
