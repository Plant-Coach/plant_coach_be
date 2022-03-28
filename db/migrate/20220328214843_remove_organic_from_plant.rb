class RemoveOrganicFromPlant < ActiveRecord::Migration[5.2]
  def change
    remove_column :plants, :organic
  end
end
