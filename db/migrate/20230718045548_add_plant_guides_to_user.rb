class AddPlantGuidesToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :plant_guides, :user, foreign_key: true
  end
end
