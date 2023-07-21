class DropSeedGuides < ActiveRecord::Migration[5.2]
  def change
    drop_table :seed_guides
  end
end
