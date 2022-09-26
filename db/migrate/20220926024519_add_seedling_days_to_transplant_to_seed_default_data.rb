class AddSeedlingDaysToTransplantToSeedDefaultData < ActiveRecord::Migration[5.2]
  def change
    add_column :seed_default_data, :seedling_days_to_transplant, :integer
  end
end
