class DropHarvestCoachings < ActiveRecord::Migration[5.2]
  def change
    drop_table :harvest_coachings
  end
end
