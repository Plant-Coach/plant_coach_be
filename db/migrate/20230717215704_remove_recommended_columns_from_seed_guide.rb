class RemoveRecommendedColumnsFromSeedGuide < ActiveRecord::Migration[5.2]
  def change
    remove_column :seed_guides, :recommended_transplant_date
    remove_column :seed_guides, :recommended_seed_start_date
  end
end
