class AddRecommendedTransplantDateToGardenPlant < ActiveRecord::Migration[5.2]
  def change
    add_column :garden_plants, :recommended_transplant_date, :date
  end
end
