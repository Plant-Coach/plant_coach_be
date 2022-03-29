class RemoveLatinNameFromPlant < ActiveRecord::Migration[5.2]
  def change
    remove_column :plants, :latin_name
  end
end
