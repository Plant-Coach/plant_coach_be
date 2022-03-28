class RemoveTypeFromPlant < ActiveRecord::Migration[5.2]
  def change
    remove_column :plants, :type
  end
end
