class FixSeedStartTypeName < ActiveRecord::Migration[7.0]
  def change
    rename_column :garden_plants, :seed_sew_type, :plant_start_method
  end
end
