class AddDefaultStatusToPlantsHybridStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :plants, :hybrid_status, from: nil, to: 0
  end
end
