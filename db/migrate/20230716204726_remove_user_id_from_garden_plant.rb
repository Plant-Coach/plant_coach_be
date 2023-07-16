class RemoveUserIdFromGardenPlant < ActiveRecord::Migration[5.2]
  def change
    remove_column :garden_plants, :user_id
  end
end
