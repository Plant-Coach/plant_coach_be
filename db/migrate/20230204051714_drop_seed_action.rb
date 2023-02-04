class DropSeedAction < ActiveRecord::Migration[5.2]
  def change
    drop_table :seed_actions
  end
end
