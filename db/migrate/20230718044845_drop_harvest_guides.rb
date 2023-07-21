class DropHarvestGuides < ActiveRecord::Migration[5.2]
  def change
    drop_table :harvest_guides
  end
end
