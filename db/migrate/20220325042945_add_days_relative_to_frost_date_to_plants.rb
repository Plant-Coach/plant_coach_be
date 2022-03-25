class AddDaysRelativeToFrostDateToPlants < ActiveRecord::Migration[5.2]
  def change
    add_column :plants, :days_relative_to_frost_date, :integer
  end
end
