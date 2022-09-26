class AddDaysRelativeToFrostDateToSeedDefaultData < ActiveRecord::Migration[5.2]
  def change
    add_column :seed_default_data, :days_relative_to_frost_date, :integer
  end
end
