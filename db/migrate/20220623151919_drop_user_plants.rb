class DropUserPlants < ActiveRecord::Migration[5.2]
  def change
    drop_table :user_plants
  end
end
